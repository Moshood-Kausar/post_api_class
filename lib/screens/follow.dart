import 'package:flutter/material.dart';
import 'package:post_api_class/core/api_service.dart';
import 'package:post_api_class/core/models/users_model.dart';
import 'package:post_api_class/screens/postcard.dart';
class FollowPage extends StatefulWidget {
  const FollowPage({Key? key}) : super(key: key);

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
    Future<UsersModel>? _users;

 
  @override
  void initState() {
    
    super.initState();
    _users = ApiService().userApi();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UsersModel>(
      future: _users,
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
                  'Unable to get users. Kindly Refresh',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.user == null) {
                return const Center(
                  child: Text('Oops! No users🥴'),
                );
              } else {
                return UsersCard(data: snapshot.data!);
              }
            } else {
              return const Text('No Internet Connection');
            }
            }
           
            
      
        
      },

);
  }
}