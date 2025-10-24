import 'package:easy_map/core/routing/app_router.dart';
import 'package:easy_map/core/routing/app_routs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

late String initialRout;
void main() async {
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRout = AppRouts.auth;
    } else {
      initialRout = AppRouts.mapScreen;
    }
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      theme: ThemeData(),
      initialRoute: initialRout,
    );
  }
}
