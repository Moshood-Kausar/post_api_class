import 'package:flutter/material.dart';
import 'package:post_api_class/core/api_service.dart';
import 'package:post_api_class/core/models/post_model.dart';
import 'package:post_api_class/screens/postcard.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  Future<FirstPostModel>? _firstpost;
  @override
  void initState() {
    super.initState();
    _firstpost = ApiService().firstpostApi();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirstPostModel>(
      future: _firstpost,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center();
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            return const Center();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Unable to get Post. Kindly Refresh',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.posts!.data == []) {
                return const Center(
                  child: Text('Oops!You have not posted anythingt🥴'),
                );
              } else {
                return PostCard(data: snapshot.data!);
              }
            }
            if (snapshot.data!.posts!.data!.isEmpty==true) {
              return const Center(child: Text('No post',  style: TextStyle(color: Colors.red),));
              
            } 
            
            else {
              return const Text('No Internet Connection');
            }
        }
      },
    );
  }
}
