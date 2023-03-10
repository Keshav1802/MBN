import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mothering_business_network/1to1/1to1Add.dart';
import 'package:mothering_business_network/Guest/guestlistadd.dart';
import 'package:mothering_business_network/InterChapter/interchapterlistadd.dart';
import 'package:mothering_business_network/models/1to1list.dart';
import 'package:mothering_business_network/models/Announcement.dart' as announcement;
import 'package:mothering_business_network/models/InterChapterList.dart';
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:intl/intl.dart';

class AnnouncementPage extends StatefulWidget {
  String user_id;
  // String chapter_id;
  // ChapterDetails chapterDetails;
  // List<ChapterUserDetails> chapterUserDetails;

  AnnouncementPage(this.user_id,
      // this.chapter_id, this.chapterDetails,
      // this.chapterUserDetails
      );

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  Future<announcement.Announcement> announce;
  List<announcement.Data> announcelist = [];

  Future<announcement.Announcement> get1to1List() async {
    Map data = {
      'user_id': widget.user_id,
      // 'chapter_id': "3" //widget.chapter_id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
    await Dio().post("https://mbnindia.com/webservice/api/announcementList",
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
        return announcement.Announcement.fromJson(jsonData);
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
    announce = get1to1List();
    announce.then((value) {
      setState(() {
        announcelist = value.data;
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
      return "No";
    else
      return "Yes";
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
          "Announcement",
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
        // backgroundColor: Color(0xff45536A),
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff9BA6BF),
            size: 19,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: <Widget>[
        //   Tooltip(
        //     message: "Add", waitDuration: Duration(seconds: 1),
        //     showDuration: Duration(seconds: 2),
        //     // padding: EdgeInsets.all(5),
        //     height: 35,
        //     textStyle: SafeGoogleFont(
        //       'Poppins SemiBold',
        //       fontSize: 16 * ffem,
        //       fontWeight: FontWeight.w400,
        //       height: 1.2575 * ffem / fem,
        //       color: Color(0xff9BA6BF),
        //     ),
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(5), color: Colors.black54),
        //     child: IconButton(
        //       icon: Icon(
        //         Icons.add,
        //         color: Color(0xff9BA6BF),
        //       ),
        //       onPressed: () {
        //         Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => oneToOneAddPage(widget.user_id,
        //               widget.chapterDetails, widget.chapterUserDetails),
        //         ));
        //         // do something
        //       },
        //     ),
        //   ),
        // ],
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
              announce = get1to1List();
              announce.then((value) {
                setState(() {
                  announcelist = value.data;
                });
              });
            });
          },
          color: Color(0xff9BA6BF),
          child: Column(
            children: [
              // SizedBox(
              //   height: 15,
              // ),
              // Container(
              //   height: 50,
              //   // color: Colors.blue,
              //   child: Column(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
              //         child: Divider(
              //           thickness: 2,
              //         ),
              //       ),
              //       Row(
              //         children: [
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Expanded(
              //               flex: 1,
              //               child: Text('SR.NO',
              //                   style: SafeGoogleFont(
              //                     'Poppins SemiBold',
              //                     // fontSize: 15 * ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.2575 * ffem / fem,
              //                     color: Color(0xff9BA6BF),
              //                   ))),
              //           SizedBox(
              //             width: 6
              //           ),
              //           Expanded(
              //               flex: 1,
              //               child: Container(
              //                 width: 150,
              //                 child: Text('USER',
              //                     style: SafeGoogleFont(
              //                       'Poppins SemiBold',
              //                       // fontSize: 15 * ffem,
              //                       fontWeight: FontWeight.w400,
              //                       height: 1.2575 * ffem / fem,
              //                       color: Color(0xff9BA6BF),
              //                     )),
              //               )),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Expanded(
              //               flex: 1,
              //               child: Text('CITY',
              //                   style: SafeGoogleFont(
              //                     'Poppins SemiBold',
              //                     // fontSize: 15 * ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.2575 * ffem / fem,
              //                     color: Color(0xff9BA6BF),
              //                   ))),
              //           SizedBox(
              //             width: 5,
              //           ),
              //           Expanded(
              //               flex: 1,
              //               child: Text('CHAPTER',
              //                   style: SafeGoogleFont(
              //                     'Poppins SemiBold',
              //                     // fontSize: 17 * ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.2575 * ffem / fem,
              //                     color: Color(0xff9BA6BF),
              //                   ))),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Expanded(
              //               flex: 1,
              //               child: Text(
              //                 'LOCATION',
              //                 style: SafeGoogleFont(
              //                   'Poppins SemiBold',
              //                   fontSize: 13.8 * ffem,
              //                   fontWeight: FontWeight.w400,
              //                   height: 1.2575 * ffem / fem,
              //                   color: Color(0xff9BA6BF),
              //                 ),
              //               )),
              //           SizedBox(width: 10,),
              //           Expanded(
              //               flex: 1,
              //               child: Text(
              //                 'PROOF',
              //                 style: SafeGoogleFont(
              //                   'Poppins SemiBold',
              //                   fontSize: 13.8 * ffem,
              //                   fontWeight: FontWeight.w400,
              //                   height: 1.2575 * ffem / fem,
              //                   color: Color(0xff9BA6BF),
              //                 ),
              //               )),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 2,
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
              //   child: Divider(
              //     thickness: 2,
              //   ),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              FutureBuilder(
                  future: announce,
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
                              itemCount: announcelist.length,
                              itemBuilder: (context, index) {
                                // final Image noImage =
                                // Image.asset("assets/img_1.png");
                                // final imageUrl = announcelist[index].photoProof;
                                // void handleClick(String value) {
                                //   switch (value) {
                                //     case 'View':
                                //       if (oneToOnelist[index]
                                //               .photoProof
                                //               .contains('.jpg') ||
                                //           oneToOnelist[index]
                                //               .photoProof
                                //               .contains('.png') ||
                                //           oneToOnelist[index]
                                //               .photoProof
                                //               .contains('.jpeg')) {
                                //         Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //             builder: (context) =>
                                //                 documentViewer(
                                //                     oneToOnelist[index]
                                //                         .photoProof,
                                //                     context),
                                //           ),
                                //         );
                                //       } else {
                                //         ScaffoldMessenger.of(context)
                                //             .showSnackBar(SnackBar(
                                //                 content: Text(
                                //                   'File type not supported',
                                //                   style: TextStyle(
                                //                       color: Colors.black),
                                //                 ),
                                //                 backgroundColor:
                                //                     Colors.redAccent));
                                //         Timer(Duration(seconds: 3), () {
                                //           Navigator.of(context).pop();
                                //         });
                                //       }
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => documentViewer(
                                //               oneToOnelist[index].photoProof,
                                //               context),
                                //         ),
                                //       );
                                //       // Navigator.push(
                                //       //   context,
                                //       //   MaterialPageRoute(
                                //       //     builder: (context) =>
                                //       //         EditHomeWork(
                                //       //           homework:
                                //       //           widget.homework,
                                //       //         ),
                                //       //   ),
                                //       // );
                                //       break;
                                //     // case 'Delete':
                                //     //   showDeleteAlertDialog(context);
                                //     //   break;
                                //   }
                                // }

                                return Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xff262B36)),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            // height:180,
                                            constraints: const BoxConstraints(
                                              maxWidth: 320,
                                              // maxHeight: 300
                                            ),
                                            padding:
                                            EdgeInsets.fromLTRB(20, 20, 0, 0),
                                            // color: Colors.blue,
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Row(
                                                children: [
                                                  // Container(
                                                  //   // imgmnj (148:14)
                                                  //     margin: EdgeInsets.fromLTRB(
                                                  //         0 * fem,
                                                  //         0 * fem,
                                                  //         10 * fem,
                                                  //         0.44 * fem),
                                                  //     width: 60 * fem,
                                                  //     height: 60 * fem,
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
                                                  //           : CircularProgressIndicator(
                                                  //         color: Color(
                                                  //             0xff9BA6BF),
                                                  //         strokeWidth:
                                                  //         2,
                                                  //       ),
                                                  //       errorBuilder: (context,
                                                  //           error,
                                                  //           stackTrace) =>
                                                  //       noImage,
                                                  //     )
                                                  //         : noImage),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        // autogroupbtzhkPm (L65rgKUd6rew5kdkNyBtZH)
                                                        margin:
                                                        EdgeInsets.fromLTRB(
                                                            0 * fem,
                                                            0 * fem,
                                                            0 * fem,
                                                            5 * fem),
                                                        child: Container(
                                                          // lisawales3dm (148:17)
                                                          padding:
                                                          EdgeInsets.fromLTRB(
                                                              10 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                          // margin:
                                                          //     EdgeInsets.fromLTRB(
                                                          //         0 * fem,
                                                          //         0 * fem,
                                                          //         94 * fem,
                                                          //         0 * fem),
                                                          child: Text(
                                                            announcelist[index]
                                                                .name,
                                                            style: SafeGoogleFont(
                                                              'Poppins Medium',
                                                              fontSize: 27 * ffem,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              height: 1.4 *
                                                                  ffem /
                                                                  fem,
                                                              letterSpacing:
                                                              0.2 * fem,
                                                              color: Color(
                                                                  0xffcccccc),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        // criminaltax94X (148:18)
                                                        padding:
                                                        EdgeInsets.fromLTRB(
                                                            10 * fem,
                                                            0 * fem,
                                                            0 * fem,
                                                            0 * fem),
                                                        margin:
                                                        EdgeInsets.fromLTRB(
                                                            0 * fem,
                                                            0 * fem,
                                                            0 * fem,
                                                            11 * fem),
                                                        child: Text(
                                                          announcelist[index]
                                                              .description,
                                                          style: SafeGoogleFont(
                                                            'Poppins',
                                                            fontSize: 14.5 * ffem,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            height: 1.2999999523 *
                                                                ffem /
                                                                fem,
                                                            letterSpacing:
                                                            0.16 * fem,
                                                            color:
                                                            Color(
                                                                0xffcccccc),
                                                          ),
                                                        ),
                                                      ),
                                                      // Container(
                                                      //   // timingcD1 (148:417)
                                                      //   padding:
                                                      //   EdgeInsets.fromLTRB(
                                                      //       5 * fem,
                                                      //       0 * fem,
                                                      //       0 * fem,
                                                      //       0 * fem),
                                                      //   margin:
                                                      //   EdgeInsets.fromLTRB(
                                                      //       0 * fem,
                                                      //       0 * fem,
                                                      //       0.5 * fem,
                                                      //       0 * fem),
                                                      //   // width: double.infinity,
                                                      //   child: Row(
                                                      //     crossAxisAlignment:
                                                      //     CrossAxisAlignment
                                                      //         .start,
                                                      //     children: [
                                                      //       Container(
                                                      //         // iconj2j (148:425)
                                                      //           margin: EdgeInsets
                                                      //               .fromLTRB(
                                                      //               0 * fem,
                                                      //               0 * fem,
                                                      //               10 * fem,
                                                      //               0 * fem),
                                                      //           width: 16 * fem,
                                                      //           height:
                                                      //           17.78 * fem,
                                                      //           child: Icon(
                                                      //             Icons
                                                      //                 .location_on_outlined,
                                                      //             color: Color(
                                                      //                 0xff368596),
                                                      //             size: 22 * fem,
                                                      //           )
                                                      //         // Image.asset(
                                                      //         //   'assets/calendar-2852107 (1).png',
                                                      //         //   width: 16 * fem,
                                                      //         //   height: 17.78 * fem,
                                                      //         //   color:
                                                      //         //       Color(0xff368596),
                                                      //         // ),
                                                      //       ),
                                                      //       Container(
                                                      //         // am21q (148:422)
                                                      //         margin: EdgeInsets
                                                      //             .fromLTRB(
                                                      //             0 * fem,
                                                      //             0.44 * fem,
                                                      //             0 * fem,
                                                      //             0 * fem),
                                                      //         child: Text(
                                                      //           oneToOnelist[
                                                      //           index]
                                                      //               .location,
                                                      //           style:
                                                      //           SafeGoogleFont(
                                                      //             'Poppins',
                                                      //             fontSize:
                                                      //             15 * ffem,
                                                      //             fontWeight:
                                                      //             FontWeight
                                                      //                 .w400,
                                                      //             height: 1.3 *
                                                      //                 ffem /
                                                      //                 fem,
                                                      //             letterSpacing:
                                                      //             0.15 * fem,
                                                      //             color: Color(
                                                      //                 0xffa8b1c5),
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          // Container(
                                          //   // autogroup5phquR5 (L65rnZoDPGo8aiXicn5phq)
                                          //   margin: EdgeInsets.fromLTRB(0 * fem,
                                          //       0 * fem, 0 * fem, 0.5 * fem),
                                          //   // width: 50.5 * fem,
                                          //   // height: 25.5 * fem,
                                          //   child: Center(
                                          //     child: Text(
                                          //       oneToOnelist[index].cityName,
                                          //       textAlign: TextAlign.right,
                                          //       style: SafeGoogleFont(
                                          //         'Poppins SemiBold',
                                          //         fontSize: 14 * ffem,
                                          //         fontWeight: FontWeight.w400,
                                          //         height: 1.2575 * ffem / fem,
                                          //         color: Color(0xff368596),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
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

  static Widget documentViewer(String url, context) => SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Photo Proof",
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              'Poppins SemiBold',
              fontSize: 34,
              fontWeight: FontWeight.w400,
              color: Color(0xff9BA6BF),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff45536A),
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined,
                color: Color(0xff9BA6BF)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Color(0xff45536A),
        body: InteractiveViewer(
          panEnabled: true,
          maxScale: 6,
          scaleEnabled: true,
          constrained: false,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ));
}
