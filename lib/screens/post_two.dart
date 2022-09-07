
import 'package:flutter/material.dart';
import 'package:post_api_class/core/api_service.dart';
import 'package:post_api_class/core/models/topic_model.dart';
import 'package:post_api_class/screens/postcard.dart';

class PostTwo extends StatefulWidget {
  const PostTwo({Key? key}) : super(key: key);

  @override
  State<PostTwo> createState() => _PostTwoState();
}

class _PostTwoState extends State<PostTwo> {
  Future<TopicsModel>? _topics;

 
  @override
  void initState() {
    
    super.initState();
    _topics = ApiService().topics();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopicsModel>(
      future: _topics,
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
              if (snapshot.data!.topics == null) {
                return const Center(
                  child: Text('Oops! No post🥴'),
                );
              } else {
                return TopicCard(data: snapshot.data!);
              }
            } else {
              return const Text('No Internet Connection');
            }
        }
      },
    );
  }

  
}
