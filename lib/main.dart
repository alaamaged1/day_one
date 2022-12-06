import 'package:day_one/view/pages/auth/register.dart';
import 'package:day_one/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final email = preferences.getString("E-mail");
  final password = preferences.getString("Password");

  runApp(email == null && password == null ? const MyApp() : const HomePage());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  checkUser() async {
    if (!mounted) return;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final email = preferences.getString("E-mail");

    final password = preferences.getString("Password");
    return email == null && password == null
        ? const RegisterPage()
        : const HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
    );
  }
}
