import 'package:flutter/material.dart';
import 'package:post_api_class/data/data_storage.dart';
import 'package:post_api_class/screens/post.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> with SingleTickerProviderStateMixin{
  String name = '', email = '';
  int selectedProfile = 0;
  List<String> profile = ['My Profille', 'My Posts'];
  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        
      ),
      body: Column(
        children: [
          Text(
            'Account',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          CircleAvatar(
            radius: 60,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 30),
          ),
          Text(
            email,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'Following: ',
                ),
                color: Colors.grey,
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'Followers: ',
                ),
                color: Colors.blue,
              )
            ],
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.transparent,
            tabs: List.generate(
              profile.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedProfile = index;
                  });
                },
                child: Text(
                  profile[index],
                  style: TextStyle(
                      color: selectedProfile == index
                          ? Colors.blue
                          : Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: _tabController,
              physics: ScrollPhysics(),
              children: [
                MyProfile(),
                Post(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
    _tabController =
        TabController(length: profile.length, vsync: this, initialIndex: 0);
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
