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
    checkSession();
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      FBToken = value.toString();
      // print('FBT : ');
      // print(FBToken);
    });
  }

  void checkSession() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("token");
    if (val != null) {
      // pref.setBool('isLogged', false);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Dashboard()),
          (route) => false);
    }
    // pref.setBool('isLogged', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 0, 71),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 110,
          ),
          SizedBox(
            child: Image.asset("assets/icon/icon.png"),
            height: 150,
          ),
          Container(
            height: 85,
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('E-Surat'.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text('Login to continue',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white54))
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 5),
                              color: Color.fromARGB(255, 27, 0, 71)
                                  .withOpacity(.2),
                              spreadRadius: 5,
                              blurRadius: 10)
                        ]),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          hintText: 'Username', border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 5),
                              color: Color.fromARGB(255, 27, 0, 71)
                                  .withOpacity(.2),
                              spreadRadius: 5,
                              blurRadius: 10)
                        ]),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password', border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                      child: Container(
                        padding: EdgeInsets.all(3),
                        child: Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.7,
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Brand Bold",
                              fontWeight: FontWeight.w500),
                        ),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 27, 0, 71),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 5),
                                color: Colors.green.withOpacity(.2),
                                spreadRadius: 5,
                                blurRadius: 10)
                          ],
                        ),
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
              "id": body['user']['id'],
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
          pref.setString("id", body['user']['id']);
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
          if (body['user']['foto'] != null) {
            pref.setString("foto", body['user']['foto']);
          } else {
            pref.setString("foto",
              'https://i.pinimg.com/originals/fd/14/a4/fd14a484f8e558209f0c2a94bc36b855.png'); // Isi dengan nilai default yang diinginkan
              // 'assets/images/default.jpg'); // Isi dengan nilai default yang diinginkan
          }
          pref.setBool('isLogged', true);

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
