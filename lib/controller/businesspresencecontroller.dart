import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mothering_business_network/models/BusinessPresence.dart';

class BusinessPresenceController extends GetxController {
  var _businesspresenceList = <Data>[].obs;

  //getter and setter
  List<Data> get businesspresenceList => _businesspresenceList.value;

  //function to reset the values
  void reset() {
    _businesspresenceList.value = <Data>[];
  }

  //function to add grades to the list
  void fetchBusinessPresenceList() async {
    final response = await http
        .get(Uri.parse("https://mbnindia.com/webservice/api/businessPresence"));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      BusinessPresence businessPresence = BusinessPresence.fromJson(jsonData);
      _businesspresenceList.value = businessPresence.data;
    } else {
      throw Exception('Failed to load');
    }
  }
}
