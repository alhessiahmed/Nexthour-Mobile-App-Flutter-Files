import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nexthour/models/AppUiShortingModel.dart';
import '/common/apipath.dart';
import '/common/global.dart';

class AppUIShortingProvider with ChangeNotifier {
  late AppUiShortingModel appUiShortingModel;

  Future<void> loadData(BuildContext context) async {
    final response = await http.get(
      Uri.parse(APIData.appUiShorting),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $authToken",
      },
    );
    print("App UI Shorting API Status Code -> ${response.statusCode}");
    if (response.statusCode == 200) {
      String data = response.body;
      print("App UI Shorting API Response -> $data");
      appUiShortingModel = AppUiShortingModel.fromJson(await jsonDecode(data));
    }
  }
}
