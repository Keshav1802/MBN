import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mothering_business_network/login.dart';
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:mothering_business_network/routes/routes.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'landingpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool("isLoggedIn");
  var data=prefs.getString('userData');
  if(data!=null && isLoggedIn != null && isLoggedIn){
    Map json1 = jsonDecode(prefs.getString('userData'));
    var user1 = LoginData.fromJson(json1);
    print(user1.data);
    runApp(Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: 'MBN',
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: Routes.buildRoutes,
          home: landingPage(
              user1.data.name,
              user1.data.id,
              user1.data.chepterId,
              user1.data.cityId,
              user1.data.chapterDetails ?? "",
              user1.data.chapterUserDetails ?? "",
              user1.data) );
    }));
  }else{
    return runApp(MyApp());
  }
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: 'MBN',
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes : Routes.buildRoutes,
          home: Login());
    });
  }
}
