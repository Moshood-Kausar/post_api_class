import 'dart:io';

import 'package:flutter/material.dart';
import 'package:post_api_class/core/api_service.dart';
import 'package:post_api_class/core/models/register_model.dart';
import 'package:post_api_class/core/models/userinfo_model.dart';
import 'package:post_api_class/screens/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();

  TextEditingController _pass = TextEditingController();
  bool _startloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Welcome to Registaer Page using API',
              ),
              const Text('Kindly fill the form to confirm'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Email not complete';
                  } else if (!value.contains('@')) {
                    return 'Email not complete';
                  } else if (!value.contains(".")) {
                    return 'Email not correct';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    // suffix:TextButton(onPressed: (){}, child: Text('Forgot', style: TextStyle(color:Colors.green),),),
                    labelText: 'Enter your email',
                    hintText: 'examples@gmail.com'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: _pass,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', hintText: '*****'),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password cant be less than 6';
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(height: 20),
              _startloading
                  ? const CircularProgressIndicator()
                  : MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginFuntion();
                        }
                      },
                      color: Colors.grey,
                      child: const Text('Login')),
              const SizedBox(height: 50),
              TextButton(
                child: const Text('Have an account? Sign Up Here'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginFuntion() async {
    startLoading();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future<AuthModel> auth = ApiService().loginApi(
          email: _email.text,
          pass: _pass.text,
        );
        auth.then((v) async {
          if (v.status == true) {
            stopLoading();
            getuserFunction(v.token!);

            /// This simply means the api call is true, after this you launch the webview

          } else {
            stopLoading();
            snackBar(v.message!);
          }
        }).timeout(const Duration(seconds: 60), onTimeout: () {
          stopLoading();
          snackBar('Timeout error');
        });
      } else {
        stopLoading();
        snackBar('No internet connection');
      }
    } on SocketException catch (_) {
      stopLoading();
      snackBar('No internet connection');
    }
  }

  void getuserFunction(String token) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future<UserInfoModel> auth = ApiService().userinfoApi();
        auth.then((v) async {
          if (v.status == true) {
            _email.clear();
            _pass.clear();
            stopLoading();
            snackBar('Login Succesful');
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomePage()));

            /// This simply means the api call is true, after this you launch the webview

          } else {
            stopLoading();
            snackBar(v.message!);
          }
        }).timeout(const Duration(seconds: 60), onTimeout: () {
          stopLoading();
          snackBar('Timeout error');
        });
      } else {
        stopLoading();
        snackBar('No internet connection');
      }
    } on SocketException catch (_) {
      stopLoading();
      snackBar('No internet connection');
    }
  }

  void startLoading() {
    setState(() {
      _startloading = true;
    });
  }

  void stopLoading() {
    setState(() {
      _startloading = false;
    });
  }

  snackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }

  @override
  void initState() {
    _email = TextEditingController();
    _pass = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.clear();
    _pass.clear();

    super.dispose();
  }
}
