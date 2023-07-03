import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  int _page = 0;
  final int _limit = 20;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  bool _isRefreshing = false;

  List _posts = [];

  TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res = await http.get(Uri.parse(
            "$_baseUrl?_page=$_page&_limit=$_limit&q=$_searchKeyword"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res = await http.get(Uri.parse(
          "$_baseUrl?_page=$_page&_limit=$_limit&q=$_searchKeyword"));
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
      _page = 0;
      _hasNextPage = true;
      _posts.clear();
    });

    try {
      final res = await http.get(Uri.parse(
          "$_baseUrl?_page=$_page&_limit=$_limit&q=$_searchKeyword"));
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isRefreshing = false;
    });
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your news',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchKeyword = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      itemCount: _posts.length,
                      controller: _controller,
                      itemBuilder: (_, index) => Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: ListTile(
                          title: Text(_posts[index]['title']),
                          subtitle: Text(_posts[index]['body']),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }
}

// var response = await http.get(
//   Uri.parse("https://simponik.kedirikota.go.id/api/inbox?id=$id&param=all"),
//   headers: requestHeaders,
// );

// if (response.statusCode == 200) {
//   final bd = jsonDecode(response.body);
//   List data = bd['inbox'];
//   suratMasuk.addAll(data.map((element) => SuratMasuk.fromJson(element)));

//   // Cek jika masih ada halaman selanjutnya
//   while (bd['next_page_url'] != null) {
//     var nextPageUrl = bd['next_page_url'];
//     var nextPageResponse = await http.get(Uri.parse(nextPageUrl), headers: requestHeaders);

//     if (nextPageResponse.statusCode == 200) {
//       final nextPageData = jsonDecode(nextPageResponse.body);
//       List nextPageDataList = nextPageData['inbox'];
//       suratMasuk.addAll(nextPageDataList.map((element) => SuratMasuk.fromJson(element)));
//       bd = nextPageData;
//     } else {
//       // Handle jika gagal mendapatkan halaman selanjutnya
//       break;
//     }
//   }

//   // Lakukan hal yang sama untuk data surat keluar
//   var response2 = await http.get(
//     Uri.parse("https://simponik.kedirikota.go.id/api/outbox?id=$id&param=all"),
//     headers: requestHeaders,
//   );

//   if (response2.statusCode == 200) {
//     final bd2 = jsonDecode(response2.body);
//     List data2 = bd2['outbox'];
//     suratKeluar.addAll(data2.map((element) => SuratKeluar.fromJson(element)));

//     // Cek jika masih ada halaman selanjutnya
//     while (bd2['next_page_url'] != null) {
//       var nextPageUrl2 = bd2['next_page_url'];
//       var nextPageResponse2 = await http.get(Uri.parse(nextPageUrl2), headers: requestHeaders);

//       if (nextPageResponse2.statusCode == 200) {
//         final nextPageData2 = jsonDecode(nextPageResponse2.body);
//         List nextPageDataList2 = nextPageData2['outbox'];
//         suratKeluar.addAll(nextPageDataList2.map((element) => SuratKeluar.fromJson(element)));
//         bd2 = nextPageData2;
//       } else {
//         // Handle jika gagal mendapatkan halaman selanjutnya
//         break;
//       }
//     }

//     totalSurat = bd['total'];
//     totalSuratKeluar = bd2['total'];
//     totalProses = suratMasuk.where((item) => item.state != "SELESAI").length;
//     totalSelesai = suratMasuk.where((item) => item.state == "SELESAI").length;
//     totalUnread = suratMasuk.where((item) => item.isBaca != "1").length;
//     totalUnread2 = suratKeluar.where((item) => item.isBaca != "1").length;
//     totalUnkonf = suratKeluar.where((item) => item.state != "DISETUJUI").length;
//   }
// }

// Future<bool> getDbSurat() async {
//   try {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     setState(() {
//       token = pref.getString("token")!;
//       id = pref.getString("id")!;
//     });
    
//     if (token != '') {
//       Map<String, String> requestHeaders = {
//         'Authorization': token,
//       };
      
//       List<SuratMasuk> allSuratMasuk = [];
//       List<SuratKeluar> allSuratKeluar = [];
      
//       int currentPage = 1;
//       bool isNextPageAvailable = true;
      
//       while (isNextPageAvailable) {
//         var response = await http.get(
//           Uri.parse("https://simponik.kedirikota.go.id/api/inbox?id=$id&param=all&page=$currentPage"),
//           headers: requestHeaders,
//         );
        
//         if (response.statusCode == 200) {
//           final bd = jsonDecode(response.body);
//           List data = bd['inbox'];
//           if (data.isEmpty) {
//             isNextPageAvailable = false;
//           } else {
//             data.forEach((element) {
//               allSuratMasuk.add(SuratMasuk.fromJson(element));
//             });
//             currentPage++;
//           }

//         } else {
//           return false;
//         }
//       }
      
//       int currentPage2 = 1;
//       isNextPageAvailable = true;
      
//       while (isNextPageAvailable) {
//         var response2 = await http.get(
//           Uri.parse("https://simponik.kedirikota.go.id/api/outbox?id=$id&param=all&page=$currentPage2"),
//           headers: requestHeaders,
//         );
        
//         if (response2.statusCode == 200) {
//           final bd2 = jsonDecode(response2.body);
//           List data2 = bd2['outbox'];
//           if (data2.isEmpty) {
//             isNextPageAvailable = false;
//           } else {
//             data2.forEach((element) {
//               allSuratKeluar.add(SuratKeluar.fromJson(element));
//             });
//             currentPage2++;
//           }
//         } else {
//           return false;
//         }
//       }
      
//       // Setelah mendapatkan semua data, Anda dapat melakukan proses sesuai kebutuhan
//       suratMasuk.addAll(allSuratMasuk);
//       suratKeluar.addAll(allSuratKeluar);
      
//       totalSurat = bd['total'];
//       totalSuratKeluar = bd2['total'];
//       totalProses = suratMasuk.where((item) => item.state != "SELESAI").length;
//       totalSelesai = suratMasuk.where((item) => item.state == "SELESAI").length;
//       totalUnread = suratMasuk.where((item) => item.isbaca != "1").length;
//       totalUnread2 = suratKeluar.where((item) => item.isbaca != "1").length;
//       totalUnkonf = suratKeluar.where((item) => item.state != "DISETUJUI").length;

//       setState(() {});
//       return true;
//     } else {
//       return false;
//     }
//   } catch (e) {
//     print(e);
//     return false;
//   }
// }

