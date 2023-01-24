import 'dart:async';
import 'dart:io';
import 'package:cubit_task/Models/DataController/user_controler.dart';
import 'package:cubit_task/Models/User/user_model.dart';
import 'package:cubit_task/Utils/status_code.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  static Future<int> getAllUser() async {
    try {
      var request =
          http.Request('GET', Uri.parse('https://reqres.in/api/users'));

      http.StreamedResponse response = await request.send();
      // UserModel? userModel;
      if (response.statusCode == 200) {
        UserControler.userModel =
            userModelFromJson(await response.stream.bytesToString());
        // return userModel;
      }
      //  else {
      //   return userModel;
      // }
      //return UserControler.userModel;
      return response.statusCode;
    } on SocketException catch (e) {
      return StatusCode.socketException;
    } on TimeoutException catch (e) {
      return StatusCode.tokenExpire;
    }
  }
}

// class MyRepo {
//   static getAllUser() async {
//     try {
//       var response = await http.get(Uri.parse('https://reqres.in/api/users'));
//       if (response.statusCode == 200) {
//         UserControler.userModel = userModelFromJson(response.body);
//       }
//       return response.statusCode;
//     } on SocketException catch (e) {
//       return StatusCode.socketException;
//     } on TimeoutException catch (e) {
//       return StatusCode.tokenExpire;
//     }
//   }
// }
