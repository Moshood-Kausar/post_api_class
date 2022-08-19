import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class InfoStorage {
  InfoStorage(StreamingSharedPreferences preferences)
  : name = preferences.getString('name', defaultValue: ''),
  userid = preferences.getInt('userid', defaultValue: 0),
  email = preferences.getString('email', defaultValue: ''),
  dob= preferences.getString('dob', defaultValue: ''),
  proimg = preferences.getString('img', defaultValue: ''),
 bio= preferences.getString('bio', defaultValue: ''),
token= preferences.getString('token', defaultValue: '')

  ;
  final Preference<String> name;
  final Preference<int> userid;
  final Preference<String> email;
  final Preference<String> dob;
  final Preference<String> proimg;
  final Preference<String> bio;
  final Preference<String> token;


}
