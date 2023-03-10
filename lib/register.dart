import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mothering_business_network/controller/businessclassificationcontroller.dart';
import 'package:mothering_business_network/controller/businessclassificationcontroller.dart';
import 'package:mothering_business_network/controller/businesspresencecontroller.dart';
import 'package:mothering_business_network/controller/cityListController.dart';
import 'package:mothering_business_network/exception/DioException.dart';
import 'package:mothering_business_network/models/BusinessClassification.dart';
import 'package:mothering_business_network/models/BusinessPresence.dart';
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:mothering_business_network/models/Designation.dart' as designationData;
import 'package:mothering_business_network/models/Registration.dart';
import 'package:mothering_business_network/successfulregistration.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:http/http.dart' as http;
import 'package:mothering_business_network/models/City.dart' as cityData;
import 'package:mothering_business_network/models/BusinessClassification.dart'
    as businessClassification;
import 'package:mothering_business_network/models/BusinessPresence.dart'
    as businessPresence;
import 'dart:async';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, rootBundle;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller/designationListController.dart';
import 'package:http_parser/http_parser.dart';

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController companynameController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController businessinfoController = TextEditingController();
  TextEditingController businesscategoryController = TextEditingController();
  TextEditingController establishmentyearController = TextEditingController();
  TextEditingController membersinceController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  bool _isObscure = false;
  File _file;
  String errorMsg = '';
  String _selectedDesignation;
  String designationId;
  String cityerrorMsg = '';
  String _selectedcity;
  String cityId;
  String businessclassificationerrorMsg = '';
  String _selectedbusinessclassification;
  String businessclassificationId;
  String businesspresenceerrorMsg = '';
  String _selectedbusinesspresence;
  String businesspresenceId;
  bool value =false;
  Future<void> _launched;
  bool isSelected = false;

  DesignationListController designationListController =
      Get.put(DesignationListController());
  CityListController cityListController = Get.put(CityListController());
  BusinessClassificationController businessClassificationController =
      Get.put(BusinessClassificationController());
  BusinessPresenceController businessPresenceController =
      Get.put(BusinessPresenceController());
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  Future<RegistrationData> postRequest() async {
    var url = 'https://mbnindia.com/webservice/api/registration';
    var token = "HDJJHJHJHSJHDJAHDAD";
    var dioRequest = dio.Dio();
    // dioRequest.options.baseUrl = '<YOUR-URL>';

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
    print(_file.path);
    FormData formData = FormData.fromMap({
      'name': nameController.text,
      'designation_id': designationId,
      'city_id': cityId,
      'email': emailController.text,
      'mobile_number': phoneController.text,
      // 'profile_pic': _file != null
      //     ? await MultipartFile.fromFile(_file.path, filename: 'image.jpg')
      //     : MultipartFile.fromBytes(
      //         await rootBundle.load('assets/img.png').then(
      //               (data) => data.buffer.asUint8List(),
      //             ),
      //       ),
      'password': passwordController.text,
      'instagram': instagramController.text,
      'about': aboutController.text,
      'company_name': companynameController.text,
      'gst': gstController.text,
      'business_information': businessinfoController.text,
      'business_category': businesscategoryController.text,
      'business_classification': businessclassificationId,
      'years_establishment': establishmentyearController.text,
      'business_presence': businesspresenceId,
      'member_since': membersinceController.text,
      'fcm_token': token,
    });
    var file = await dio.MultipartFile.fromFile(_file.path,
        filename: _file.path, contentType: MediaType("image", _file.path));

    formData.files.add(MapEntry('profile_pic', file));
    print(formData.fields);
    var response = await dioRequest.post(
      url,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "User-Agent": "PostmanRuntime/7.30.0",
          "Accept": "*/*",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive"
        },
      ),
      data: formData,
      onSendProgress: (received, total) {
        setState(() {});
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + '%');
        }
      },
    ).catchError((e) {
      print(e);
      final errorMessage = DioExceptions.fromDioError(e).toString();
      setState(() {
        _btnController.error();
      });
    });
    print(response.statusCode);
    var jsonObject = json.decode(response.toString());
    if (response.statusCode == 200) {
      if (RegistrationData.fromJson(jsonObject).status == 200) {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs?.setBool("isLoggedIn", true);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SuccessfulRegistration(),
        ));
        setState(() {
          Timer(Duration(seconds: 0), () {
            _btnController.success();
          });
        });
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   duration: Duration(seconds: 1),
        //   content: Text(
        //     "Registered Successful",
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Colors.greenAccent,
        // ));
        // Timer(Duration(seconds: 3), () {
        //   Navigator.of(context).pop();
        // });
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => HomeScreen(),
        // ));
      } else if (RegistrationData.fromJson(jsonObject).status == 400) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text(RegistrationData.fromJson(jsonObject).message),
            backgroundColor: Colors.redAccent));
        // Timer(Duration(seconds: 3), () {
        //   Navigator.of(context).pop();
        // });
      }

      // print(Logindata.fromJson(jsonObject).message);
      print(RegistrationData.fromJson(jsonObject).toString());
      // return RegistrationData.fromJson(
      //     jsonObject); // you can mapping json object also here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sending Message"),
      )); // you can mapping json object also here
    }
    return jsonObject;
    // return response;
  }

  Future pickDocument() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = File(result.files.single.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Cancelled",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  @override
  void initState() {
    designationListController.fetchDesignationList();
    cityListController.fetchCityList();
    businessPresenceController.fetchBusinessPresenceList();
    businessClassificationController.fetchBusinessClassificationList();
    super.initState();
  }

  bool isEmail(String input) => EmailValidator.validate(input);
  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xff111111),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
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
                    height: 60,
                  ),
                  Container(
                    // autogroup1ywq5yd (L63hMAorJkjaq8BRBX1ywq)
                    padding: EdgeInsets.fromLTRB(
                        20 * fem, 0 * fem, 20 * fem, 50 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // textsn7M (234:27)
                          margin: EdgeInsets.fromLTRB(
                              32.5 * fem, 0 * fem, 31.5 * fem, 30 * fem),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // loginorregisterHpo (234:28)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 1 * fem, 12.75 * fem),
                                child: Text(
                                  'Registration',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Poppins SemiBold',
                                    fontSize: 30 * ffem,
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
                                  'Enter your details to register',
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
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 5 * fem, 18 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
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
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        Container(
                          height: 13.h,
                          width: 330,
                          padding: EdgeInsets.only(top: 10),
                          child: Obx(() => getDesignationDropDown(
                              designationListController.designationList)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 11.5.h,
                          width: 330,
                          child: Obx(() =>
                              getCityDropDown(cityListController.cityList)),
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 15 * fem, 18 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value.isEmpty &&
                                  !isPhone(value) &&
                                  value.length != 10) {
                                return 'Please enter 10 digit phone number in correct format';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 5 * fem, 18 * fem, 16 * fem),
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
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Password',
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
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 5 * fem, 18 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: instagramController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your instagram id';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Instagram',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Choose image',
                              style: TextStyle(
                                color: Color(0xff8e9aa6),
                                fontSize: 13,
                                fontFamily: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                ).fontFamily,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                pickDocument();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 330,
                                padding: const EdgeInsets.only(left: 20),
                                height: 58,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffd5dce0),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        _file == null
                                            ? ''
                                            : _file.path.split('/').last,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                          ).fontFamily,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 18),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF222744),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'Browse',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontFamily: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                          ).fontFamily,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 5 * fem, 18 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: aboutController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter about you';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'About',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 5 * fem, 18 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: companynameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter company name';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Company Name',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 5 * fem, 18 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: gstController,
                            maxLength: 15,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your GST No.';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'GST',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 5 * fem, 18 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: businessinfoController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter business information';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Business Information',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 5 * fem, 18 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: businesscategoryController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Business Category';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Business Category',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        Container(
                          height: 13.h,
                          width: 330,
                          padding: EdgeInsets.only(top: 10),
                          child: Obx(() => getBusinessClassificationDropDown(
                              businessClassificationController
                                  .businessclassificationList)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 13.h,
                          width: 330,
                          child: Obx(() => getBusinessPresenceDropDown(
                              businessPresenceController.businesspresenceList)),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 5 * fem, 18 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: establishmentyearController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your establishment year';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Establishment Year',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              18 * fem, 5 * fem, 18 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: membersinceController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter member since';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Member Since',
                                labelStyle: new TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              side: BorderSide(color: Colors.white),
                              value: value,
                              activeColor: Colors.white10,
                              checkColor: Colors.white,
                              onChanged: (value) {
                                setState(() {
                                  this.value = value;
                                  value=!value;
                                });
                              },
                            ),
                            Expanded(
                              child: Wrap(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                            "By continuing, you agree that you have read and accept our ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[600],
                                            )),
                                        TextSpan(
                                            text: "T&Cs",
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              decoration: TextDecoration.underline,
                                              fontSize: 15,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                setState(() {
                                                  _launched = _launchInBrowser(Uri.parse('https://mothering.in/web/terms'));
                                                });
                                              }),
                                        TextSpan(
                                            text: " and ",
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 15,
                                            )),
                                        TextSpan(
                                            text: "Privacy Policy",
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              decoration: TextDecoration.underline,
                                              fontSize: 15,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                setState(() {
                                                  _launched = _launchInBrowser(Uri.parse('https://mothering.in/web/privacy-policy'));
                                                });
                                              })
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RoundedLoadingButton(
                          width: 350,
                          borderRadius: 15,
                          color: Color(0xff368596),
                          child: Text('Register', style: SafeGoogleFont(
                            'Poppins Medium',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2575 * ffem / fem,
                            letterSpacing: 1.6 * fem,
                            color: Color(0xffffffff),
                          ),),
                          onPressed: (){
                            if (_formKey.currentState.validate() && isSelected) {
                              postRequest();
                              Timer(Duration(seconds: 3), () {
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
                        // GestureDetector(
                        //   onTap: () {
                        //     if (_formKey.currentState.validate()) {
                        //       postRequest();
                        //     }
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
        ),
      ),
    );

  }
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }

  Widget getDesignationDropDown(List<designationData.Data> designations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Designation',
          style: TextStyle(
            color: Color(0xff8e9aa6),
            fontSize: 13,
            fontFamily: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
            ).fontFamily,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DropdownSearch<String>(
          validator: (value) {
            if (value == null) {
              return 'Please select a designation';
            }
            return null;
          },
          items: designations.map((e) => e.name).toList(),
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            constraints: BoxConstraints(maxHeight: 200),
            itemBuilder: (context, item, isSelected) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                        ).fontFamily,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xff8e9aa6),
                    thickness: 0.5,
                  )
                ],
              );
            },
          ),
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem ?? '',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontFamily: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ).fontFamily,
              ),
            );
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
              ).fontFamily,
            ),
            dropdownSearchDecoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize: 8,
                color: Color(0xffde5151),
                fontFamily: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ).fontFamily,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffd5dce0),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffde5151),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xff5374ff),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffde5151),
                ),
              ),
            ),
          ),
          onChanged: (dynamic newValue) async {
            setState(() {
              errorMsg = '';
              _selectedDesignation = newValue;
              designationId =
                  designations.singleWhere((e) => e.name == newValue).id;
              print(designationId);
            });
          },
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectedItem: _selectedDesignation,
        ),
      ],
    );
  }

  Widget getCityDropDown(List<cityData.Data> cities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'City',
          style: TextStyle(
            color: Color(0xff8e9aa6),
            fontSize: 13,
            fontFamily: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
            ).fontFamily,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DropdownSearch<String>(
          validator: (value) {
            if (value == null) {
              return 'Please select a city';
            }
            return null;
          },
          items: cities.map((e) => e.name).toList(),
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            constraints: BoxConstraints(maxHeight: 200),
            itemBuilder: (context, item, isSelected) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                        ).fontFamily,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xff8e9aa6),
                    thickness: 0.5,
                  )
                ],
              );
            },
          ),
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem ?? '',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontFamily: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ).fontFamily,
              ),
            );
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
              ).fontFamily,
            ),
            dropdownSearchDecoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize: 8,
                color: Color(0xffde5151),
                fontFamily: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ).fontFamily,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffd5dce0),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffde5151),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xff5374ff),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffde5151),
                ),
              ),
            ),
          ),
          onChanged: (dynamic newValue) async {
            setState(() {
              cityerrorMsg = '';
              _selectedcity = newValue;
              cityId = cities.singleWhere((e) => e.name == newValue).id;
              print(cityId);
            });
          },
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectedItem: _selectedcity,
        ),
      ],
    );
  }

  Widget getBusinessClassificationDropDown(
      List<businessClassification.Data> designations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Business Classification',
          style: TextStyle(
            color: Color(0xff8e9aa6),
            fontSize: 13,
            fontFamily: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
            ).fontFamily,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DropdownSearch<String>(
          validator: (value) {
            if (value == null) {
              return 'Please select a business classification';
            }
            return null;
          },
          items: designations.map((e) => e.name).toList(),
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            constraints: BoxConstraints(maxHeight: 200),
            itemBuilder: (context, item, isSelected) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                        ).fontFamily,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xff8e9aa6),
                    thickness: 0.5,
                  )
                ],
              );
            },
          ),
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem ?? '',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontFamily: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ).fontFamily,
              ),
            );
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
              ).fontFamily,
            ),
            dropdownSearchDecoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize: 8,
                color: Color(0xffde5151),
                fontFamily: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ).fontFamily,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffd5dce0),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffde5151),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xff5374ff),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffde5151),
                ),
              ),
            ),
          ),
          onChanged: (dynamic newValue) async {
            setState(() {
              businessclassificationerrorMsg = '';
              _selectedbusinessclassification = newValue;
              businessclassificationId =
                  designations.singleWhere((e) => e.name == newValue).id;
              print(businessclassificationId);
            });
          },
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectedItem: _selectedbusinessclassification,
        ),
      ],
    );
  }

  Widget getBusinessPresenceDropDown(List<businessPresence.Data> designations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Business Presence',
          style: TextStyle(
            color: Color(0xff8e9aa6),
            fontSize: 13,
            fontFamily: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
            ).fontFamily,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DropdownSearch<String>(
          validator: (value) {
            if (value == null) {
              return 'Please select a business presence';
            }
            return null;
          },
          items: designations.map((e) => e.name).toList(),
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            constraints: BoxConstraints(maxHeight: 200),
            itemBuilder: (context, item, isSelected) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                        ).fontFamily,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xff8e9aa6),
                    thickness: 0.5,
                  )
                ],
              );
            },
          ),
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem ?? '',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontFamily: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ).fontFamily,
              ),
            );
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
              ).fontFamily,
            ),
            dropdownSearchDecoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize: 8,
                color: Color(0xffde5151),
                fontFamily: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ).fontFamily,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffd5dce0),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffde5151),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xff5374ff),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffde5151),
                ),
              ),
            ),
          ),
          onChanged: (dynamic newValue) async {
            setState(() {
              businesspresenceerrorMsg = '';
              _selectedbusinesspresence = newValue;
              businesspresenceId =
                  designations.singleWhere((e) => e.name == newValue).id;
              print(businesspresenceId);
            });
          },
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectedItem: _selectedbusinesspresence,
        ),
      ],
    );
  }
}
