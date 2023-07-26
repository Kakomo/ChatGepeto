import 'package:chatchat/helper/helper_function.dart';
import 'package:chatchat/pages/homepage.dart';
import 'package:chatchat/pages/loginpage.dart';
import 'package:chatchat/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apikey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    await Firebase.initializeApp();
  }

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool temaBool = true;

ThemeData temaClaro = ThemeData(
  brightness: Brightness.light,
  primaryColor: Constants().primaryColor,
  scaffoldBackgroundColor: Color.fromARGB(255, 253, 249, 249),
);

ThemeData temaEscuro = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Constants().darkPrimaryColor,
  scaffoldBackgroundColor: Color.fromARGB(255, 38, 38, 38),
);

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: temaBool ? temaClaro : temaEscuro,
      home: _isSignedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
