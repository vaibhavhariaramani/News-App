import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login/model/signUpModel.dart';

class APIService2 {
  Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    String url = "https://nodejs-register-login-app.herokuapp.com";

    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Register');
    }
  }
}
