import 'package:e_surat/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const color1 = Color.fromARGB(255, 27, 0, 71);
const color2 = Color.fromARGB(255, 27, 0, 71);
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
  // late String foto;

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
      ),
      backgroundColor: Color.fromARGB(255, 27, 0, 71),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 255, 255, 255), width: 2),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/kediri.jpg'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0.5, left: 360),
            child: CircleAvatar(
              backgroundColor: color5,
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 27, 0, 71),
                ),
                onPressed: () {
                  logout();
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Nama :\n${nama}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "Jabatan :\n${jabatan}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "NIP :\n${nip}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "Golongan :\n${golongan}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "Pangkat :\n${pangkat}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "SKPD :\n${skpd}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "Satker :\n${satker}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "Nama Jabatan :\n${nama_jabatan}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "Jenis Jabatan :\n${jenis_jabatan}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "Eselon :\n${eselon}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "Nama Eselon :\n${nama_eselon}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "Jenis Kepegawaian :\n${jenis_kepegawaian}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 47.0,
                    child: Card(
                      color: color3,
                      child: Text(
                        "Status :\n${status}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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
        // foto = (pref.getString("foto") != null? null : "N/A")!;
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
