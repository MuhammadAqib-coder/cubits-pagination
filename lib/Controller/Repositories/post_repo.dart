import 'dart:async';
import 'dart:io';

import 'package:cubit_task/Models/DataController/user_controler.dart';
import 'package:cubit_task/Utils/status_code.dart';
import 'package:http/http.dart' as http;

import '../../Models/post_model.dart';

class PostRepo {
  static Future<int> fetchPost(
      pageKey, numberOfPostsPerRequest, controler) async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$numberOfPostsPerRequest'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        UserControler.postModel =
            postModelFromJson(await response.stream.bytesToString());
        // final isLastPage =
        //     UserControler.postModel!.length < numberOfPostsPerRequest;
        // if (isLastPage) {
        //   controler.appendLastPage(UserControler.postModel!);
        // } else {
        //   final nextPageKey = pageKey + 1;
        //   controler.appendPage(UserControler.postModel!, nextPageKey);
        // }
      }
      return response.statusCode;
    } on SocketException catch (e) {
      return StatusCode.socketException;
    } on TimeoutException catch (e) {
      return StatusCode.tokenExpire;
    }
  }
}
