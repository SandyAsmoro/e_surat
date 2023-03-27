import 'package:e_surat/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const color1 = Color(0xFF533E85);
const color2 = Color(0xFF533E85);
const color3 = Color(0xFF4FD3C4);
const color4 = Color(0xFFC1F8CF);
const color5 = Color.fromARGB(255, 255, 0, 0);

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
  // String foto = "";

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
      // appBar: AppBar(
      //   // title: Text("Profile"),
      //   backgroundColor: color1,
      // ),

      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 500.0,
                      height: 50.0,
                      child: Card(
                        color: color3,
                        child: Text(
                          "Nama       : ${nama}",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    Text(
                      "Jabatan    : ${jabatan}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "NIP    : ${nip}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "Golongan    : ${golongan}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "Pangkat    : ${pangkat}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "SKPD    : ${skpd}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "Satker     : ${satker}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "Nama Jabatan     : ${nama_jabatan}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "Jenis Jabatan     : ${jenis_jabatan}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "Eselon     : ${eselon}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "Nama Eselon     : ${nama_eselon}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "Jenis Kepegawaian : ${jenis_kepegawaian}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      "Status     : ${status}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60, bottom: 30),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/kediri.jpg'),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 200, left: 174),
            child: CircleAvatar(
              backgroundColor: color5,
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  logout();
                },
              ),
            ),
          )
        ],
      ),

      // body: Padding(
      //   padding: const EdgeInsets.all(15.0),
      //   child: SafeArea(
      //       child: Center(
      //           child: Column(
      //     children: [
      //       Card(
      //         clipBehavior: Clip.antiAlias,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(16),
      //         ),
      //         shadowColor: Colors.black,
      //         elevation: 10,
      //         child: Container(
      //           decoration: BoxDecoration(
      //               gradient: LinearGradient(
      //                   colors: [color2, color3],
      //                   stops: [0.1, 1],
      //                   begin: Alignment.topCenter,
      //                   end: Alignment.bottomRight)),
      //           padding: EdgeInsets.all(12),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "Nama       : ${nama}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "Jabatan    : ${jabatan}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "NIP        : ${nip}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "Golongan   : ${golongan}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "Pangkat    : ${pangkat}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "SKPD       : ${skpd}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "Satker     : ${satker}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "Nama Jabatan : ${nama_jabatan}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "Jenis Jabatan : ${jenis_jabatan}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "Eselon     : ${eselon}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "Nama Eselon : ${nama_eselon}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "Jenis Kepegawaian : ${jenis_kepegawaian}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //               Divider(),
      //               Text(
      //                 "Status     : ${status}",
      //                 style: TextStyle(color: Colors.white, fontSize: 16),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 15,
      //       ),
      //       OutlinedButton.icon(
      //           onPressed: () {
      //             logout();
      //           },
      //           icon: Icon(
      //             Icons.logout,
      //             size: 18,
      //           ),
      //           label: Text("Logout"))
      //     ],
      //   ))),
      // ),
    );
  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  Future<bool> getProfile() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        token = pref.getString("token")!;
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
        // foto = pref.getString("foto")!;
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
