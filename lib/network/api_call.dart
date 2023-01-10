import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  static Future callApi(String url, model) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(model.toJson());

      var response = await request.send();

      final respStr = await response.stream.bytesToString();

      print(respStr);
      return jsonDecode(respStr);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
