import 'dart:io';

import 'package:flutter/material.dart';
import 'package:post_api_class/auth/login.dart';
import 'package:post_api_class/core/api_service.dart';
import 'package:post_api_class/core/models/register_model.dart';
import 'package:post_api_class/core/models/userinfo_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool _startloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
              TextFormField(
                controller: _name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Nmae can\'t be less than 6 characters ';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    labelText: 'Full Name', hintText: 'Enter full Name'),
              ),
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
                          registerFuntion();
                        }
                      },
                      
                      color: Colors.grey,
                    child: const Text('Register')),
              const SizedBox(height: 50),
              TextButton(
                child: const Text('Have an account? Login Here',
                    style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const LoginPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void registerFuntion() async {
    startLoading();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future<AuthModel> auth = ApiService().registerApi(
          email: _email.text,
          pass: _pass.text,
          name: _name.text,
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
            stopLoading();
            snackBar('Login Succesful');

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
    _name = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _name.dispose();

    super.dispose();
  }
}
