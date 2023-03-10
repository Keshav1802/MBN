import 'dart:async';
import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mothering_business_network/InterChapter/interchapterlistadd.dart';
import 'package:mothering_business_network/User/UserDetails.dart';
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:mothering_business_network/models/UserList.dart' as users;
import 'package:mothering_business_network/utils.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class UserListPage extends StatefulWidget {
  String user_id;
  String chapter_id;
  ChapterDetails chapterDetails;
  List<ChapterUserDetails> chapterUserDetails;

  UserListPage(this.user_id, this.chapter_id, this.chapterDetails,
      this.chapterUserDetails);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  Future<users.UserList> user;
  List<users.Data> userlist = [];

  Future<users.UserList> getUserList() async {
    Map data = {
      'user_id': widget.user_id,
      'chapter_id':widget.chapter_id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
    await Dio().post("https://mbnindia.com/webservice/api/userList",
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
        return users.UserList.fromJson(jsonData);
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
    user = getUserList();
    user.then((value) {
      setState(() {
        userlist = value.data;
      });
    });

    super.initState();
  }


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
          "Users (List)",
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
        //         // Navigator.of(context).push(MaterialPageRoute(
        //         //   builder: (context) => InterChapterListAdd(widget.user_id,
        //         //       widget.chapterDetails, widget.chapterUserDetails),
        //         // ));
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
              user = getUserList();
              user.then((value) {
                setState(() {
                  userlist = value.data;
                });
              });
            });
          },
          color: Color(0xff9BA6BF),
          child: Column(
            children: [
              FutureBuilder(
                  future: user,
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
                              itemCount: userlist.length,
                              itemBuilder: (context, index) {
                                final Image noImage =
                                Image.asset("assets/img_1.png");
                                final imageUrl =
                                    userlist[index].profilePic;

                                return InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => UserDetailsPage(
                                            userlist[index])));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(5,5,5,5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Color(0xff262B36)),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 13.5.h,
                                          // margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          padding:
                                          EdgeInsets.fromLTRB(20, 20, 0, 0),
                                          // color: Colors.blue,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  alignment: Alignment.topCenter,
                                                  width: 60 * fem,
                                                  height: 60 * fem,
                                                  decoration: BoxDecoration(
                                                    border:
                                                    Border.all(color: Color(0x19ffffff)),
                                                    color: Color(0xffc4c4c4),
                                                    borderRadius:
                                                    BorderRadius.circular(200 * fem),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(0x33000000),
                                                        offset: Offset(3 * fem, 10 * fem),
                                                        blurRadius: 12.5 * fem,
                                                      ),
                                                    ],
                                                  ),
                                                child: (imageUrl !=
                                                    null) // Only use the network image if the url is not null
                                                    ? ClipOval(
                                                      child:Image.network(
                                                        imageUrl,
                                                        width: 125,
                                                        height: 125,
                                                        fit: BoxFit.cover,
                                                        alignment: Alignment(-.5, -.5),
                                                        filterQuality: FilterQuality.high,
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) =>
                                                        (loadingProgress ==
                                                            null)
                                                            ? child
                                                            : CircularProgressIndicator(
                                                          color: Color(
                                                              0xff9BA6BF),
                                                          strokeWidth:
                                                          2,
                                                        ),
                                                        errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        noImage,
                                                      )
                                                      // CachedNetworkImage(
                                                      //   imageUrl: imageUrl,
                                                      //   // placeholder: (context, url) => CircularProgressIndicator(),
                                                      //   errorWidget: (context, url, error) => noImage,
                                                      //   width: 125,
                                                      //   height: 125,
                                                      //   fit: BoxFit.cover,
                                                      //   alignment: Alignment(-.5, -.5),
                                                      //   filterQuality: FilterQuality.high,
                                                      // ),
                                                    )
                                                    : noImage
                                              ),
                                              SizedBox(width: 10,),
                                              Container(
                                                // autogroupmaybTQf (L65rXuYySWWzA4AJ91maYb)
                                                width: 292.5 * fem,
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
                                                      child: Container(
                                                        // lisawales3dm (148:17)
                                                        margin:
                                                        EdgeInsets.fromLTRB(
                                                            0 * fem,
                                                            0 * fem,
                                                            0 * fem,
                                                            0 * fem),
                                                        child: Text(
                                                          userlist[
                                                          index]
                                                              .name,
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
                                                    ),
                                                    Container(
                                                      // criminaltax94X (148:18)
                                                      margin: EdgeInsets.fromLTRB(
                                                          0 * fem,
                                                          0 * fem,
                                                          0 * fem,
                                                          11 * fem),
                                                      child: Text(
                                                        userlist[index]
                                                            .designationName,
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
                                                      // margin: EdgeInsets.fromLTRB(
                                                      //     0 * fem,
                                                      //     0 * fem,
                                                      //     87.5 * fem,
                                                      //     0 * fem),
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
                                                              userlist[
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
