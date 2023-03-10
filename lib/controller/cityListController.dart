import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mothering_business_network/models/City.dart';

class CityListController extends GetxController {
  var _cityList = <Data>[].obs;

  //getter and setter
  List<Data> get cityList => _cityList.value;

  //function to reset the values
  void reset() {
    _cityList.value = <Data>[];
  }

  //function to add grades to the list
  void fetchCityList() async {
    final response =
        await http.get(Uri.parse("https://mbnindia.com/webservice/api/city"));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      City cities = City.fromJson(jsonData);
      _cityList.value = cities.data;
    } else {
      throw Exception('Failed to load');
    }
  }
}
