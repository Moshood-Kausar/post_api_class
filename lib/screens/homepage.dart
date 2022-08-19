import 'package:flutter/material.dart';
import 'package:post_api_class/data/data_storage.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '', email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Column(
        children: [
           Text('Login Succesful'),
           Text(' Welcome to my App $name'),
           Text(' My email is $email')
        ],
      )
    );
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final prefs = await StreamingSharedPreferences.instance;

    final details = InfoStorage(prefs);
    setState(() {
      name = details.name.getValue();
      email = details.email.getValue();
    });
  }
}
