import 'package:day_one/view/pages/auth/register.dart';
import 'package:flutter/material.dart';

import '../../shared/form_field.dart';
import '../../shared/main_button.dart';
import '../home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.024),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.08,
                ),
                AuthFormField(
                  label: 'E-mail',
                  hintText: 'Enter Your email',
                  validator: 'Enter Your email!',
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
                  height: size.height * 0.053,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      )),
                      child: Text(
                        'Don\'t have an account,Register',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.red,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.044,
                ),
                MainButton(
                    text: 'Login',
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
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
