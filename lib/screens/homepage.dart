import 'dart:io';

import 'package:flutter/material.dart';
import 'package:post_api_class/auth/login.dart';
import 'package:post_api_class/core/api_service.dart';
import 'package:post_api_class/core/models/logout_model.dart';
import 'package:post_api_class/data/data_storage.dart';
import 'package:post_api_class/screens/dashboard.dart';
import 'package:post_api_class/screens/follow.dart';
import 'package:post_api_class/screens/myprofile.dart';
import 'package:post_api_class/screens/post.dart';
import 'package:post_api_class/screens/post_two.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _widget = [];
  final List<String> _titleBar = ['Topics', 'Post', ' Post', 'Follow'];
  GlobalKey bottomNavigationKey = GlobalKey();

  String name = '', email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titleBar[_currentIndex],
          style: const TextStyle(color: Colors.blue),
        ),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            logoutFuntion();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyProfile(),
                  ),
                );
              },
              icon: Icon(Icons.person))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTapped,
        iconSize: 22,
        elevation: 5,
        selectedItemColor: const Color(0xFF0F62FE),
        unselectedItemColor: const Color(0xff525252),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Topics'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Follow')
        ],
      ),
      body: _widget[_currentIndex],

      // body: Column(
      //   children: [
      //      const Text('Login Succesful'),
      //      Text(' Welcome to my App $name'),
      //      Text(' My email is $email')
      //   ],
      // )
    );
  }

  void onTapped(int index) {
    setState(
      () {
        _currentIndex = index;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
    _widget.insert(0, const DashBoard());
    _widget.insert(1, const Post());
    _widget.insert(2, const PostTwo());
    _widget.insert(3, const FollowPage());
  }

  Future<void> getUserInfo() async {
    final prefs = await StreamingSharedPreferences.instance;

    final details = InfoStorage(prefs);
    setState(() {
      name = details.name.getValue();
      email = details.email.getValue();
    });
  }

  void logoutFuntion() async {
    startLoading();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future<LogoutModel> auth = ApiService().logoutApi();
        auth.then((v) async {
          if (v.status == true) {
            startLoading();
            getUserInfo();
            final prefs = await StreamingSharedPreferences.instance;

            Navigator.pop(
                context, MaterialPageRoute(builder: (_) => const LoginPage()));
            prefs.clear();
            snackBar(v.message!);
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
    setState(() {});
  }

  void stopLoading() {
    setState(() {});
  }

  snackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }
}
