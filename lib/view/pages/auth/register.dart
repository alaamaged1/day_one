import 'package:day_one/view/pages/auth/login_page.dart';
import 'package:day_one/view/shared/form_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/main_button.dart';
import '../home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.024),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
                AuthFormField(
                  label: 'Name',
                  hintText: 'Enter your name',
                  validator: 'Please Enter your name!',
                  controller: _nameController,
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                AuthFormField(
                  label: 'E-mail',
                  hintText: 'Enter Your email',
                  validator: 'Please Enter Your email!',
                  controller: _emailController,
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                AuthFormField(
                  label: 'Password',
                  hintText: 'Enter Your password',
                  validator: 'Please Enter Your password!',
                  controller: _passwordController,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      )),
                      child: Text(
                        'Or have an account',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.red,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                MainButton(
                    text: 'Register',
                    ontap: () async {
                      final preferences = await SharedPreferences.getInstance();
                      preferences.setString(
                          "E-mail", _emailController.toString());
                      preferences.setString(
                          "Password", _passwordController.toString());
                      preferences.setString("Name", _nameController.toString());
                      // ignore: todo
                      // TODO:TO CHECK TRUE?
                      debugPrint("...");
                      if (!mounted) return;
                      if (_formkey.currentState!.validate()) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomePage()));
                      }
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
