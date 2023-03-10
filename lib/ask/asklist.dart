import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mothering_business_network/Guest/guestlistadd.dart';
import 'package:mothering_business_network/Invite/invitelistadd.dart';
import 'package:mothering_business_network/ask/asklistadd.dart';
import 'package:mothering_business_network/models/AskList.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AskListPage extends StatefulWidget {
  String user_id;
  String name;

  AskListPage(this.user_id,this.name);

  @override
  State<AskListPage> createState() => _AskListPageState();
}

class _AskListPageState extends State<AskListPage> {
  Future<AskList> ask;
  List<Data> asklist = [];

  Future<AskList> getAsk() async {
    Map data = {
      'user_id': widget.user_id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
    await Dio().post("https://mbnindia.com/webservice/api/askList",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
          },
        ),
        data: body);
    var jsonData = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      print(jsonData);
      if (jsonData['status'] == 200) {
        return AskList.fromJson(jsonData);
        // inviteList.sort((a, b) => a.id.compareTo(b.id));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            jsonData['message'] + ' Please check after sometime.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ));
      }
      // List<dynamic> dataList = [];
      // dataList = jsonDecode(data.body)["prices"];
      // for (Map i in data) {
      //   postList.add(PostsModels.fromJson(i));
      // }
      // return postList;
    } else {
      throw Exception('Failed to load');
    }
    return jsonData;
  }

  @override
  void initState() {
    ask = getAsk();
    ask.then((value) {
      setState(() {
        asklist = value.data;
      });
    });

    super.initState();
  }

  // Future<void> refresh(){
  //   invite = getInvite();
  //   invite.then((value) {
  //     setState(() {
  //       inviteList = value.data;
  //     });
  //   });
  // }

  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  String stringToYesNO(String data) {
    if (data == '0')
      return "Inactive";
    else
      return "Active";
    //   return data == true ? "Yes" : "No";
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ask (List)",
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
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff9BA6BF),
            size: 19,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          Tooltip(
            message: "Add", waitDuration: Duration(seconds: 1),
            showDuration: Duration(seconds: 2),
            // padding: EdgeInsets.all(5),
            height: 35,
            textStyle: SafeGoogleFont(
              'Poppins SemiBold',
              fontSize: 16 * ffem,
              fontWeight: FontWeight.w400,
              height: 1.2575 * ffem / fem,
              color: Color(0xff9BA6BF),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.black54),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Color(0xff9BA6BF),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AskListAdd(),
                ));
                // do something
              },
            ),
          ),
        ],
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
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              ask = getAsk();
              ask.then((value) {
                setState(() {
                  asklist = value.data;
                });
              });
            });
          },
          color: Color(0xff9BA6BF),
          child: Column(
            children: [
              FutureBuilder(
                  future: ask,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data.length == 0) {
                        return Center(
                            child: Text('No data available.',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff45536A),
                                )));
                      } else {
                        return Expanded(
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: asklist.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xff262B36)),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        // width: 96.w,
                                        height: 12.h,
                                        padding:
                                        EdgeInsets.fromLTRB(20, 45, 10, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints: const BoxConstraints(
                                                maxWidth: 380,
                                              ),
                                              child: FittedBox(
                                                fit:BoxFit.fill,
                                                child: Text(
                                                  asklist[index]
                                                      .name[0]
                                                      .toUpperCase() +
                                                      asklist[index]
                                                          .name
                                                          .substring(1)
                                                          .toLowerCase()+" asked by "+widget.name,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  style: SafeGoogleFont(
                                                    'Poppins Medium',
                                                    fontSize: 20 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.4 * ffem / fem,
                                                    letterSpacing: 0.2 * fem,
                                                    color: Color(0xffcccccc),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   height: 50,
                                      //   // color: Colors.blue,
                                      //   child: Row(
                                      //     children: [
                                      //       SizedBox(
                                      //         width: 15,
                                      //       ),
                                      //       Expanded(
                                      //           flex: 1,
                                      //           child: Text(guestlist[index].id,
                                      //               style: SafeGoogleFont(
                                      //                 'Poppins SemiBold',
                                      //                 // fontSize: 15 * ffem,
                                      //                 fontWeight: FontWeight.w400,
                                      //                 height: 1.2575 * ffem / fem,
                                      //                 color: Color(0xff9BA6BF),
                                      //               ))),
                                      //       SizedBox(
                                      //         width: 15,
                                      //       ),
                                      //       Expanded(
                                      //         flex: 2,
                                      //         child: Container(
                                      //           width: 80,
                                      //           child: Text(guestlist[index].name,
                                      //               style: SafeGoogleFont(
                                      //                 'Poppins SemiBold',
                                      //                 // fontSize: 15 * ffem,
                                      //                 fontWeight: FontWeight.w400,
                                      //                 height: 1.2575 * ffem / fem,
                                      //                 color: Color(0xff9BA6BF),
                                      //               )),
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         width: 10,
                                      //       ),
                                      //       Expanded(
                                      //           flex: 2,
                                      //           child: Text(
                                      //               guestlist[index].category==null?'':
                                      //               guestlist[index].category,
                                      //               style: SafeGoogleFont(
                                      //                 'Poppins SemiBold',
                                      //                 // fontSize: 15 * ffem,
                                      //                 fontWeight: FontWeight.w400,
                                      //                 height: 1.2575 * ffem / fem,
                                      //                 color: Color(0xff9BA6BF),
                                      //               ))),
                                      //       SizedBox(
                                      //         width: 5,
                                      //       ),
                                      //       Expanded(
                                      //           flex: 2,
                                      //           child: Text(guestlist[index].meetingDate==null?'':
                                      //               _dateFormat.format(DateTime
                                      //                   .parse(guestlist[index].meetingDate)),
                                      //               // inviteList[index].cityName ==
                                      //               //     null
                                      //               //     ? ''
                                      //               //     : inviteList[index]
                                      //               //     .cityName,
                                      //               style: SafeGoogleFont(
                                      //                 'Poppins SemiBold',
                                      //                 // fontSize: 17 * ffem,
                                      //                 fontWeight: FontWeight.w400,
                                      //                 height: 1.2575 * ffem / fem,
                                      //                 color: Color(0xff9BA6BF),
                                      //               ))),
                                      //       SizedBox(
                                      //         width: 15,
                                      //       ),
                                      //       Expanded(
                                      //           flex: 1,
                                      //           child: Text(
                                      //             stringToYesNO(guestlist[index].isActive),
                                      //             // guestlist[index].isActive != null?"No":"Yes",
                                      //             style: SafeGoogleFont(
                                      //               'Poppins SemiBold',
                                      //               fontSize: 15 * ffem,
                                      //               fontWeight: FontWeight.w400,
                                      //               height: 1.2575 * ffem / fem,
                                      //               color: Color(0xff9BA6BF),
                                      //             ),
                                      //           )),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                );
                              }),
                        );
                      }
                    } else {
                      return const Center(
                        heightFactor: 15,
                        child: CircularProgressIndicator(
                          color: Color(0xff9BA6BF),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
