import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mothering_business_network/models/InviteAdd.dart';
import 'package:mothering_business_network/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  // String user_id;
  // String city_id;
  // String chapter_id;

  // ChangePasswordScreen(this.user_id, this.city_id, this.chapter_id);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController emailController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  // Future<InviteAdd> getPostApi() async {
  //   var url = 'https://mbnindia.com/webservice/api/invite';
  //
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //     "Accept": "*/*",
  //   };
  //
  //   Map data = {
  //     'user_id': widget.user_id,
  //     'chapter_id': "12", //widget.chapter_id
  //     'city_id': widget.city_id,
  //     'email': emailController.text
  //   };
  //   //encode Map to JSON
  //   print(data.values);
  //   var body = json.encode(data);
  //   // FormData formData = FormData.fromMap({
  //   //   'event_id': widget.event_id,
  //   //   'qr': code,
  //   // });
  //
  //   var response = await Dio().post(url,
  //       options: Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "*/*",
  //         },
  //       ),
  //       data: body);
  //   print("${response.statusCode}");
  //   print(response.toString());
  //   var jsonObject = json.decode(response.toString());
  //   if (response.statusCode == 200) {
  //     if (jsonObject['status'] == 200) {
  //       // return InviteAdd.fromJson(jsonObject);
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(
  //           'Invite has been send successfully',
  //           style: TextStyle(color: Colors.black),
  //         ),
  //         backgroundColor: Colors.greenAccent,
  //       ));
  //       Timer(Duration(seconds: 3), () {
  //         Navigator.of(context).pop();
  //       });
  //       // inviteList.sort((a, b) => a.id.compareTo(b.id));
  //     }
  //     // return jsonObject ;// you can mapping json object also here
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         jsonObject['message'] + ' Please try after sometime.',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       backgroundColor: Colors.redAccent,
  //     ));
  //   }
  //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //   //   content: Text("Sending Message"),
  //   // )); // you can mapping json object also here
  //   return jsonObject;
  // }

  bool isEmail(String input) => EmailValidator.validate(input);
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Poppins SemiBold',
            fontSize: 34 * ffem,
            fontWeight: FontWeight.w400,
            height: 1.2575 * ffem / fem,
            color: Color(0xff9BA6BF),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon:
          Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xff9BA6BF)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xff000000), Color(0xff000000)],
            ),
          ),
        ),
        elevation: 0.5,
      ),
      backgroundColor: Color(0xff45536A),
      body: Container(
        decoration: BoxDecoration (
          gradient: LinearGradient (
            begin: Alignment(0.184, 1),
            end: Alignment(0.184, -1),
            colors: <Color>[Color(0xff000000), Color(0x00000000)],
            stops: <double>[0, 1],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25,0,10,0),
            child: Text('This feature will be live in next update.' , style: SafeGoogleFont(
              'Poppins',
              fontSize: 26 * ffem,
              fontWeight: FontWeight.w400,
              height: 1.5 * ffem / fem,
              color: Colors.grey,
            ),
            ),
          ),
        )
        // GestureDetector(
        //   onTap: () {
        //     FocusScope.of(context).requestFocus(new FocusNode());
        //   },
        //   child: Form(
        //     key: _formKey,
        //     child: Column(
        //       children: [
        //         SizedBox(
        //           height: 10,
        //         ),
        //         Container(
        //           // emailorphnmbrCKV (234:30)
        //           margin:
        //           EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 15 * fem),
        //           padding:
        //           EdgeInsets.fromLTRB(25 * fem, 5 * fem, 25 * fem, 16 * fem),
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //             // border: Border.all(color: Color(0xd8e3e6ef)),
        //             // color: Color(0xff111111),
        //             borderRadius: BorderRadius.circular(5 * fem),
        //           ),
        //           child: TextFormField(
        //             controller: emailController,
        //             validator: (value) {
        //               if (value.isEmpty && !isEmail(value)) {
        //                 return 'Please enter your password in correct format';
        //               }
        //               return null;
        //             },
        //             style: SafeGoogleFont(
        //               'Poppins',
        //               fontSize: 16 * ffem,
        //               fontWeight: FontWeight.w400,
        //               height: 1.5 * ffem / fem,
        //               color: Colors.grey,
        //             ),
        //             decoration: InputDecoration(
        //                 labelText: 'Email',
        //                 labelStyle: new TextStyle(
        //                   color: Colors.grey,
        //                 ),
        //                 focusedBorder: UnderlineInputBorder(
        //                   borderSide: BorderSide(color: Colors.white),
        //                 ),
        //                 enabledBorder: UnderlineInputBorder(
        //                   borderSide: BorderSide(color: Colors.white),
        //                 ),
        //                 prefixIcon: Icon(
        //                   Icons.mail_outlined,
        //                   color: Colors.white,
        //                 ),
        //                 border: UnderlineInputBorder(
        //                     borderSide: BorderSide(color: Colors.white))),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Container(
        //           padding:
        //           EdgeInsets.fromLTRB(25 * fem, 5 * fem, 25 * fem, 16 * fem),
        //           child: GestureDetector(
        //             onTap: () {
        //               if (_formKey.currentState.validate()) {
        //                 getPostApi();
        //                 // postRequest(
        //                 //   emailController.text,
        //                 // );
        //                 // print(field);
        //                 // if(cred!.=='success'){
        //                 //
        //                 // }
        //
        //               }
        //             },
        //             child: Container(
        //               // btn123 (234:33)
        //               width: double.infinity,
        //               height: 55 * fem,
        //               decoration: BoxDecoration(
        //                 color: Color(0xff368596),
        //                 borderRadius: BorderRadius.circular(10 * fem),
        //               ),
        //               child: Center(
        //                 child: Text(
        //                   'Submit',
        //                   textAlign: TextAlign.center,
        //                   style: SafeGoogleFont(
        //                     'Poppins Medium',
        //                     fontSize: 16 * ffem,
        //                     fontWeight: FontWeight.w400,
        //                     height: 1.2575 * ffem / fem,
        //                     letterSpacing: 1.6 * fem,
        //                     color: Color(0xffffffff),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
