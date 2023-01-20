import 'dart:convert';
import 'dart:io';

import 'package:cubit_task/Models/DataController/user_controler.dart';
import 'package:cubit_task/Utils/status_code.dart';
import 'package:http/http.dart' as http;

class UserLoginRepo {
  static Future<int> userLogin({required email, required password}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse('https://reqres.in/api/login'));
      request.body = json.encode({"email": email, "password": password});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        UserControler.userLoginCredential =
            await json.decode(await response.stream.bytesToString());
      }
      return response.statusCode;
    } on SocketException catch (e) {
      return StatusCode.socketException;
    } catch (e) {
      return StatusCode.exception;
    }
  }

  static Future<int> userRegister({required email, required password}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse('https://reqres.in/api/login'));
      request.body = json.encode({"email": email, "password": password});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        UserControler.userRegisterCredential =
            await json.decode(await response.stream.bytesToString());
      }
      return response.statusCode;
    } on SocketException catch (e) {
      return StatusCode.socketException;
    } catch (e) {
      return StatusCode.exception;
    }
  }
}
