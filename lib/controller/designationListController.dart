import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mothering_business_network/models/Designation.dart';

class DesignationListController extends GetxController {
  var _designationList = <Data>[].obs;

  //getter and setter
  List<Data> get designationList => _designationList.value;

  //function to reset the values
  void reset() {
    _designationList.value = <Data>[];
  }

  //function to add grades to the list
  void fetchDesignationList() async {
    final response = await http
        .get(Uri.parse("https://mbnindia.com/webservice/api/designation"));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      Designation designations = Designation.fromJson(jsonData);
      _designationList.value = designations.data;
    } else {
      throw Exception('Failed to load');
    }
  }
}
