// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:mothering_business/models/BusinessPresence.dart';
// import 'package:mothering_business/models/LoginData.dart';
//
// class BusinessPresenceController extends GetxController {
//   var _chapterDetailsList = <ChapterUserDetails>[].obs;
//
//   //getter and setter
//   List<ChapterUserDetails> get chapterDetailsList => _chapterDetailsList.value;
//
//   //function to reset the values
//   void reset() {
//     _chapterDetailsList.value = <ChapterUserDetails>[];
//   }
//
//   //function to add grades to the list
//   void fetchBusinessPresenceList() async {
//     final response = await http.get(Uri.parse("https://mbnindia.com/webservice/api/businessPresence"));
//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);
//       ChapterUserDetails chapterUserDetails = ChapterUserDetails.fromJson(jsonData);
//       _chapterDetailsList.value = chapterUserDetails;
//     } else {
//       throw Exception('Failed to load');
//     }
//   }
// }
