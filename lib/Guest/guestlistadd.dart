import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mothering_business_network/models/InviteAdd.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:mothering_business_network/widget/date_selector_textfield.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

class GuestListAdd extends StatefulWidget {
  // String user_id;
  // String city_id;
  // String chapter_id;

  // GuestListAdd(this.user_id, this.city_id, this.chapter_id);

  @override
  State<GuestListAdd> createState() => _GuestListAddState();
}

class _GuestListAddState extends State<GuestListAdd> {
  var _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  Future<InviteAdd> getPostApi() async {
    var url = 'https://mbnindia.com/webservice/api/guestAdd';

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
    };

    var date = _dateController.text.split('-');
    var correctdate = date[2] + '-' + date[1] + '-' + date[0];

    Map data = {
      // 'user_id': widget.user_id,
      'chapter_id': "12", //widget.chapter_id
      // 'city_id': widget.city_id,
      'name': nameController.text,
      'category': businessCategoryController.text,
      'meeting_date': correctdate,
    };
    //encode Map to JSON
    print(data.values);
    var body = json.encode(data);
    // FormData formData = FormData.fromMap({
    //   'event_id': widget.event_id,
    //   'qr': code,
    // });

    var response = await Dio().post(url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
          },
        ),
        data: body);
    print("${response.statusCode}");
    print(response.toString());
    var jsonObject = json.decode(response.toString());
    if (response.statusCode == 200) {
      if (jsonObject['status'] == 200) {
        // return InviteAdd.fromJson(jsonObject);
        setState(() {
          Timer(Duration(seconds: 1), () {
            _btnController.success();
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Guest has been added send successfully',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.greenAccent,
        ));
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      }
      // return jsonObject ;// you can mapping json object also here
    } else {
      setState(() {
        Timer(Duration(seconds: 1), () {
          _btnController.error();
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          jsonObject['message'] + ' Please try after sometime.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ));
    }
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("Sending Message"),
    // )); // you can mapping json object also here
    return jsonObject;
  }

  bool isEmail(String input) => EmailValidator.validate(input);
  final _dateController = TextEditingController();
  final nameController = TextEditingController();
  final businessCategoryController = TextEditingController();
  DateTime _publishDate = DateTime.now();
  DateTimePickerLocale locale = DateTimePickerLocale.en_us;
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  DateTime minDate;
  DateTime _date;
  DateTime maxDate;
  DateTime initialDate;
  String dateFormat;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add a (Guest)",
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Poppins SemiBold',
            fontSize: 24 * ffem,
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
        leading: IconButton(
          icon:
          Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xff9BA6BF)),
          onPressed: () => Navigator.of(context).pop(),
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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  // emailorphnmbrCKV (234:30)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 15 * fem),
                  padding:
                      EdgeInsets.fromLTRB(25 * fem, 5 * fem, 25 * fem, 16 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Color(0xd8e3e6ef)),
                    // color: Color(0xff111111),
                    borderRadius: BorderRadius.circular(5 * fem),
                  ),
                  child: TextFormField(
                    controller: nameController,
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
                      color: Colors.grey,
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
                        prefixIcon: Icon(
                          Icons.mail_outlined,
                          color: Colors.white,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        25 * fem, 5 * fem, 25 * fem, 16 * fem),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meeting Date',
                          style: TextStyle(
                            color: Color(0xff8e9aa6),
                            fontSize: 10.sp,
                            fontFamily: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                            ).fontFamily,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _dateController,
                          cursorWidth: 1.sp,
                          cursorHeight: 18.sp,
                          textCapitalization: TextCapitalization.sentences,
                          showCursor: true,
                          enabled: true,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontFamily: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                            ).fontFamily,
                          ),
                          readOnly: true,
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                                confirm: Text('Done',
                                    style: TextStyle(color: Color(0xff006400))),
                                cancel: Text('Cancel',
                                    style: TextStyle(color: Colors.red)),
                                itemHeight: 40,
                              ),
                              pickerMode: DateTimePickerMode.date,
                              minDateTime: minDate,
                              initialDateTime: initialDate,
                              maxDateTime: maxDate,
                              dateFormat: 'dd-MM-yyyy',
                              locale: locale,
                              onClose: () => print('----- onClose -----'),
                              onCancel: () => print('onCancel'),
                              onChange: (dateTime, List<int> index) {
                                setState(() {
                                  _date = dateTime;
                                  _dateController.text =
                                      DateFormat('dd-MM-yyyy').format(dateTime);
                                  print(_dateController.text);
                                });
                              },
                              onConfirm: (dateTime, List<int> index) {
                                setState(() {
                                  setState(() {
                                    _date = dateTime;
                                    _dateController.text =
                                        DateFormat('dd-MM-yyyy').format(dateTime);
                                    print(_dateController.text);
                                  });
                                });
                              },
                            );
                          },
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              'assets/calendar-2852107 (1).png',
                              width: 3,
                              height: 3,
                              fit: BoxFit.scaleDown,
                              color: Colors.white,
                            ),
                            errorStyle: TextStyle(
                              fontSize: 8.sp,
                              color: Color(0xffde5151),
                              fontFamily: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                              ).fontFamily,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Color(0xffd5dce0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Color(0xff5374ff),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Color(0xffde5151),
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Color(0xffde5151),
                              ),
                            ),
                          ),
                          inputFormatters: [
                            //formatter for date
                            FilteringTextInputFormatter.singleLineFormatter,
                            //formatter for date in dd/mm/yyyy format
                            FilteringTextInputFormatter.deny(RegExp(r'[^0-9/]')),
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter meeting date';
                            }
                            return null;
                          },
                        ),
                      ],
                    )
                    // Column(
                    //
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     DateSelectorTextField(
                    //       controller: _dateController,
                    //       locale: locale,
                    //       title: 'Meeting Date',
                    //       validatorMessage:
                    //       'Please select Meeting date',
                    //       onDateSelected: (date) {
                    //         setState(() {
                    //           _publishDate = DateTime.parse(date);
                    //           _dateController.text =
                    //               _dateFormat.format(DateTime.parse(date));
                    //           print(_publishDate);
                    //         });
                    //       },
                    //     ),
                    //   ],
                    // ),
                    ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // emailorphnmbrCKV (234:30)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 15 * fem),
                  padding:
                      EdgeInsets.fromLTRB(25 * fem, 5 * fem, 25 * fem, 16 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Color(0xd8e3e6ef)),
                    // color: Color(0xff111111),
                    borderRadius: BorderRadius.circular(5 * fem),
                  ),
                  child: TextFormField(
                    controller: businessCategoryController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Business Category';
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
                        prefixIcon: Icon(
                          Icons.mail_outlined,
                          color: Colors.white,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.fromLTRB(25 * fem, 5 * fem, 25 * fem, 16 * fem),
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
                        getPostApi();
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
                  //       getPostApi();
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
    );
  }
}
