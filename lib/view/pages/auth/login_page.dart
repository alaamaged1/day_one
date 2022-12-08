import 'package:day_one/view/pages/auth/register.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../../controller/database.dart';
import '../../shared/form_field.dart';
import '../../shared/main_button.dart';
import '../home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SqlDb sqlDb = SqlDb();
  static String? email_db;
  static String? password_db;
  // Future<List<Map>> readData() async {
  //   List<Map> response = await sqlDb.readData("SELECT 'email' FROM notes");
  //   return response;
  // }
  //
  data() async {
    var res = await sqlDb.readData(
        "SELECT * FROM 'notes' WHERE email='${_emailController2.text}' AND password='${_passwordController2.text}'");

    email_db = res[0]['email'];
    password_db = res[0]['password'];
    // print("Email db: ${email_db}\n");
    // print("emailController: ${_emailController.text}\n");
    // print("passwordController: ${_passwordController.text}\n");
    // print("password_db: ${password_db}");
  }

  chk() async {
    await data();
    if ((_emailController2.text != email_db) ||
        (_passwordController2.text != password_db)) {
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'Error!',
                style: Theme.of(context).textTheme.headline5,
              ),
              content: Text(
                "Register First",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Ok'))
              ],
            );
          });
    }
    return null;
  }

//
  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _emailController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Form(
        key: _formKey2,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.024),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.08,
                ),
                TextFormField(
                  controller: _emailController2,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                      12.0,
                    )),
                    label: const Text('E-mail'),
                    hintText: 'Enter Your email',
                  ),
                  validator: (val) => !EmailValidator.validate(val!)
                      ? 'Enter a valid Email'
                      : null,
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                AuthFormField(
                  label: 'Password',
                  hintText: 'Enter Your password',
                  validator: 'Please Enter Your password!',
                  controller: _passwordController2,
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
                    ontap: () async {
                      if (_formKey2.currentState!.validate()) {
                        await chk();
                        // await data();
                        if ((_emailController2.text != email_db) ||
                            (_passwordController2.text != password_db)) {
                          return showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text(
                                    'Error!',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  content: Text(
                                    "Register First",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Ok'))
                                  ],
                                );
                              });
                        } else {
                          if (!mounted) return;
                          debugPrint('Helllllllllllllllllllllo');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        }
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
