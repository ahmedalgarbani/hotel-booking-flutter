import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:http/http.dart' as http;

class Updateapi {
  Future<List<Rigetermodel>> getupdateprofile(
      {required String url, String? token}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    print("🔵 API Response Rigetermodel: ${response.body}");

    var decodedData = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      var data = jsonDecode(decodedData);

      Rigetermodel user = Rigetermodel.fromJson(data);

      return [user];
    } else {
      throw Exception("Error in loading Rigetermodel: ${response.statusCode}");
    }
  }

  Future<dynamic> put({
    required String url,
    required Map<String, dynamic> body,
    File? image,
    String? token,
  }) async {
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('PUT', uri);

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.fields
        .addAll(body.map((key, value) => MapEntry(key, value.toString())));

    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', image.path),
      );
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    late Map<String, dynamic> responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (e) {
      throw Exception("فشل في تحويل الاستجابة إلى JSON: $e");
    }

    if (responseBody.containsKey('detail') &&
        responseBody['detail'] ==
            "Authentication credentials were not provided.") {
      Get.snackbar("Auth Error", "please login at first",backgroundColor: Colors.deepOrangeAccent,);
      return null;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return responseBody;
    } else {
      throw Exception("هناك مشكلة في الطلب: ${response.statusCode}");
    }
  }
}
