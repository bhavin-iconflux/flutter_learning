import 'package:flutter_learning/network/model/response.dart';
import 'package:flutter_learning/network/resources/login_api_provider.dart';

class Repository {
  final loginApiProvider = LoginApiProvider();

  Future<Response?> doLogin(String userName, String password) =>
      loginApiProvider.doLogin(userName, password);
}
