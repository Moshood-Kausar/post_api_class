import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:post_api_class/core/api_service.dart';
import 'package:post_api_class/core/models/likepost_model.dart';
import 'package:post_api_class/core/models/post_model.dart';
import 'package:post_api_class/core/models/topic_model.dart';
import 'package:post_api_class/core/models/userposts_model.dart';
import 'package:post_api_class/core/models/users_model.dart';

class PostCard extends StatefulWidget {
  final FirstPostModel data;
  const PostCard({Key? key, required this.data}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.posts!.data!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                '${widget.data.posts!.data![index].imageUrl}',
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Text(
                        '${widget.data.posts!.data![index].title}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        '${widget.data.posts!.data![index].body}',
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle(overflow: TextOverflow.fade),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                likeFuntion(
                                    id: '${widget.data.posts!.data![index].id}');
                              },
                              icon: Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.red,
                              )),
                          Text('${widget.data.posts!.data![index].likes}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void likeFuntion({id}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future<LikePostModel> auth = ApiService().likepostApi(id: id);
        auth.then((v) async {
          if (v.status == true) {
            setState(() {
              //_firstpost = ApiService().likepostApi();
            });
          } else {
            debugPrint('${v.message}');
          }
        }).timeout(const Duration(seconds: 60), onTimeout: () {
          debugPrint('Timeout Error');
        });
      } else {
        debugPrint('No internet connection');
      }
    } on SocketException catch (_) {
      debugPrint('No internet connection');
    }
  }
}

class TopicCard extends StatefulWidget {
  final TopicsModel data;
  const TopicCard({Key? key, required this.data}) : super(key: key);

  @override
  State<TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.topics!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text('${widget.data.topics![index].title}'),
                Text('${widget.data.topics![index].description}'),
                ],
              ),
            ),
          );
        });
  }
}

class UserPostCard extends StatefulWidget {
  final UserPostsModel data;
  const UserPostCard({Key? key, required this.data}) : super(key: key);

  @override
  State<UserPostCard> createState() => _UserPostCardState();
}

class _UserPostCardState extends State<UserPostCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.posts!.data!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text('${widget.data.posts!.data![index].title}'),
                  Text('${widget.data.posts!.data![index].description}'),
                ],
              ),
            ),
          );
        });
  }
}

class UsersCard extends StatefulWidget {
  final UsersModel data;
  const UsersCard({Key? key, required this.data}) : super(key: key);

  @override
  State<UsersCard> createState() => _UsersCardState();
}

class _UsersCardState extends State<UsersCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.user!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage('${widget.data.user![index].profileImage}'),
            ),
            title: Text('${widget.data.user![index].name}'),
            trailing: TextButton(onPressed: () {}, child: Text('Follow')),
          );
        });
  }
}
