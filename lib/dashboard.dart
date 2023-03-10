import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mothering_business_network/1to1/1to1list.dart';
import 'package:mothering_business_network/Announcement/announcement.dart';
import 'package:mothering_business_network/InterChapter/interChapterlist.dart';
import 'package:mothering_business_network/User/UserDetails.dart';
import 'package:mothering_business_network/User/UserListPage.dart';
import 'package:mothering_business_network/User/recentUsersdetails.dart';
import 'package:mothering_business_network/controller/designationListController.dart';
import 'package:mothering_business_network/controller/searchuser.dart';
import 'package:mothering_business_network/models/Dashboard.dart' as dash;
import 'package:mothering_business_network/models/LoginData.dart' as login;
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:mothering_business_network/models/UserList.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/UserList.dart';

class DashboardPage extends StatefulWidget {
  String name;
  String email;
  String user_id;
  String chapter_id;
  ChapterDetails chapterDetails;
  List<login.ChapterUserDetails> chapterUserDetails;

  DashboardPage(this.name, this.email, this.user_id, this.chapter_id,
      this.chapterDetails, this.chapterUserDetails);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String errorMsg = '';
  String _selectedDesignation;
  String designationId;
  SearchUserController searchUserController = Get.put(SearchUserController());

  Future<dash.Dashboard> dashboard;
  String datalist;
  List<dash.RecentUser> recentuserslist = [];
  List<dash.TopUser> topuserslist =
      []; //to be omitted when data will be present
  List<dash.OneToOneMeeting> onetoonelist = [];
  List<dash.Interchepter> interchapterlist = [];

  Future<dash.Dashboard> getdashboard() async {
    Map data = {
      'user_id': widget.user_id,
      // 'chapter_id': "3" //widget.chapter_id,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response =
        await Dio().post("https://mbnindia.com/webservice/api/dashboard",
            options: Options(
              responseType: ResponseType.plain,
              headers: {
                "Content-Type": "application/json",
                "User-Agent": "PostmanRuntime/7.30.0",
                "Accept": "*/*",
                "Accept-Encoding": "gzip, deflate, br",
                "Connection": "keep-alive"
              },
            ),
            data: body);
    // String jsonsDataString = response.toString();
    // final jsonData = jsonDecode(jsonEncode(jsonsDataString));
    var jsonData = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      print(jsonData);
      if (jsonData['status'] == 200) {
        return dash.Dashboard.fromJson(jsonData);
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
    searchUserController.fetchSearchUserList(widget.user_id, widget.chapter_id);
    dashboard = getdashboard();
    dashboard.then((value) {
      setState(() {
        datalist = value.data.totalRevenue;
        recentuserslist = value.recentusers;
        onetoonelist = value.onetoonemeeting;
        interchapterlist = value.interchepter;
        // topuserslist=value.topUsers; //to be omitted
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Color(0xff45536A),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.184, 1),
            end: Alignment(0.184, -1),
            colors: <Color>[Color(0xff000000), Color(0x00000000)],
            stops: <double>[0, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Color(0xff368596),
                    height: 35.h,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(30, 80, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 200,
                              ),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  "Hi," +
                                      " " +
                                      widget.name,
                                  style: SafeGoogleFont(
                                    'Poppins SemiBold',
                                    fontSize: 30 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575 * ffem / fem,
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 33.w,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            dashboard = getdashboard();
                            dashboard.then((value) {
                              setState(() {
                                datalist = value.data.totalRevenue;
                                recentuserslist = value.recentusers;
                                onetoonelist = value.onetoonemeeting;
                                interchapterlist = value.interchepter;
                                // topuserslist=value.topUsers; //to be omitted
                              });
                            });
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 220.w,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          'Recent Users',
                                          style: SafeGoogleFont(
                                            'Poppins SemiBold',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xffCCCCCC),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 40.w,
                                        // ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserListPage(
                                                            widget.user_id,
                                                            widget.chapter_id,
                                                            widget
                                                                .chapterDetails,
                                                            widget
                                                                .chapterUserDetails)));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                170, 0, 8, 0),
                                            child: Text(
                                              'See All',
                                              textAlign: TextAlign.end,
                                              style: SafeGoogleFont(
                                                'Poppins SemiBold',
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 18 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff368596),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  Container(
                                    height: 20.h,
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    // width: 50,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: recentuserslist.length,
                                        itemBuilder: (context, index) {
                                          final Image noImage =
                                              Image.asset("assets/img_1.png");
                                          final imageUrl =
                                              recentuserslist[index].profilepic;
                                          return InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          topUsersDetails(
                                                              recentuserslist[
                                                                  index])));
                                            },
                                            child: Container(
                                              width: 104 * fem,
                                              height: 123.72 * fem,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      // img1E3 (103:795)
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xff000000)),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              7.93 * fem),
                                                      width: 90 * fem,
                                                      height: 90 * fem,
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
                                                              //     FastCachedImage(
                                                              //   url: imageUrl,
                                                              //   fit:
                                                              //       BoxFit.fill,
                                                              //   fadeInDuration:
                                                              //       const Duration(
                                                              //           seconds:
                                                              //               1),
                                                              //   errorBuilder:
                                                              //       (context,
                                                              //           exception,
                                                              //           stacktrace) {
                                                              //     return Image(
                                                              //         image: AssetImage(
                                                              //             "assets/img_1.png"));
                                                              //   },
                                                              //   loadingBuilder:
                                                              //       (context,
                                                              //           progress) {
                                                              //     return Container(
                                                              //       decoration:
                                                              //           BoxDecoration(
                                                              //         gradient:
                                                              //             LinearGradient(
                                                              //           begin: Alignment(
                                                              //               0.184,
                                                              //               1),
                                                              //           end: Alignment(
                                                              //               0.184,
                                                              //               -1),
                                                              //           colors: <
                                                              //               Color>[
                                                              //             Color(
                                                              //                 0xff000000),
                                                              //             Color(
                                                              //                 0x00000000)
                                                              //           ],
                                                              //           stops: <
                                                              //               double>[
                                                              //             0,
                                                              //             1
                                                              //           ],
                                                              //         ),
                                                              //       ),
                                                              //       child:
                                                              //           Stack(
                                                              //         alignment:
                                                              //             Alignment
                                                              //                 .center,
                                                              //         children: [
                                                              //           // if (progress.isDownloading && progress.totalBytes != null)
                                                              //           //   Text('${progress.downloadedBytes ~/ 1024} / ${progress.totalBytes ~/ 1024} kb',
                                                              //           //       style: const TextStyle(color: Colors.red)),
                                                              //
                                                              //           SizedBox(
                                                              //               width:
                                                              //                   120,
                                                              //               height:
                                                              //                   120,
                                                              //               child: CircularProgressIndicator(
                                                              //                   color: Color(0xff9BA6BF),
                                                              //                   strokeWidth: 2,
                                                              //                   value: progress.progressPercentage.value)),
                                                              //         ],
                                                              //       ),
                                                              //     );
                                                              //   },
                                                              // ),
                                                            )
                                                          : noImage),
                                                  Text(
                                                    // krisyyolkerh6s (103:782)
                                                    recentuserslist[index]
                                                            .name[0]
                                                            .toUpperCase() +
                                                        recentuserslist[index]
                                                            .name
                                                            .substring(1)
                                                            .toLowerCase(),
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'Poppins',
                                                      fontSize: 14 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.5 * ffem / fem,
                                                      color: Color(0xffcccccc),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final Uri params = Uri(
                                  scheme: 'mailto',
                                  path:
                                      'mbn@mothering.in', //change email address to admin
                                );

                                var url = params.toString();
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Container(
                                // plcholderimgNAP (103:858)
                                margin: EdgeInsets.fromLTRB(
                                    15 * fem, 0 * fem, 21 * fem, 0 * fem),
                                padding: EdgeInsets.fromLTRB(
                                    22 * fem, 18 * fem, 25 * fem, 23 * fem),
                                width: double.infinity,
                                height: 94 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xff292f37)),
                                  color: Color(0xff040404),
                                  borderRadius: BorderRadius.circular(10 * fem),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/dark-mode/images/auto-group-wxzx.png',
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // textsBNj (112:121)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 46 * fem, 0 * fem),
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // cantfindneedhelpUcj (103:854)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 2 * fem),
                                            child: RichText(
                                              text: TextSpan(
                                                style: SafeGoogleFont(
                                                  'Poppins SemiBold',
                                                  fontSize: 21 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height:
                                                      1.3999999818 * ffem / fem,
                                                  letterSpacing: 0.21 * fem,
                                                  color: Color(0xffe0e0e0),
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'Can’t find, need ',
                                                    style: SafeGoogleFont(
                                                      'Poppins SemiBold',
                                                      fontSize: 21 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3999999818 *
                                                          ffem /
                                                          fem,
                                                      letterSpacing: 0.21 * fem,
                                                      color: Color(0xffe0e0e0),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Help',
                                                    style: SafeGoogleFont(
                                                      'Poppins SemiBold',
                                                      fontSize: 21 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3999999818 *
                                                          ffem /
                                                          fem,
                                                      letterSpacing: 0.21 * fem,
                                                      color: Color(0xffe0e0e0),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: '?',
                                                    style: SafeGoogleFont(
                                                      'Poppins SemiBold',
                                                      fontSize: 21 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3999999818 *
                                                          ffem /
                                                          fem,
                                                      letterSpacing: 0.21 * fem,
                                                      color: Color(0xffe0e0e0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            // shareissuesdocwritetous7Sj (103:855)
                                            'Share issues, write to us...',
                                            style: SafeGoogleFont(
                                              'Poppins',
                                              fontSize: 16 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2999999523 * ffem / fem,
                                              letterSpacing: 0.16 * fem,
                                              color: Color(0xffb6b6b6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        // arrowicon1HD (112:120)
                                        margin: EdgeInsets.fromLTRB(40 * fem,
                                            5 * fem, 0 * fem, 0 * fem),
                                        width: 36 * fem,
                                        height: 36 * fem,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff368596),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_outlined,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              child: Column(
                                children: [
                                  onetoonelist.length!=null?
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
                                          child: Row(
                                            children: [
                                              // SizedBox(
                                              //   width: 20,
                                              // ),
                                              Text(
                                                'One to One Meeting',
                                                style: SafeGoogleFont(
                                                  'Poppins SemiBold',
                                                  fontSize: 24 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2575 * ffem / fem,
                                                  color: Color(0xffCCCCCC),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 34.w,
                                              // ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              oneToOneListPage(
                                                                  widget.user_id,
                                                                  widget.chapter_id,
                                                                  widget
                                                                      .chapterDetails,
                                                                  widget
                                                                      .chapterUserDetails)));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      110, 0, 8, 0),
                                                  child: Text(
                                                    'See All',
                                                    style: SafeGoogleFont(
                                                      'Poppins SemiBold',
                                                      decoration:
                                                      TextDecoration.underline,
                                                      fontSize: 18 * ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2575 * ffem / fem,
                                                      color: Color(0xff368596),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          height: 30.h,
                                          padding: EdgeInsets.fromLTRB(20, 5, 10, 20),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xff262B36)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          // width: 50,
                                          child: ListView.builder(
                                              itemCount: onetoonelist.length,
                                              itemBuilder: (context, index) {
                                                final Image noImage =
                                                Image.asset("assets/img_1.png");
                                                final imageUrl1 =
                                                    onetoonelist[index].photoproof;
                                                return InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: 50.w,
                                                    height: 8.h,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 110.w,
                                                          height: 8.h,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                    width: 37 * fem,
                                                                    height: 37 * fem,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Color(
                                                                              0x19ffffff)),
                                                                      color: Color(
                                                                          0xffc4c4c4),
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(200 *
                                                                          fem),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Color(
                                                                              0x33000000),
                                                                          offset: Offset(
                                                                              3 * fem,
                                                                              10 *
                                                                                  fem),
                                                                          blurRadius:
                                                                          12.5 *
                                                                              fem,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: (imageUrl1 !=
                                                                        null) // Only use the network image if the url is not null
                                                                        ? ClipOval(
                                                                      child:Image.network(
                                                                        imageUrl1,
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
                                                                      //   imageUrl: imageUrl1,
                                                                      //   // placeholder: (context, url) => CircularProgressIndicator(),
                                                                      //   errorWidget: (context, url, error) => noImage,
                                                                      //   width: 125,
                                                                      //   height: 125,
                                                                      //   fit: BoxFit.cover,
                                                                      //   alignment: Alignment(-.5, -.5),
                                                                      //   filterQuality: FilterQuality.high,
                                                                      // ),
                                                                    )
                                                                        : noImage,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 3.w,
                                                                  ),
                                                                  Flexible(
                                                                    child: Text(
                                                                      // krisyyolkerh6s (103:782)
                                                                      onetoonelist[
                                                                      index]
                                                                          .username[
                                                                      0]
                                                                          .toUpperCase() +
                                                                          onetoonelist[
                                                                          index]
                                                                              .username
                                                                              .substring(
                                                                              1)
                                                                              .toLowerCase() +
                                                                          " & " +
                                                                          onetoonelist[
                                                                          index]
                                                                              .createbyname +
                                                                          "  Recently Met ",
                                                                      style:
                                                                      SafeGoogleFont(
                                                                        'Poppins',
                                                                        fontSize:
                                                                        14 * ffem,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                        height: 1.5 *
                                                                            ffem /
                                                                            fem,
                                                                        color: Color(
                                                                            0xffcccccc),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    left: 12.w),
                                                                child: Text(
                                                                  // krisyyolkerh6s (103:782)
                                                                  onetoonelist[index]
                                                                      .location[0]
                                                                      .toUpperCase() +
                                                                      onetoonelist[
                                                                      index]
                                                                          .location
                                                                          .substring(
                                                                          1)
                                                                          .toLowerCase(),
                                                                  style:
                                                                  SafeGoogleFont(
                                                                    'Poppins',
                                                                    fontSize:
                                                                    12 * ffem,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    height: 1.5 *
                                                                        ffem /
                                                                        fem,
                                                                    color:
                                                                    Colors.grey,
                                                                  ),
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
                                        ),
                                      ],
                                    ),
                                  ):Container(),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  interchapterlist.length!=null?
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                          child: Row(
                                            children: [
                                              // SizedBox(
                                              //   width: 20,
                                              // ),
                                              Text(
                                                'Inter Chapter',
                                                style: SafeGoogleFont(
                                                  'Poppins SemiBold',
                                                  fontSize: 24 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2575 * ffem / fem,
                                                  color: Color(0xffCCCCCC),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 49.w,
                                              // ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              InterChapterListPage(
                                                                  widget.user_id,
                                                                  widget.chapter_id,
                                                                  widget
                                                                      .chapterDetails,
                                                                  widget
                                                                      .chapterUserDetails)));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      170, 0, 8, 0),
                                                  child: Text(
                                                    'See All',
                                                    style: SafeGoogleFont(
                                                      'Poppins SemiBold',
                                                      decoration:
                                                      TextDecoration.underline,
                                                      fontSize: 18 * ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2575 * ffem / fem,
                                                      color: Color(0xff368596),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          height: 30.h,
                                          padding: EdgeInsets.fromLTRB(20, 5, 10, 20),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xff262B36)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          // width: 50,
                                          child: ListView.builder(
                                              itemCount: interchapterlist.length,
                                              itemBuilder: (context, index) {
                                                final Image noImage =
                                                Image.asset("assets/img_1.png");
                                                final imageUrl2 =
                                                    interchapterlist[index]
                                                        .photoproof;
                                                return InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: 50.w,
                                                    height: 8.h,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 110.w,
                                                          height: 8.h,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                    width: 37 * fem,
                                                                    height: 37 * fem,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Color(
                                                                              0x19ffffff)),
                                                                      color: Color(
                                                                          0xffc4c4c4),
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(200 *
                                                                          fem),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Color(
                                                                              0x33000000),
                                                                          offset: Offset(
                                                                              3 * fem,
                                                                              10 *
                                                                                  fem),
                                                                          blurRadius:
                                                                          12.5 *
                                                                              fem,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: (imageUrl2 !=
                                                                        null) // Only use the network image if the url is not null
                                                                        ? ClipOval(
                                                                      child:Image.network(
                                                                        imageUrl2,
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
                                                                      //   imageUrl: imageUrl2,
                                                                      //   // placeholder: (context, url) => CircularProgressIndicator(),
                                                                      //   errorWidget: (context, url, error) => noImage,
                                                                      //   width: 125,
                                                                      //   height: 125,
                                                                      //   fit: BoxFit.cover,
                                                                      //   alignment: Alignment(-.5, -.5),
                                                                      //   filterQuality: FilterQuality.high,
                                                                      // ),
                                                                    )
                                                                        : noImage,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 3.w,
                                                                  ),
                                                                  Flexible(
                                                                    child: Text(
                                                                      // krisyyolkerh6s (103:782)
                                                                      interchapterlist[
                                                                      index]
                                                                          .username[
                                                                      0]
                                                                          .toUpperCase() +
                                                                          interchapterlist[
                                                                          index]
                                                                              .username
                                                                              .substring(
                                                                              1)
                                                                              .toLowerCase() +
                                                                          " & " +
                                                                          interchapterlist[
                                                                          index]
                                                                              .createbyname +
                                                                          "  Recently Met ",
                                                                      style:
                                                                      SafeGoogleFont(
                                                                        'Poppins',
                                                                        fontSize:
                                                                        14 * ffem,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                        height: 1.5 *
                                                                            ffem /
                                                                            fem,
                                                                        color: Color(
                                                                            0xffcccccc),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    left: 12.w),
                                                                child: Text(
                                                                  // krisyyolkerh6s (103:782)
                                                                  interchapterlist[
                                                                  index]
                                                                      .location[0]
                                                                      .toUpperCase() +
                                                                      interchapterlist[
                                                                      index]
                                                                          .location
                                                                          .substring(
                                                                          1)
                                                                          .toLowerCase(),
                                                                  style:
                                                                  SafeGoogleFont(
                                                                    'Poppins',
                                                                    fontSize:
                                                                    12 * ffem,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    height: 1.5 *
                                                                        ffem /
                                                                        fem,
                                                                    color:
                                                                    Colors.grey,
                                                                  ),
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
                                        ),
                                      ],
                                    ),
                                  ):Container(),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Container(
                                    height: 24.h,
                                    width: 100.w,
                                    padding: EdgeInsets.fromLTRB(20, 5, 10, 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff262B36)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Image.asset(
                                          'assets/Revenue1.png',
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.fill,
                                          width: 22.w,
                                          height: 8.h,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          'Revenue',
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 18 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * ffem / fem,
                                            color: Color(0xffcccccc),
                                          ),
                                        ),
                                        Text(
                                          datalist != null ? datalist : "0",
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 26 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * ffem / fem,
                                            color: Color(0xffcccccc),
                                          ),
                                        ),
                                        Text(
                                          'Total Referral revenue in the Chapter',
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * ffem / fem,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 35 * fem,
                top: 75 * fem,
                child: Container(

                  // margin: EdgeInsets.fromLTRB(90, 0, 15, 0),
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Color(0xffFFFFFF),
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AnnouncementPage(widget.user_id)));
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => InterChapterListAdd(widget.user_id,
                      //       widget.chapterDetails, widget.chapterUserDetails),
                      // ));
                      // do something
                    },
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "Browse the number of users and see what's revolving, start networking now!",
                    style: SafeGoogleFont(
                      'Poppins SemiBold',
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.2575 * ffem / fem,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 220,
                  left: 30,
                  child: Container(
                    height: 0.06*MediaQuery.of(context).size.height,
                width: 0.85*MediaQuery.of(context).size.width,
                // group75ofH (112:94)
                padding:
                    EdgeInsets.fromLTRB(18 * fem, 0 * fem, 0 * fem, 0 * fem),
                // margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                // width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5 * fem),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserListPage(
                            widget.user_id,
                            widget.chapter_id,
                            widget.chapterDetails,
                            widget.chapterUserDetails)));
                  },
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // yourcurrentlocationVHD (112:96)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 142 * fem, 0 * fem),
                          child: Text(
                            'Search for users ...',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * ffem / fem,
                              color: Color(0xff6c7790),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Container(
                          // vectorZXy (112:97)
                          // width: 22*fem,
                          height: 22 * fem,
                          child: Icon(
                            Icons.search,
                            color: Color(0xff6c7790),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  // Widget getSearchUserDropDown(List<Data> designations) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       SizedBox(
  //         height: 30,
  //       ),
  //       Container(
  //         height: 60,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //             color: Colors.white),
  //         child: DropdownSearch<String>(
  //           dropdownButtonProps: DropdownButtonProps(
  //             icon: Icon(
  //               Icons.search,
  //               color: Colors.black,
  //             ),
  //           ),
  //           items: designations.map((e) => e.name).toList(),
  //           popupProps: PopupProps.menu(
  //             showSelectedItems: true,
  //             constraints: BoxConstraints(maxHeight: 200),
  //             itemBuilder: (context, item, isSelected) {
  //               return Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Padding(
  //                     padding:
  //                         EdgeInsets.symmetric(horizontal: 19, vertical: 10),
  //                     child: Text(
  //                       item,
  //                       textAlign: TextAlign.start,
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         color: Colors.black,
  //                         fontFamily: GoogleFonts.inter(
  //                           fontWeight: FontWeight.w500,
  //                         ).fontFamily,
  //                       ),
  //                     ),
  //                   ),
  //                   Divider(
  //                     color: Color(0xff8e9aa6),
  //                     thickness: 0.5,
  //                   )
  //                 ],
  //               );
  //             },
  //           ),
  //           dropdownBuilder: (context, selectedItem) {
  //             return Text(
  //               selectedItem ?? '  Search for users ...',
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 color: Colors.black,
  //                 fontFamily: GoogleFonts.inter(
  //                   fontWeight: FontWeight.w500,
  //                 ).fontFamily,
  //               ),
  //             );
  //           },
  //           dropdownDecoratorProps: DropDownDecoratorProps(
  //             baseStyle: TextStyle(
  //               fontSize: 12,
  //               color: Colors.black,
  //               fontFamily: GoogleFonts.inter(
  //                 fontWeight: FontWeight.w500,
  //               ).fontFamily,
  //             ),
  //             dropdownSearchDecoration: InputDecoration(
  //               errorStyle: TextStyle(
  //                 fontSize: 8,
  //                 color: Color(0xffde5151),
  //                 fontFamily: GoogleFonts.inter(
  //                   fontWeight: FontWeight.w500,
  //                 ).fontFamily,
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
  //                 borderSide: BorderSide(
  //                   color: Color(0xff368596),
  //                 ),
  //               ),
  //               focusedErrorBorder: OutlineInputBorder(
  //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
  //                 borderSide: BorderSide(
  //                   color: Color(0xffde5151),
  //                 ),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
  //                 borderSide: BorderSide(
  //                   color: Color(0xff000000),
  //                 ),
  //               ),
  //               errorBorder: OutlineInputBorder(
  //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
  //                 borderSide: BorderSide(
  //                   color: Color(0xffde5151),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           onChanged: (dynamic newValue) async {
  //             setState(() {
  //               errorMsg = '';
  //               _selectedDesignation = newValue;
  //               designationId =
  //                   designations.singleWhere((e) => e.name == newValue).id;
  //               print(designationId);
  //             });
  //           },
  //           autoValidateMode: AutovalidateMode.onUserInteraction,
  //           selectedItem: _selectedDesignation,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
