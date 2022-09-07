import 'package:flutter/material.dart';
import 'package:post_api_class/core/api_service.dart';
import 'package:post_api_class/core/models/userposts_model.dart';
import 'package:post_api_class/screens/postcard.dart';

class DashBoard extends StatefulWidget {
  
  const DashBoard({Key? key, }) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}


class _DashBoardState extends State<DashBoard> {
  Future<UserPostsModel>? _userpost;
  @override
  void initState() {
    
    super.initState();
    _userpost = ApiService().userpostsApi();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserPostsModel>(
      future: _userpost,
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
              if (snapshot.data!.posts!.data!.isEmpty) {
                return const Center(
                  child: Text('Oops! No post🥴'),
                );
              } else {
                return UserPostCard(data: snapshot.data!);
              }
            } else {
              return const Text('No Internet Connection');
            }
        }
      },
    );
  }
}
