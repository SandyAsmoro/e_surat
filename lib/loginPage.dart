import 'dart:convert';
import 'dart:io';

import 'package:e_surat/dashboard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String FBToken = "";
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      FBToken = value.toString();
      print('FBT : ');
      print(FBToken);
    });
    checkSession();
  }

  void checkSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("token");
    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Dashboard()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/kediri.jpg"),
                        fit: BoxFit.fill)),
                child: Container(
                  padding: EdgeInsets.only(top: 90, left: 20),
                  color: Color.fromARGB(255, 143, 103, 197).withOpacity(.85),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Selamat Datang di ",
                            style: TextStyle(
                              fontSize: 25,
                              // letterSpacing: 2,
                              color: Colors.yellow[700],
                            ),
                            children: [
                              TextSpan(
                                text: " E-surat",
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow[700],
                                ),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Login untuk melanjutkan",
                        style: TextStyle(
                          // letterSpacing: 1,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              // duration: Duration(milliseconds: 700),
              // curve: Curves.bounceInOut,
              top: 535,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  height: 90,
                  width: 90,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1.5,
                          blurRadius: 10,
                        )
                      ]),
                ),
              ),
            ),
            Positioned(
              // duration: Duration(milliseconds: 700),
              // curve: Curves.bounceInOut,
              top: 230,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                curve: Curves.bounceInOut,
                height: 350,
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5),
                    ]),
                child: Column(
                  children: [
                    SizedBox(
                      child: Image.asset("assets/icon/icon.png"),
                      height: 80,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.person)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.password)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              top: 535,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  height: 90,
                  width: 90,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1))
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void login() async {
    if (passwordController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("https://simponik.kedirikota.go.id/api/login"),
          body: ({
            "usernm": usernameController.text,
            "passwd": passwordController.text
          }));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        var token = body['user']['token'];
        var request = await http.put(
            Uri.parse("https://simponik.kedirikota.go.id/api/login"),
            // "https://sigap.kedirikota.go.id/apiesuratpkl/public/em_user/${body['id']}"),
            body: jsonEncode({
              "token": FBToken,
              "id": body['id'],
            }),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer $token",
            });

        if (request.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login Berhasil"),
            margin: EdgeInsets.all(30),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ));

          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("token", body['user']['token']);
          pref.setString("nama", body['user']['name']);
          pref.setString("jabatan", body['user']['jabatan']);
          pref.setString("nip", body['user']['nip']);
          pref.setString("golongan", body['user']['golongan']);
          pref.setString("pangkat", body['user']['pangkat']);
          pref.setString("skpd", body['user']['skpd']);
          pref.setString("satker", body['user']['satker']);
          pref.setString("nama_jabatan", body['user']['nama_jabatan']);
          pref.setString("jenis_jabatan", body['user']['jenis_jabatan']);
          pref.setString("eselon", body['user']['eselon']);
          pref.setString("nama_eselon", body['user']['nama_eselon']);
          pref.setString(
              "jenis_kepegawaian", body['user']['jenis_kepegawaian']);
          pref.setString("status", body['user']['status']);
          // pref.setString("foto", body['user']['foto']);

          pageRoute();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Update Token Firebase Gagal"),
              margin: EdgeInsets.all(30),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid Credentials"),
            margin: EdgeInsets.all(30),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username / Password tidak boleh kosong!!"),
          margin: EdgeInsets.all(30),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      );
    }
  }

  void pageRoute() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
  }
}
