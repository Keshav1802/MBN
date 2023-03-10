import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/BusinessClassification.dart';

class BusinessClassificationController extends GetxController {
  var _businessclassificationList = <Data>[].obs;

  //getter and setter
  List<Data> get businessclassificationList =>
      _businessclassificationList.value;

  //function to reset the values
  void reset() {
    _businessclassificationList.value = <Data>[];
  }

  //function to add grades to the list
  void fetchBusinessClassificationList() async {
    final response = await http.get(Uri.parse(
        "https://mbnindia.com/webservice/api/businessClassification"));
    // print(response.body);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      BusinessClassification businessClassification =
          BusinessClassification.fromJson(jsonData);
      _businessclassificationList.value = businessClassification.data;
    } else {
      throw Exception('Failed to load');
    }
  }
}
