import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class CustomFunction {
  storeCredentials({token, userid}) async {
    final prefs = await StreamingSharedPreferences.instance;
    prefs.setString('token', token);
    prefs.setInt('userid', userid);
  }

  storeInfo({name, dob, email, gender, img, bio}) async {
    final prefs = await StreamingSharedPreferences.instance;
    prefs.setString('name', name);
     prefs.setString('dob', dob);
      prefs.setString('email', email);
       prefs.setString('gender', gender);
        prefs.setString('img', img);
         prefs.setString('bio', bio);

  }
}
