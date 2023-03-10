import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mothering_business_network/Guest/guestlistadd.dart';
import 'package:mothering_business_network/Invite/invitelistadd.dart';
import 'package:mothering_business_network/models/GuestList.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class GuestListPage extends StatefulWidget {
  String user_id;

  GuestListPage(this.user_id);

  @override
  State<GuestListPage> createState() => _GuestListPageState();
}

class _GuestListPageState extends State<GuestListPage> {
  Future<GuestList> guest;
  List<Data> guestlist = [];

  Future<GuestList> getGuest() async {
    Map data = {
      'user_id': widget.user_id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await Dio().post("https://mbnindia.com/webservice/api/guestList",
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
        return GuestList.fromJson(jsonData);
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
    guest = getGuest();
    guest.then((value) {
      setState(() {
        guestlist = value.data;
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
          "Guest (List)",
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
                  builder: (context) => GuestListAdd(),
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
              guest = getGuest();
              guest.then((value) {
                setState(() {
                  guestlist = value.data;
                });
              });
            });
          },
          color: Color(0xff9BA6BF),
          child: Column(
            children: [
              FutureBuilder(
                  future: guest,
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
                              itemCount: guestlist.length,
                              itemBuilder: (context, index) {
                                var date =
                                    guestlist[index].meetingDate.split('-');
                                var correctdate =
                                    date[2] + '-' + date[1] + '-' + date[0];
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xff262B36)),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: Column(
                                    children: [
                                      // Container(
                                      //   // imgmnj (148:14)
                                      //     margin: EdgeInsets.fromLTRB(0 * fem,
                                      //         0 * fem, 10 * fem, 0.44 * fem),
                                      //     width: 83 * fem,
                                      //     height: 83 * fem,
                                      //     child: (imageUrl !=
                                      //         null) // Only use the network image if the url is not null
                                      //         ? Image.network(
                                      //       imageUrl,
                                      //       loadingBuilder: (context,
                                      //           child,
                                      //           loadingProgress) =>
                                      //       (loadingProgress ==
                                      //           null)
                                      //           ? child
                                      //           : CircularProgressIndicator(),
                                      //       errorBuilder: (context,
                                      //           error,
                                      //           stackTrace) =>
                                      //       noImage,
                                      //     )
                                      //         : noImage),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            // autogroupmaybTQf (L65rXuYySWWzA4AJ91maYb)
                                            width: 80.w,
                                            height: 14.h,
                                            padding:
                                                EdgeInsets.fromLTRB(20, 20, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // lisawales3dm (148:17)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      80 * fem,
                                                      0 * fem),
                                                  child: Text(
                                                    guestlist[index]
                                                            .name[0]
                                                            .toUpperCase() +
                                                        guestlist[index]
                                                            .name
                                                            .substring(1)
                                                            .toLowerCase(),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  // autogroup5phquR5 (L65rnZoDPGo8aiXicn5phq)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      80 * fem,
                                                      0 * fem),
                                                  child: Text(
                                                    guestlist[index]
                                                            .category[0]
                                                            .toUpperCase() +
                                                        guestlist[index]
                                                            .category
                                                            .substring(1)
                                                            .toLowerCase(),
                                                    textAlign: TextAlign.right,
                                                    style: SafeGoogleFont(
                                                      'Poppins SemiBold',
                                                      fontSize: 16 * ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2575 * ffem / fem,
                                                      color: Color(0xffcccccc),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                // Container(
                                                //   // autogroupbtzhkPm (L65rgKUd6rew5kdkNyBtZH)
                                                //   margin: EdgeInsets.fromLTRB(
                                                //       0 * fem,
                                                //       0 * fem,
                                                //       0 * fem,
                                                //       5 * fem),
                                                //   width: double.infinity,
                                                //   child: Row(
                                                //     crossAxisAlignment:
                                                //     CrossAxisAlignment.end,
                                                //     children: [
                                                //
                                                //     ],
                                                //   ),
                                                // ),
                                                Container(
                                                  // criminaltax94X (148:18)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      0 * fem,
                                                      11 * fem),
                                                  child: Text(
                                                    correctdate,
                                                    style: SafeGoogleFont(
                                                      'Poppins',
                                                      fontSize: 16 * ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2999999523 *
                                                          ffem /
                                                          fem,
                                                      letterSpacing: 0.16 * fem,
                                                      color: Color(0xffa8b1c5),
                                                    ),
                                                  ),
                                                ),
                                                // Container(
                                                //   // timingcD1 (148:417)
                                                //   margin: EdgeInsets.fromLTRB(
                                                //       0 * fem,
                                                //       0 * fem,
                                                //       87.5 * fem,
                                                //       0 * fem),
                                                //   width: double.infinity,
                                                //   child: Row(
                                                //     crossAxisAlignment:
                                                //     CrossAxisAlignment.start,
                                                //     children: [
                                                //       Container(
                                                //         // iconj2j (148:425)
                                                //           margin:
                                                //           EdgeInsets.fromLTRB(
                                                //               0 * fem,
                                                //               0 * fem,
                                                //               10 * fem,
                                                //               0 * fem),
                                                //           width: 16 * fem,
                                                //           height: 17.78 * fem,
                                                //           child: Icon(Icons.location_on_outlined,color: Color(0xff368596),size: 22*fem,)
                                                //         // Image.asset(
                                                //         //   'assets/calendar-2852107 (1).png',
                                                //         //   width: 16 * fem,
                                                //         //   height: 17.78 * fem,
                                                //         //   color:
                                                //         //       Color(0xff368596),
                                                //         // ),
                                                //       ),
                                                //       // Container(
                                                //       //   // am21q (148:422)
                                                //       //   margin:
                                                //       //   EdgeInsets.fromLTRB(
                                                //       //       0 * fem,
                                                //       //       0.44 * fem,
                                                //       //       0 * fem,
                                                //       //       0 * fem),
                                                //       //   child: Text(
                                                //       //     interchapterlist[index]
                                                //       //         .location,
                                                //       //     style: SafeGoogleFont(
                                                //       //       'Poppins',
                                                //       //       fontSize: 15 * ffem,
                                                //       //       fontWeight:
                                                //       //       FontWeight.w400,
                                                //       //       height:
                                                //       //       1.3 * ffem / fem,
                                                //       //       letterSpacing:
                                                //       //       0.15 * fem,
                                                //       //       color:
                                                //       //       Color(0xffa8b1c5),
                                                //       //     ),
                                                //       //   ),
                                                //       // ),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Text(
                                            stringToYesNO(
                                                guestlist[index].isActive),
                                            // guestlist[index].isActive != null?"No":"Yes",
                                            style: SafeGoogleFont(
                                              'Poppins SemiBold',
                                              fontSize: 15 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2575 * ffem / fem,
                                              color: stringToYesNO(
                                                          guestlist[index]
                                                              .isActive) ==
                                                      "Active"
                                                  ? Colors.greenAccent
                                                  : Colors.redAccent,
                                            ),
                                          )),
                                        ],
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
