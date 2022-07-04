import 'dart:convert';
import 'dart:io';
import 'package:flutter_learning/network/model/error.dart';
import 'package:flutter_learning/network/model/response.dart';
import 'package:flutter_learning/utils/string.dart';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart';
import '../../utils/request_params.dart';

class LoginApiProvider {
  Future<Response?> doLogin(String userName, String password) async {
    try {
      final response =
          await http.post(Uri.parse(ApiConstants.baseUrl + ApiConstants.login),
              headers: {
                'content-type': 'application/json',
                'accept': 'application/json',
              },
              body: jsonEncode(<String, String>{
                RequestParams.userName: userName,
                RequestParams.password: password,
                RequestParams.authProviderId: 'internal:aax-zvolt'
              }));
      if (response.statusCode == 200) {
        return Response(success: true, result: response.body);
      } else {
        return Response(
            success: false,
            result: response.body,
            error: Error.fromJson(jsonDecode(response.body)));
      }
    } catch (e) {
      if( e is SocketException){
        return Response(success: false, networkError: Strings.strInternetNotConnected);
      }else{
        return Response(success: false, networkError: e.toString());
      }
    }
  }
}
