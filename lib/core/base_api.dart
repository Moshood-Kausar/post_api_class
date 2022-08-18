import 'package:post_api_class/core/models/register_model.dart';

abstract class BaseApi {
  Future<AuthModel> registerApi({name, email, pass});
  Future<AuthModel> loginApi({ email, pass});
}
