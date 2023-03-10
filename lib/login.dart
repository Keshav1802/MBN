import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mothering_business_network/forgotPassword.dart';
import 'package:mothering_business_network/landingpage.dart';
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:mothering_business_network/register.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _isObscure = false;
  LoginData _loginData =LoginData();

  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  Future<LoginData> postRequest(
    String username,
    String password,
  ) async {
    var url = 'https://mbnindia.com/webservice/api/login';
    var token = "HDJJHJHJHSJHDJAHDAD";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "User-Agent": "PostmanRuntime/7.30.0",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    };

    // Map data = {
    //   'username': username,
    //   'password': password,
    //   'fcm_token':token,
    // };
    //encode Map to JSON
    // var body = json.encode(data);

    FormData formData = FormData.fromMap({
      'email': username,
      'password': password,
      'fcm_token': token,
    });
    print(formData.fields);
    var response = await Dio().post(url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
          },
        ),
        data: formData);
    // print(response.data);
    // String jsonsDataString = response.data.toString();
    var jsonObject = jsonDecode(response.toString());
    // print(jsonObject.toString());
    if (response.statusCode == 200) {
      if (LoginData.fromJson(jsonObject).status == 200) {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs?.setBool("isLoggedIn", true);
        setState(() {
          Timer(Duration(seconds: 1), () {
            _btnController.success();
          });
        });
        SharedPreferences pref = await SharedPreferences.getInstance();
        // var json = jsonDecode(jsonObject);
        String user = jsonEncode(jsonObject);
        print(user.toString());
        pref.setString('userData', user);
        pref?.setBool("isLoggedIn", true);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            "Login Successful",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.greenAccent,
        ));
        Map json1 = jsonDecode(pref.getString('userData'));
        var user1 = LoginData.fromJson(json1);
        print(user1.data);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => landingPage(
              user1.data.name,
              user1.data.id,
              user1.data.chepterId,
              user1.data.cityId,
              user1.data.chapterDetails?? "",
              user1.data.chapterUserDetails?? "",
              user1.data),
        ));
      } else if (LoginData.fromJson(jsonObject).status == 400) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(LoginData.fromJson(jsonObject).message),
            backgroundColor: Colors.redAccent));
        setState(() {
          _btnController.error();
        });
      }
      else if (LoginData.fromJson(jsonObject).data.chepterName == null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Server Error..Please try again after sometime', style: SafeGoogleFont(
              'Poppins SemiBold',
              // fontSize: 18 * ffem,
              fontWeight: FontWeight.w400,
              // height: 1.2575 * ffem / fem,
              color: Colors.black,
            ),),
            backgroundColor: Colors.redAccent));
        setState(() {
          _btnController.error();
        });

      }

      // print(Logindata.fromJson(jsonObject).message);
      print(LoginData.fromJson(jsonObject).toString());
      return LoginData.fromJson(
          jsonObject); // you can mapping json object also here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sending Message"),
      )); // you can mapping json object also here
    }
    return jsonObject;
    // return response;
  }

  bool isEmail(String input) => EmailValidator.validate(input);
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff111111),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  'assets/MBN_Logo.png',
                  // height: 170,
                  width: 110,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                // autogroup1ywq5yd (L63hMAorJkjaq8BRBX1ywq)
                padding:
                    EdgeInsets.fromLTRB(20 * fem, 0 * fem, 20 * fem, 50 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // textsn7M (234:27)
                      margin: EdgeInsets.fromLTRB(
                          32.5 * fem, 0 * fem, 31.5 * fem, 50 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // loginorregisterHpo (234:28)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 1 * fem, 12.75 * fem),
                            child: Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Poppins SemiBold',
                                fontSize: 40 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2575 * ffem / fem,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            // enteryourphonenooremailsubmito (234:29)
                            constraints: BoxConstraints(
                              maxWidth: 310 * fem,
                            ),
                            child: Text(
                              'Enter your email & password\n to get the best of the app ',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3999999762 * ffem / fem,
                                color: Color(0xff545d73),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // emailorphnmbrCKV (234:30)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 15 * fem),
                      padding: EdgeInsets.fromLTRB(
                          18 * fem, 5 * fem, 18 * fem, 16 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Color(0xd8e3e6ef)),
                        color: Color(0xff111111),
                        borderRadius: BorderRadius.circular(5 * fem),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value.isEmpty && !isEmail(value)) {
                            return 'Please enter email in correct format';
                          }
                          return null;
                        },
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * ffem / fem,
                          color: Color(0xff545d73),
                        ),
                        decoration: InputDecoration(
                            labelText: 'Enter Email',
                            labelStyle: new TextStyle(
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            prefixIcon: Icon(
                              Icons.mail_outlined,
                              color: Colors.white,
                            ),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    Container(
                      // emailorphnmbrCKV (234:30)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 15 * fem),
                      padding: EdgeInsets.fromLTRB(
                          18 * fem, 15 * fem, 18 * fem, 0 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Color(0xd8e3e6ef)),
                        color: Color(0xff111111),
                        borderRadius: BorderRadius.circular(5 * fem),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !_isObscure,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * ffem / fem,
                          color: Color(0xff545d73),
                        ),
                        decoration: InputDecoration(
                            labelText: 'Enter your password',
                            labelStyle: new TextStyle(
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 45 * fem),
                      alignment: Alignment.centerRight,
                      // child: GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => ForgotPassword(),
                      //     ));
                      //   },
                      //   child: const Text(
                      //     'Forgot password?',
                      //     style: TextStyle(fontSize: 16.0, color: Colors.white),
                      //   ),
                      // ),
                    ),
                    RoundedLoadingButton(
                      width: 350,
                      borderRadius: 15,
                      color: Color(0xff368596),
                      child: Text('Continue', style: SafeGoogleFont(
                        'Poppins Medium',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2575 * ffem / fem,
                        letterSpacing: 1.6 * fem,
                        color: Color(0xffffffff),
                      ),),
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                          postRequest(
                            emailController.text,
                            passwordController.text,
                          );
                          Timer(Duration(seconds: 3), () {
                            emailController.clear();
                            passwordController.clear();
                            _btnController.reset();
                          });
                          // print(field);
                          // if(cred!.=='success'){
                          //
                          // }

                        } else{
                          setState(() {
                            Timer(Duration(seconds:0), () {
                              _btnController.reset();
                            });
                          });
                        }
                      },
                      controller: _btnController,
                      successColor: Color(0xff368596),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Not yet an MBN Member, ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        const SizedBox(width: 2),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Registration(),
                            ));
                          },
                          child: const Text(
                            'Register Yourself! ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0, color: Color(0xff368596),decoration: TextDecoration.underline,),
                          ),
                        ),
                        // const Text(
                        //   ' to the sign in screen',
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(fontSize: 16.0, color: Colors.white),
                        // ),
                      ],
                    ),
                    // Container(
                    //   // orMEK (234:37)
                    //   margin: EdgeInsets.fromLTRB(
                    //       0 * fem, 45 * fem, 0 * fem, 27 * fem),
                    //   width: double.infinity,
                    //   height: 44 * fem,
                    //   child: Stack(
                    //     children: [
                    //       Positioned(
                    //         // orFqV (234:39)
                    //         left: 165 * fem,
                    //         top: 0 * fem,
                    //         child: Container(
                    //           width: 44 * fem,
                    //           height: 44 * fem,
                    //           decoration: BoxDecoration(
                    //             border: Border.all(color: Color(0xff090909)),
                    //             color: Color(0xffdddddd),
                    //             borderRadius: BorderRadius.circular(22 * fem),
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //               'OR',
                    //               textAlign: TextAlign.center,
                    //               style: SafeGoogleFont(
                    //                 'Poppins Medium',
                    //                 fontSize: 15 * ffem,
                    //                 fontWeight: FontWeight.w400,
                    //                 height: 1.4 * ffem / fem,
                    //                 letterSpacing: 0.15 * fem,
                    //                 color: Color(0xff333333),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => Registration(),
                    //     ));
                    //   },
                    //   child: Container(
                    //     // btn123 (234:33)
                    //     width: double.infinity,
                    //     height: 55 * fem,
                    //     decoration: BoxDecoration(
                    //       color: Color(0xff368596),
                    //       borderRadius: BorderRadius.circular(5 * fem),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         'Register',
                    //         textAlign: TextAlign.center,
                    //         style: SafeGoogleFont(
                    //           'Poppins Medium',
                    //           fontSize: 16 * ffem,
                    //           fontWeight: FontWeight.w400,
                    //           height: 1.2575 * ffem / fem,
                    //           letterSpacing: 1.6 * fem,
                    //           color: Color(0xffffffff),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
