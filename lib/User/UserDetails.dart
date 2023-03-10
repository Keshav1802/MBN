// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:mothering_business_network/models/UserList.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailsPage extends StatefulWidget {
  Data userdata;
  UserDetailsPage(this.userdata);
  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final Image noImage = Image.asset("assets/img_1.png");
    final imageUrl = widget.userdata.profilePic;
    return Material(
      type: MaterialType.transparency,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Container(
            // lawyerdetailsuQX (112:906)
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, -1),
                end: Alignment(0, 1),
                colors: <Color>[Color(0xff13161a), Color(0xff0f1218)],
                stops: <double>[0, 1],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // autogrouplsp5wMD (L65KJdvLVdzDiE6QniLSP5)
                  padding: EdgeInsets.fromLTRB(
                      21 * fem, 46 * fem, 21 * fem, 23 * fem),
                  width: double.infinity,
                  height: 100 * fem,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.184, 1),
                      end: Alignment(0.184, -1),
                      colors: <Color>[Color(0xff000000), Color(0x00000000)],
                      stops: <double>[0, 1],
                    ),
                  ),
                  child: Container(
                    // topm5M (112:1030)
                    width: 300 * fem,
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              // bckicont9y (112:1033)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 89 * fem, 2.75 * fem),
                              width: 24 * fem,
                              height: 18.25 * fem,
                              child: Icon(Icons.arrow_back_ios_new_outlined,
                                  color: Color(0xff9BA6BF))
                              // Image.asset(
                              //   'assets/dark-mode/images/bck-icon-evo.png',
                              //   width: 24*fem,
                              //   height: 18.25*fem,
                              // ),
                              ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          // lawyerdetailsZmu (112:1031)
                          'User Details',
                          // textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Poppins Medium',
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2575 * ffem / fem,
                            color: Color(0xff9ba6bf),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // autogroupmugfqzK (L65KXTtJCJjM5ofexWMuGf)
                  padding: EdgeInsets.fromLTRB(
                      20 * fem, 30 * fem, 0 * fem, 50 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // lawyerYNw (112:1184)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 19 * fem, 24 * fem),
                        width: 373 * fem,
                        height: 300 * fem,
                        child: Stack(
                          children: [
                            Positioned(
                              // lawyerbgdvB (112:1029)
                              left: 0 * fem,
                              top: 80 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 373 * fem,
                                  height: 190 * fem,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15 * fem),
                                      color: Color(0xff368596),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => documentViewer(
                                            widget.userdata.profilePic,
                                            context),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 125 * fem,
                                    height: 125 * fem,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0x19ffffff)),
                                      color: Color(0xffc4c4c4),
                                      borderRadius: BorderRadius.circular(200 * fem),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x33000000),
                                          offset: Offset(3 * fem, 10 * fem),
                                          blurRadius: 12.5 * fem,
                                        ),
                                      ],
                                    ),
                                    child:ClipOval(
                                        child:  Image.network(
                                          widget.userdata.profilePic,
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
                                      //   imageUrl: widget.logindata.profilePic,
                                      //   // placeholder: (context, url) => CircularProgressIndicator(),
                                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                                      //   width: 125,
                                      //   height: 125,
                                      //   fit: BoxFit.cover,
                                      //   alignment: Alignment(-.5, -.5),
                                      //   filterQuality: FilterQuality.high,
                                      // ),
                                      // Image.network(
                                      //   widget.logindata.profilePic,
                                      //   width: 100,
                                      //   height: 100,
                                      //   fit: BoxFit.fitHeight,
                                      // ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Align(
                                  child: Text(
                                    widget.userdata.name,
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Poppins Medium',
                                      fontSize: 24 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3999999364 * ffem / fem,
                                      letterSpacing: 0.24 * fem,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3,),
                                Align(
                                  child: Text(
                                    widget.userdata.designationName,
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Poppins Medium',
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2999999523 * ffem / fem,
                                      letterSpacing: 0.16 * fem,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3,),
                                Align(
                                  child: Text(
                                    widget.userdata.companyName,
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Poppins Medium',
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2999999523 * ffem / fem,
                                      letterSpacing: 0.16 * fem,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Positioned(
                            //   // img74f (112:1164)
                            //   left: 123 * fem,
                            //   top: 0 * fem,
                            //   child: InkWell(
                            //     onTap: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => documentViewer(
                            //               widget.userdata.profilePic, context),
                            //         ),
                            //       );
                            //     },
                            //     child: Container(
                            //         width: 125 * fem,
                            //         height: 125 * fem,
                            //         decoration: BoxDecoration(
                            //           border:
                            //               Border.all(color: Color(0x19ffffff)),
                            //           color: Color(0xffc4c4c4),
                            //           borderRadius:
                            //               BorderRadius.circular(200 * fem),
                            //           boxShadow: [
                            //             BoxShadow(
                            //               color: Color(0x33000000),
                            //               offset: Offset(3 * fem, 10 * fem),
                            //               blurRadius: 12.5 * fem,
                            //             ),
                            //           ],
                            //         ),
                            //         child: (imageUrl !=
                            //                 null) // Only use the network image if the url is not null
                            //             ? ClipOval(
                            //                 child: Image.network(
                            //                   imageUrl,
                            //                   width: 125,
                            //                   height: 125,
                            //                   fit: BoxFit.cover,
                            //                   alignment: Alignment(-.5, -.5),
                            //                   filterQuality: FilterQuality.high,
                            //                   loadingBuilder: (context,
                            //                       child,
                            //                       loadingProgress) =>
                            //                   (loadingProgress ==
                            //                       null)
                            //                       ? child
                            //                       : CircularProgressIndicator(
                            //                     color: Color(
                            //                         0xff9BA6BF),
                            //                     strokeWidth:
                            //                     2,
                            //                   ),
                            //                   errorBuilder: (context,
                            //                       error,
                            //                       stackTrace) =>
                            //                   noImage,
                            //                 )
                            //                 // CachedNetworkImage(
                            //                 //   imageUrl: imageUrl,
                            //                 //   // placeholder: (context, url) => CircularProgressIndicator(),
                            //                 //   errorWidget: (context, url, error) => noImage,
                            //                 //   width: 125,
                            //                 //   height: 125,
                            //                 //   fit: BoxFit.cover,
                            //                 //   alignment: Alignment(-.5, -.5),
                            //                 //   filterQuality: FilterQuality.high,
                            //                 // ),
                            //               )
                            //             : noImage
                            //         ),
                            //   ),
                            // ),
                            // Positioned(
                            //   // mathewbairstow2aw (112:1166)
                            //   left: 98 * fem,
                            //   top: 137 * fem,
                            //   child: Align(
                            //     child: SizedBox(
                            //       width: 200 * fem,
                            //       height: 34 * fem,
                            //       child: FittedBox(
                            //         fit: BoxFit.contain,
                            //         child: Text(
                            //           widget.userdata.name,
                            //           textAlign: TextAlign.center,
                            //           style: SafeGoogleFont(
                            //             'Poppins Medium',
                            //             fontSize: 24 * ffem,
                            //             fontWeight: FontWeight.w400,
                            //             height: 1.3999999364 * ffem / fem,
                            //             letterSpacing: 0.24 * fem,
                            //             color: Color(0xffffffff),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //   // taxpropertyGEP (112:1167)
                            //   left: 140.5 * fem,
                            //   top: 170 * fem,
                            //   child: Align(
                            //     child: SizedBox(
                            //       width: 91 * fem,
                            //       height: 21 * fem,
                            //       child: Text(
                            //         widget.userdata.designationName,
                            //         textAlign: TextAlign.center,
                            //         style: SafeGoogleFont(
                            //           'Poppins Medium',
                            //           fontSize: 16 * ffem,
                            //           fontWeight: FontWeight.w400,
                            //           height: 1.2999999523 * ffem / fem,
                            //           letterSpacing: 0.16 * fem,
                            //           color: Color(0xffffffff),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //   // taxpropertyGEP (112:1167)
                            //   left: 140.5 * fem,
                            //   top: 195 * fem,
                            //   child: Align(
                            //     child: Container(
                            //       // width: 91 * fem,
                            //       // height: 21 * fem,
                            //       alignment: Alignment.topCenter,
                            //       child: FittedBox(
                            //         fit: BoxFit.contain,
                            //         child: Text(
                            //           widget.userdata.companyName,
                            //           textAlign: TextAlign.center,
                            //           style: SafeGoogleFont(
                            //             'Poppins Medium',
                            //             fontSize: 16 * ffem,
                            //             fontWeight: FontWeight.w400,
                            //             height: 1.2999999523 * ffem / fem,
                            //             letterSpacing: 0.16 * fem,
                            //             color: Color(0xffffffff),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                              // infoJgs (112:1183)
                              left: 0 * fem,
                              top: 238 * fem,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    23 * fem, 20 * fem, 24 * fem, 19 * fem),
                                width: 400 * fem,
                                height: 100 * fem,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/dark-mode/images/info-bg-VJj.png',
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // ratingLmy (112:1172)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem,
                                          0 * fem,
                                          0 * fem,
                                          0 * fem),
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                                1 * fem),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _callNumber(widget
                                                  .userdata
                                                  .mobileNumber);
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  // starrEX (112:1174)
                                                  margin: EdgeInsets
                                                      .fromLTRB(
                                                          0 * fem,
                                                          0 * fem,
                                                          4 * fem,
                                                          0 * fem),
                                                  width: 16 * fem,
                                                  height: 15 * fem,
                                                  child:
                                                      Image.asset(
                                                    'assets/dark-mode/images/ph-icon-9gw.png',
                                                  ),
                                                ),
                                                Text(
                                                  // kao (112:1173)
                                                  "+91 " +
                                                      widget
                                                          .userdata
                                                          .mobileNumber,
                                                  style:
                                                      SafeGoogleFont(
                                                    'Poppins',
                                                    fontSize:
                                                        15 * ffem,
                                                    fontWeight:
                                                        FontWeight
                                                            .w400,
                                                    height: 1.3 *
                                                        ffem /
                                                        fem,
                                                    letterSpacing:
                                                        0.15 * fem,
                                                    color: Color(
                                                        0xffffffff),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              final Uri params =
                                                  Uri(
                                                scheme: 'mailto',
                                                path: widget
                                                    .userdata
                                                    .email, //add subject and body here
                                              );

                                              var url =
                                                  params.toString();
                                              if (await canLaunch(
                                                  url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment
                                                          .topCenter,
                                                  // mapCSo (112:1177)
                                                  margin: EdgeInsets
                                                      .fromLTRB(
                                                          0 * fem,
                                                          1 * fem,
                                                         5 * fem,
                                                          0 * fem),
                                                  width: 14 * fem,
                                                  child:
                                                      Image.asset(
                                                    'assets/dark-mode/images/mail-icon-J7m.png',
                                                  ),
                                                ),
                                                Container(
                                                  constraints: const BoxConstraints(
                                                    maxWidth: 160,
                                                  ),
                                                  padding: EdgeInsets.only(right: 16),
                                                  alignment: Alignment.topLeft,
                                                  child: FittedBox(
                                                    fit:BoxFit.fill,
                                                    child: Text(
                                                      // km5mV (112:1176)
                                                      widget.userdata
                                                          .email,
                                                      maxLines: 2,
                                                      softWrap: false,
                                                      style:
                                                          SafeGoogleFont(
                                                        'Poppins',
                                                        fontSize:
                                                            15 * ffem,
                                                        fontWeight:
                                                            FontWeight
                                                                .w400,
                                                        height: 1.3 *
                                                            ffem /
                                                            fem,
                                                        letterSpacing:
                                                            0.15 *
                                                                fem,
                                                        color: Color(
                                                            0xffffffff),
                                                      ),
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
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // aboutmgF (112:1185)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 19 * fem, 25 * fem),
                        width: 373 * fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // aboutthelawyersDV (112:1186)
                              margin: EdgeInsets.fromLTRB(
                                  1 * fem, 0 * fem, 0 * fem, 14 * fem),
                              child: Text(
                                'About',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2575 * ffem / fem,
                                  color: Color(0xffcccccc),
                                ),
                              ),
                            ),
                            Container(
                              // sedutperspiciatisundeomnisiste (112:1187)
                              constraints: BoxConstraints(
                                maxWidth: 373 * fem,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xff686868),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.userdata.about,
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff8a93aa),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // aboutthelawyersDV (112:1186)
                              margin: EdgeInsets.fromLTRB(
                                  1 * fem, 25 * fem, 0 * fem, 14 * fem),
                              child: Text(
                                'City Name',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2575 * ffem / fem,
                                  color: Color(0xffcccccc),
                                ),
                              ),
                            ),
                            Container(
                              // sedutperspiciatisundeomnisiste (112:1187)
                              padding: EdgeInsets.only(left: 3),
                              constraints: BoxConstraints(
                                maxWidth: 373 * fem,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xff686868),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.userdata.cityName,
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff8a93aa),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // aboutthelawyersDV (112:1186)
                              margin: EdgeInsets.fromLTRB(
                                  1 * fem, 25 * fem, 0 * fem, 14 * fem),
                              child: Text(
                                'GST Number',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2575 * ffem / fem,
                                  color: Color(0xffcccccc),
                                ),
                              ),
                            ),
                            Container(
                              // sedutperspiciatisundeomnisiste (112:1187)
                              padding: EdgeInsets.only(left: 3),
                              constraints: BoxConstraints(
                                maxWidth: 373 * fem,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xff686868),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.userdata.gst != ''
                                          ? widget.userdata.gst
                                          : "No data present",
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff8a93aa),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // aboutthelawyersDV (112:1186)
                              margin: EdgeInsets.fromLTRB(
                                  1 * fem, 25 * fem, 0 * fem, 14 * fem),
                              child: Text(
                                'Business Category',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2575 * ffem / fem,
                                  color: Color(0xffcccccc),
                                ),
                              ),
                            ),
                            Container(
                              // sedutperspiciatisundeomnisiste (112:1187)
                              padding: EdgeInsets.only(left: 3),
                              constraints: BoxConstraints(
                                maxWidth: 373 * fem,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xff686868),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.userdata.businessCategory,
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff8a93aa),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // aboutthelawyersDV (112:1186)
                              margin: EdgeInsets.fromLTRB(
                                  1 * fem, 25 * fem, 0 * fem, 14 * fem),
                              child: Text(
                                'Establishment Year',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2575 * ffem / fem,
                                  color: Color(0xffcccccc),
                                ),
                              ),
                            ),
                            Container(
                              // sedutperspiciatisundeomnisiste (112:1187)
                              padding: EdgeInsets.only(left: 3),
                              constraints: BoxConstraints(
                                maxWidth: 373 * fem,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xff686868),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.userdata.yearsEstablishment,
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff8a93aa),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // aboutthelawyersDV (112:1186)
                              margin: EdgeInsets.fromLTRB(
                                  1 * fem, 25 * fem, 0 * fem, 14 * fem),
                              child: Text(
                                'Business Classification',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2575 * ffem / fem,
                                  color: Color(0xffcccccc),
                                ),
                              ),
                            ),
                            Container(
                              // sedutperspiciatisundeomnisiste (112:1187)
                              padding: EdgeInsets.only(left: 3),
                              constraints: BoxConstraints(
                                maxWidth: 373 * fem,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xff686868),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget
                                          .userdata.businessClassification,
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff8a93aa),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // aboutthelawyersDV (112:1186)
                              margin: EdgeInsets.fromLTRB(
                                  1 * fem, 25 * fem, 0 * fem, 14 * fem),
                              child: Text(
                                'Business Presence',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2575 * ffem / fem,
                                  color: Color(0xffcccccc),
                                ),
                              ),
                            ),
                            Container(
                              // sedutperspiciatisundeomnisiste (112:1187)
                              padding: EdgeInsets.only(left: 3),
                              constraints: BoxConstraints(
                                maxWidth: 373 * fem,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xff686868),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.userdata.businessPresence,
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff8a93aa),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // aboutthelawyersDV (112:1186)
                              margin: EdgeInsets.fromLTRB(
                                  1 * fem, 25 * fem, 0 * fem, 14 * fem),
                              child: Text(
                                'Business Information',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2575 * ffem / fem,
                                  color: Color(0xffcccccc),
                                ),
                              ),
                            ),
                            Container(
                              // sedutperspiciatisundeomnisiste (112:1187)
                              padding: EdgeInsets.only(left: 3),
                              constraints: BoxConstraints(
                                maxWidth: 373 * fem,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xff686868),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.userdata
                                                  .businessInformation !=
                                              ""
                                          ? widget.userdata.businessInformation
                                          : "No data present",
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff8a93aa),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,14,0),
                        child: Divider(thickness: 0.3,color: Colors.white,),
                      ),
                      Container(
                        width: 400 * fem,
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 20 * fem, 0 * fem, 25 * fem),
                        // height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Social Media',
                              style: SafeGoogleFont(
                                'Poppins Medium',
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2575 * ffem / fem,
                                color: Color(0xffcccccc),
                              ),
                            ),
                            SizedBox(
                              height: 16 * fem,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Instagram :-',
                                  style: SafeGoogleFont(
                                    'Poppins Medium',
                                    fontSize: 18 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575 * ffem / fem,
                                    color: Color(0xffcccccc),
                                  ),
                                ),
                                SizedBox(
                                  width: 14 * fem,
                                ),
                                Text(
                                  widget.userdata.instagram != ""
                                      ? widget.userdata.instagram
                                      : 'No data present',
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xff8a93aa),
                                  ),
                                )
                              ],
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
        ),
      ),
    );
  }

  static Widget documentViewer(String url, context) => SafeArea(
          child: Scaffold(
        appBar: AppBar(
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
        ),
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.184, 1),
              end: Alignment(0.184, -1),
              colors: <Color>[Color(0xff000000), Color(0x00000000)],
              stops: <double>[0, 1],
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: InteractiveViewer(
            panEnabled: true,
            maxScale: 4,
            scaleEnabled: true,
            constrained: false,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
      ));
  _callNumber(String number) async {
    //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
