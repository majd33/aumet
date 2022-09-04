import 'package:aumet_task/screens/authentication/auth_screen.dart';
import 'package:aumet_task/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAHwcIYm_v0YmdUyEMwYtIZ9m1-hGRsryM",
      appId: "1:1096701497730:web:1650911a8d1d8bf81d3f9b",
      messagingSenderId: "1096701497730",
      projectId: "aumet-65eaa",
    ),
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(buttonColor: Colors.grey,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        home: AuthenticationScreen()
    );
  }
}

