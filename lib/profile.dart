import 'package:e_surat/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

const color1 = Color.fromARGB(255, 27, 0, 71);
const color2 = Color.fromARGB(255, 27, 0, 71);
const color3 = Color.fromARGB(255, 255, 255, 255);
const color4 = Color(0xFFC1F8CF);
const color5 = Color.fromARGB(255, 212, 0, 255);

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color1;
    Path path = Path()
      ..relativeLineTo(0, 200)
      ..quadraticBezierTo(size.width / 2, 300, size.width, 200)
      ..relativeLineTo(0, -200)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _ProfileState extends State<Profile> {
  String token = "";
  String nama = "";
  String jabatan = "";
  String nip = "";
  String golongan = "";
  String pangkat = "";
  String skpd = "";
  String satker = "";
  String nama_jabatan = "";
  String jenis_jabatan = "";
  String eselon = "";
  String nama_eselon = "";
  String jenis_kepegawaian = "";
  String status = "";
  String foto = '';
  // String pp = '';

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: color1,
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 30, right: 10),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: color1,
                ),
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.clear();
                  print('token2 :');
                  print(token);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                  // logout();
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 27, 0, 71),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: FutureBuilder<http.Response>(
              future: _fetchImage(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // return CircleAvatar(
                  //   radius: 85,
                  //   backgroundImage: MemoryImage(snapshot.data!.bodyBytes),
                  // );
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          alignment: Alignment.topCenter,
                          image: MemoryImage(snapshot.data!.bodyBytes),
                          fit: BoxFit.cover,
                        )),
                    // child: Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: IconButton(
                    //     icon: Icon(Icons.edit),
                    //     onPressed: () {},
                    //   ),
                    // ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return CircularProgressIndicator();
              },
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 255, 255, 255), width: 4),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            height: 0,
            child: Container(
              color: Color.fromARGB(255, 27, 0, 71),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.all(0),
          //   width: MediaQuery.of(context).size.width / 2.1,
          //   height: MediaQuery.of(context).size.width / 2.1,
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //         color: Color.fromARGB(255, 255, 255, 255), width: 4),
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       fit: BoxFit.cover,
          //       image: NetworkImage(foto),
          //       // image: AssetImage(foto),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 26,
            width: 500,
            child: Container(
              color: Color.fromARGB(255, 27, 0, 71),
              child: Text(
                textAlign: TextAlign.center,
                "${nama}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 25,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0.5, left: 310),
            // child: CircleAvatar(
            //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.logout,
            //       color: color1,
            //     ),
            //     onPressed: () {
            //       logout();
            //     },
            //   ),
            // ),
          ),
          Expanded(
            child: Container(
              // width: 300,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: ListView(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                children: [
                  // SizedBox(
                  //   width: 350.0,
                  //   height: 48.0,
                  //   child: Card(
                  //     color: color3,
                  //     child: Text(
                  //       textAlign: TextAlign.center,
                  //       "Nama :\n${nama}",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w500,
                  //         color: Colors.black,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "Jabatan :\n${jabatan}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "NIP :\n${nip}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "Golongan :\n${golongan}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "Pangkat :\n${pangkat}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "SKPD :\n${skpd}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "Satker :\n${satker}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "Nama Jabatan :\n${nama_jabatan}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "Jenis Jabatan :\n${jenis_jabatan}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "Eselon :\n${eselon}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "Nama Eselon :\n${nama_eselon}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "Jenis Kepegawaian :\n${jenis_kepegawaian}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        "Status :\n${status}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void logout() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.clear();
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  //   print('token :');
  //   print(token);
  // }

  Future<bool> getProfile() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        token = pref.getString("token")!;
        print('token :');
        print(token);
        nama = pref.getString("nama")!;
        jabatan = pref.getString("jabatan")!;
        nip = pref.getString("nip")!;
        golongan = pref.getString("golongan")!;
        pangkat = pref.getString("pangkat")!;
        skpd = pref.getString("skpd")!;
        satker = pref.getString("satker")!;
        nama_jabatan = pref.getString("nama_jabatan")!;
        jenis_jabatan = pref.getString("jenis_jabatan")!;
        eselon = pref.getString("eselon")!;
        nama_eselon = pref.getString("nama_eselon")!;
        jenis_kepegawaian = pref.getString("jenis_kepegawaian")!;
        status = pref.getString("status")!;
        foto = pref.getString("foto")!;
        print("foto :");
        print(foto);
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<http.Response> _fetchImage() async {
    // Disable certificate verification
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(httpClient);

    return await ioClient.get(Uri.parse(foto));
  }
}
