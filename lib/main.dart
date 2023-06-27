import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:e_surat/dashboard.dart';
import 'package:e_surat/firebase_options.dart';
import 'package:e_surat/loginPage.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dd.dart';
import 'forgroundLocalNotification.dart';

// Done

// Future<void> _firebaseMessagingBackgroundHandler(message) async {
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.messageId}");
// }

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final fcmToken = await FirebaseMessaging.instance.getToken();
      print('FBT : ');
      print(fcmToken);
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLogged = prefs.getBool('isLogged') ?? false;
  // runApp(MyApp());
  runApp(MyApp(isLogged: isLogged));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  const MyApp({Key? key, required this.isLogged}) : super(key: key);
  final bool isLogged;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalNotification.initialize();
    // For Forground State
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotification.showNotification(message);
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Surat Kota Kediri',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: AnimatedSplashScreen(
        duration: 1500,
        splash: Image.asset("assets/icon/icon.png"),
        splashTransition: SplashTransition.rotationTransition,
        nextScreen: isLogged ? Dashboard() : LoginPage()),
        // nextScreen: HomePage(),),
    );
  }
}

