import 'package:day_one/controller/database.dart';
import 'package:day_one/controller/user_model.dart';
import 'package:day_one/view/pages/auth/login_page.dart';
import 'package:day_one/view/shared/form_field.dart';
import 'package:email_validator/email_validator.dart';
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
  SqlDb sqlDb = SqlDb();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
                // AuthFormField(
                //   label: 'E-mail',
                //   hintText: 'Enter Your email',
                //   validator: 'Please Enter Your email!',
                //   controller: _emailController,
                // ),
                TextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                      12.0,
                    )),
                    label: const Text('E-mail'),
                    hintText: 'Enter your name',
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
                      // final preferences = await SharedPreferences.getInstance();
                      // preferences.setString(
                      //     "E-mail", _emailController.toString());
                      // preferences.setString(
                      //     "Password", _passwordController.toString());
                      // preferences.setString("Name", _nameController.toString());
                      // final email = preferences.getString("E-mail");
                      // final password = preferences.getString("Password");
                      // ignore: todo
                      // TODO:TO CHECK TRUE?
                      // debugPrint("email:$email");
                      // debugPrint("password:$password");
                      // if (!mounted) return;
                      if (_formkey.currentState!.validate()) {
                        int response = await sqlDb.insertData('''
                             INSERT INTO notes ('email','password')
                             VALUES ("${_emailController.text}" ,"${_passwordController.text}")
                             ''');

                        print("insseeeeeeerted email:::{$response}");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomePage()));
                      }
                    }),
                // MainButton(
                //     text: 'getData',
                //     ontap: () async {
                //       List<Map> response =
                //           await sqlDb.readData("SELECT * FROM 'notes'");
                //       print(response);
                //     })
              ],
            ),
          ),
        ),
      )),
    );
  }

  // void addUser() {
  //   var dbHelper = DataBaseHelper.db;
  //   dbHelper
  //       .insertUser(UserModel(
  //           email: _emailController.toString(),
  //           password: _passwordController.toString()))
  //       .then((value) {
  //     print('Insertttttttttted');
  //   });
  // }
}
