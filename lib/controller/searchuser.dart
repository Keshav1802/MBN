import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mothering_business_network/models/UserList.dart';
import 'package:dio/dio.dart';

class SearchUserController extends GetxController {
  var _searchuserList = <Data>[].obs;

  //getter and setter
  List<Data> get searchuserList => _searchuserList.value;

  //function to reset the values
  void reset() {
    _searchuserList.value = <Data>[];
  }

  //function to add grades to the list
  void fetchSearchUserList(String user_id, String chapter_id) async {
    var url = 'https://mbnindia.com/webservice/api/userList';
    Map data = {
      'user_id': "30", //change to user_id
      'chapter_id': "3", //change to chapter_id
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await Dio().post(url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
          },
        ),
        data: body);
    // final response = await http.get(Uri.parse("https://mbnindia.com/webservice/api/userList"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.toString());
      UserList searchuser = UserList.fromJson(jsonData);
      _searchuserList.value = searchuser.data;
    } else {
      throw Exception('Failed to load');
    }
  }
}
