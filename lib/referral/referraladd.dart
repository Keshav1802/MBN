import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:mothering_business_network/controller/cityListController.dart';
import 'package:mothering_business_network/exception/DioException.dart';
import 'package:mothering_business_network/models/InviteAdd.dart';
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:mothering_business_network/models/ReferralAdd.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:mothering_business_network/widget/date_selector_textfield.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:mothering_business_network/models/City.dart' as cityData;
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';

class ReferralAddPage extends StatefulWidget {
  String user_id;
  Data loginData;
  // String city_id;
  // String chapter_id;
  ChapterDetails chapterDetails;
  List<ChapterUserDetails> chapterUserDetails;

  ReferralAddPage(this.user_id,
      this.loginData, this.chapterDetails, this.chapterUserDetails);

  @override
  State<ReferralAddPage> createState() => _ReferralAddPageState();
}

class _ReferralAddPageState extends State<ReferralAddPage> {
  var _formKey = GlobalKey<FormState>();
  HtmlEditorController controller = HtmlEditorController();
  String desc = '';

  bool isEmail(String input) => EmailValidator.validate(input);
  final _dateController = TextEditingController();
  final amountController = TextEditingController();
  final businessCategoryController = TextEditingController();
  DateTime _publishDate = DateTime.now();
  DateTimePickerLocale locale = DateTimePickerLocale.en_us;
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');
  CityListController cityListController = Get.put(CityListController());
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  File _file;
  String cityerrorMsg = '';
  String _selectedcity;
  String cityId;
  String chaptererrorMsg = '';
  String _selectedchapter;
  String chapterId;
  String chapterUserserrorMsg = '';
  String _selectedchapterUsers;
  String chapterUsersId;

  Future<void> postRequest() async {
    var url = 'https://mbnindia.com/webservice/api/addReferral';
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
    var description = await controller.getText();
    // print(_file.path);
    FormData formData = FormData.fromMap({
      'user_id': widget.loginData.id,
      'chapter_id': chapterId,
      'city_id': cityId,
      'amount': amountController.text,
      'description': description,
    });
    // var file = await dio.MultipartFile.fromFile(_file.path,
    //     filename: _file.path, contentType: MediaType("image", _file.path));
    //
    // formData.files.add(MapEntry('photo_proof', file));
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
    print(response.toString());
    // print(response.statusCode);
    var jsonObject = json.decode(response.toString());
    // print('error'+ jsonObject);
      if (ReferralAdd.fromJson(jsonObject).status == 200) {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs?.setBool("isLoggedIn", true);
        setState(() {
          Timer(Duration(seconds: 1), () {
            _btnController.success();
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            "Referral Added Successfully",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.greenAccent,
        ));
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      } else if (ReferralAdd.fromJson(jsonObject).status != 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
            Text(ReferralAdd.fromJson(jsonObject).message),
            backgroundColor: Colors.redAccent));
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      }

      // print(Logindata.fromJson(jsonObject).message);
      print(ReferralAdd.fromJson(jsonObject).toString());
      // return RegistrationData.fromJson(
      //     jsonObject); // you can mapping json object also here

    return jsonObject;
    // return response;
  }

  // Future pickDocument() async {
  //   FilePickerResult result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     setState(() {
  //       _file = File(result.files.single.path);
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         "Cancelled",
  //         style: TextStyle(color: Colors.black),
  //       ),
  //       backgroundColor: Colors.redAccent,
  //     ));
  //   }
  // }

  @override
  void initState() {
    cityListController.fetchCityList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Add a Referral",
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Poppins SemiBold',
            fontSize:25 * ffem,
            fontWeight: FontWeight.w400,
            height: 1.2575 * ffem / fem,
            color: Color(0xff9BA6BF),
          ),
        ),
        centerTitle: true,
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
        leading: IconButton(
          icon:
          Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xff9BA6BF)),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 200.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // emailorphnmbrCKV (234:30)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 15 * fem),
                          padding: EdgeInsets.fromLTRB(
                              25 * fem, 5 * fem, 25 * fem, 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xd8e3e6ef)),
                            // color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: TextFormField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Amount';
                              }
                              return null;
                            },
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Colors.grey,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Amount',
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
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       'Image',
                        //       style: TextStyle(
                        //         color: Color(0xff8e9aa6),
                        //         fontSize: 13,
                        //         fontFamily: GoogleFonts.inter(
                        //           fontWeight: FontWeight.w500,
                        //         ).fontFamily,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 5,
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         pickDocument();
                        //       },
                        //       child: Container(
                        //         alignment: Alignment.center,
                        //         width: 330,
                        //         padding: const EdgeInsets.only(left: 20),
                        //         height: 58,
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //             color: Color(0xffd5dce0),
                        //             width: 1.0,
                        //           ),
                        //           borderRadius: BorderRadius.circular(10),
                        //         ),
                        //         child: Row(
                        //           children: <Widget>[
                        //             Expanded(
                        //               child: Text(
                        //                 _file == null
                        //                     ? ''
                        //                     : _file.path.split('/').last,
                        //                 overflow: TextOverflow.ellipsis,
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 12,
                        //                   fontFamily: GoogleFonts.inter(
                        //                     fontWeight: FontWeight.w500,
                        //                   ).fontFamily,
                        //                 ),
                        //                 maxLines: 2,
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: const EdgeInsets.symmetric(
                        //                   horizontal: 15, vertical: 18),
                        //               decoration: const BoxDecoration(
                        //                 color: Color(0xFF222744),
                        //                 borderRadius: BorderRadius.only(
                        //                   topRight: Radius.circular(10),
                        //                   bottomRight: Radius.circular(10),
                        //                 ),
                        //               ),
                        //               child: Text(
                        //                 'Choose file',
                        //                 style: TextStyle(
                        //                   fontSize: 12,
                        //                   color: Colors.white,
                        //                   fontFamily: GoogleFonts.inter(
                        //                     fontWeight: FontWeight.w600,
                        //                   ).fontFamily,
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Container(
                          height: 95,
                          width: 330,
                          child: Obx(() =>
                              getCityDropDown(cityListController.cityList)),
                        ),
                        Container(
                          height: 95,
                          width: 330,
                          child: getchapterNameDropDown(widget.chapterDetails),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 95,
                          width: 330,
                          child: getchapterUsersNameDropDown(
                              widget.chapterUserDetails),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  color: Color(0xff8e9aa6),
                                  fontSize: 13,
                                  fontFamily: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                  ).fontFamily,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: MediaQuery.of(context).viewInsets,
                              padding: const EdgeInsets.fromLTRB(25, 5, 25, 16),
                              child: HtmlEditor(
                                controller: controller,
                                //required
                                htmlEditorOptions: HtmlEditorOptions(
                                    spellCheck: true,
                                    adjustHeightForKeyboard: true,
                                    initialText: desc,
                                    shouldEnsureVisible: false,
                                    autoAdjustHeight: true,
                                    androidUseHybridComposition: true),
                                htmlToolbarOptions: const HtmlToolbarOptions(
                                  defaultToolbarButtons: [
                                    StyleButtons(),
                                    FontSettingButtons(),
                                    FontButtons(),
                                    ColorButtons(),
                                    ListButtons(),
                                    ParagraphButtons(),
                                    InsertButtons(),
                                    OtherButtons(),
                                  ],
                                  toolbarPosition: ToolbarPosition.aboveEditor,
                                  toolbarType: ToolbarType.nativeScrollable,
                                  initiallyExpanded: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              25 * fem, 5 * fem, 25 * fem, 16 * fem),
                          child: RoundedLoadingButton(
                            width: 350,
                            borderRadius: 15,
                            color: Color(0xff368596),
                            child: Text('Submit', style: SafeGoogleFont(
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
                                );
                                Timer(Duration(seconds: 5), () {
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
                          //       // postRequest(
                          //       //   emailController.text,
                          //       // );
                          //       // print(field);
                          //       // if(cred!.=='success'){
                          //       //
                          //       // }
                          //
                          //     }
                          //   },
                          //   child: Container(
                          //     // btn123 (234:33)
                          //     width: double.infinity,
                          //     height: 55 * fem,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xff368596),
                          //       borderRadius: BorderRadius.circular(10 * fem),
                          //     ),
                          //     child: Center(
                          //       child: Text(
                          //         'Submit',
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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

  Widget getchapterNameDropDown(ChapterDetails chapterDetails) {
    List<String> item = [chapterDetails.name];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chapter',
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
              return 'Please select a Chapter';
            }
            return null;
          },
          items: item,
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
              chaptererrorMsg = '';
              _selectedchapter = newValue;
              chapterId = chapterDetails.id;
              print(chapterId);
            });
          },
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectedItem: _selectedchapter,
        ),
      ],
    );
  }

  Widget getchapterUsersNameDropDown(
      List<ChapterUserDetails> chapterUserDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Referral By User',
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
              return 'Please select a User';
            }
            return null;
          },
          items: chapterUserDetails.map((e) => e.name).toList(),
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
              chapterUserserrorMsg = '';
              _selectedchapterUsers = newValue;
              chapterUsersId =
                  chapterUserDetails.singleWhere((e) => e.name == newValue).id;
              print(chapterUsersId);
            });
          },
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectedItem: _selectedchapterUsers,
        ),
      ],
    );
  }
}
