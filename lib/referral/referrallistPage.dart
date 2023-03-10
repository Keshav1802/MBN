import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mothering_business_network/Guest/guestlistadd.dart';
import 'package:mothering_business_network/InterChapter/interchapterlistadd.dart';
// import 'package:mothering_business_network/models/InterChapterList.dart';
import 'package:mothering_business_network/models/LoginData.dart' as loginData;
import 'package:mothering_business_network/models/ReferralList.dart';
import 'package:mothering_business_network/referral/referraladd.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ReferralListPage extends StatefulWidget {
  String user_id;
  String chapter_id;
  loginData.Data logindata;
  // ChapterDetails chapterDetails;
  // List<ChapterUserDetails> chapterUserDetails;

  ReferralListPage(this.logindata
      // this.chapterDetails,
      // this.chapterUserDetails
      );

  @override
  State<ReferralListPage> createState() => _ReferralListPageState();
}

class _ReferralListPageState extends State<ReferralListPage> {
  Future<ReferralList> referral;
  List<Data> referralList = [];

  Future<ReferralList> getInterChapterList() async {
    Map data = {
      'user_id': widget.logindata.id,
      // 'chapter_id': "3" //widget.chapter_id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
    await Dio().post("https://mbnindia.com/webservice/api/referralList",
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
        return ReferralList.fromJson(jsonData);
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
    referral = getInterChapterList();
    referral.then((value) {
      setState(() {
        referralList = value.data;
      });
    });

    super.initState();
  }

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
          "Referral (List)",
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Poppins SemiBold',
            fontSize: 26 * ffem,
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
                  builder: (context) => ReferralAddPage(widget.user_id,widget.logindata,
                      widget.logindata.chapterDetails, widget.logindata.chapterUserDetails),
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
              referral = getInterChapterList();
              referral.then((value) {
                setState(() {
                  referralList = value.data;
                });
              });
            });
          },
          color: Color(0xff9BA6BF),
          child: Column(
            children: [
              FutureBuilder(
                  future: referral,
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
                              itemCount: referralList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5,10,5,1.2),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xff262B36)),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 15.h,
                                            // margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                            padding:
                                            EdgeInsets.fromLTRB(20, 20, 0, 0),
                                            // color: Colors.blue,
                                            child: Row(
                                              children: [
                                                SizedBox(width: 2.w,),
                                                Container(
                                                  // autogroupmaybTQf (L65rXuYySWWzA4AJ91maYb)
                                                  width: 365 * fem,
                                                  height: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        // autogroupbtzhkPm (L65rgKUd6rew5kdkNyBtZH)
                                                        margin: EdgeInsets.fromLTRB(
                                                            0 * fem,
                                                            0 * fem,
                                                            0 * fem,
                                                            5 * fem),
                                                        width: double.infinity,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                          children: [
                                                            Container(
                                                              // lisawales3dm (148:17)
                                                              width:50.w,
                                                              margin:
                                                              EdgeInsets.fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                              child: Text(
                                                                referralList[
                                                                index]
                                                                    .name!=null?referralList[index].name:"",
                                                                style: SafeGoogleFont(
                                                                  'Poppins Medium',
                                                                  fontSize: 20 * ffem,
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
                                                            SizedBox(width: 10.w,),
                                                            Container(
                                                              // autogroup5phquR5 (L65rnZoDPGo8aiXicn5phq)
                                                              margin:
                                                              EdgeInsets.fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0.5 * fem),
                                                              width: 100.5 * fem,
                                                              height: 25.5 * fem,
                                                              child: Center(
                                                                child: Text(
                                                                  "Rs. "+referralList[
                                                                  index]
                                                                      .amount,
                                                                  textAlign:
                                                                  TextAlign.right,
                                                                  style:
                                                                  SafeGoogleFont(
                                                                    'Poppins SemiBold',
                                                                    fontSize:
                                                                    20 * ffem,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    height: 1.2575 *
                                                                        ffem /
                                                                        fem,
                                                                    color: Color(
                                                                        0xff368596),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        // criminaltax94X (148:18)
                                                        margin: EdgeInsets.fromLTRB(
                                                            0 * fem,
                                                            0 * fem,
                                                            0 * fem,
                                                            11 * fem),
                                                        child: Text(
                                                          referralList[index]
                                                              .chepterName!=null?referralList[index].chepterName:"",
                                                          style: SafeGoogleFont(
                                                            'Poppins',
                                                            fontSize: 14 * ffem,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            height: 1.2999999523 *
                                                                ffem /
                                                                fem,
                                                            letterSpacing: 0.16 * fem,
                                                            color: Color(0xffa8b1c5),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        // timingcD1 (148:417)
                                                        margin: EdgeInsets.fromLTRB(
                                                            0 * fem,
                                                            0 * fem,
                                                            0 * fem,
                                                            0 * fem),
                                                        width: double.infinity,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Container(
                                                              // iconj2j (148:425)
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    10 * fem,
                                                                    0 * fem),
                                                                width: 16 * fem,
                                                                height: 17.78 * fem,
                                                                child: Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  color: Color(
                                                                      0xff368596),
                                                                  size: 22 * fem,
                                                                )
                                                            ),
                                                            Container(
                                                              // am21q (148:422)
                                                              margin:
                                                              EdgeInsets.fromLTRB(
                                                                  0 * fem,
                                                                  0.44 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                              child: Text(
                                                                referralList[
                                                                index]
                                                                    .cityName,
                                                                style: SafeGoogleFont(
                                                                  'Poppins',
                                                                  fontSize: 15 * ffem,
                                                                  fontWeight:
                                                                  FontWeight.w400,
                                                                  height: 1.3 *
                                                                      ffem /
                                                                      fem,
                                                                  letterSpacing:
                                                                  0.15 * fem,
                                                                  color: Color(
                                                                      0xffa8b1c5),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      margin: EdgeInsets.fromLTRB(4.5, 0, 4.5, 4.5),
                                      decoration: BoxDecoration(
                                        color: Color(0xff368596),
                                border: Border.all(color: Color(0xff262B36)),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.map_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              width: 300,
                                              child: Text(
                                                referralList[index].description.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 13),
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
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
