import 'dart:ui';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mothering_business_network/ask/asklist.dart';
import 'package:mothering_business_network/changePassword.dart';
import 'package:mothering_business_network/helper.dart';
import 'package:mothering_business_network/login.dart';
import 'package:mothering_business_network/profiledetails.dart';
import 'package:mothering_business_network/referral/referrallistPage.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  Data logindata;
  SettingsPage(this.logindata);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    Future<void> _launched;
    final Image noImage =
    Image.asset("assets/img_1.png");
    return Scaffold(
      // backgroundColor: Color(0xff13161a),
      body: SingleChildScrollView(
        child: Container(
          // profile2H9 (148:857)
          padding: EdgeInsets.only(bottom: 30),
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
                // autogroupq9vkTNT (L65QJfFkbUBBfmZTHKQ9vK)
                padding:
                    EdgeInsets.fromLTRB(21 * fem, 46 * fem, 20 * fem, 13 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // profile8zP (148:921)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 34 * fem),
                      child: Text(
                        'Profile',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont(
                          'Poppins Medium',
                          fontSize: 24 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2575 * ffem / fem,
                          color: Color(0xff9ba6bf),
                        ),
                      ),
                    ),
                    Container(
                      // autogroupxbk9np3 (L65NwsBi9NBQPDKoxaxbK9)
                      width: double.infinity,
                      height: 293 * fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // confetticlbrtnJnP (148:963)
                            left: 100 * fem,
                            top: 0 * fem,
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                width: 172 * fem,
                                height: 124.56 * fem,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // autogroupdxmdLyy (L65PP6xf8QbFAJkAgTDXMD)
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          31 * fem, 1.22 * fem, 25.23 * fem),
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // ellipse553dV (148:973)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 1.61 * fem, 16.41 * fem),
                                            width: 6.33 * fem,
                                            height: 7.08 * fem,
                                            child: Image.asset(
                                              'assets/dark-mode/images/ellipse-55-JG3.png',
                                              width: 6.33 * fem,
                                              height: 7.08 * fem,
                                            ),
                                          ),
                                          Container(
                                            // vector245Kqu (148:968)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 6.42 * fem, 25.18 * fem),
                                            width: 16.12 * fem,
                                            height: 8.33 * fem,
                                            child: Image.asset(
                                              'assets/dark-mode/images/vector-245-ZaB.png',
                                              width: 16.12 * fem,
                                              height: 8.33 * fem,
                                            ),
                                          ),
                                          Container(
                                            // vector236nzP (148:964)
                                            width: 23.94 * fem,
                                            height: 11.33 * fem,
                                            child: Image.asset(
                                              'assets/dark-mode/images/vector-236-HVV.png',
                                              width: 23.94 * fem,
                                              height: 11.33 * fem,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // ellipse565yV (148:971)
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          116.89 * fem, 6.47 * fem, 0 * fem),
                                      width: 7.08 * fem,
                                      height: 7.67 * fem,
                                      child: Image.asset(
                                        'assets/dark-mode/images/ellipse-56-fNT.png',
                                        width: 7.08 * fem,
                                        height: 7.67 * fem,
                                      ),
                                    ),
                                    Container(
                                      // vector237mbR (148:965)
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          0 * fem, 17.25 * fem, 83.16 * fem),
                                      width: 16.04 * fem,
                                      height: 19.11 * fem,
                                      child: Image.asset(
                                        'assets/dark-mode/images/vector-237-uz3.png',
                                        width: 16.04 * fem,
                                        height: 19.11 * fem,
                                      ),
                                    ),
                                    Container(
                                      // ellipse53UEw (148:974)
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          0 * fem, 29.77 * fem, 119.14 * fem),
                                      width: 7.23 * fem,
                                      height: 5.42 * fem,
                                      child: Image.asset(
                                        'assets/dark-mode/images/ellipse-53-VFH.png',
                                        width: 7.23 * fem,
                                        height: 5.42 * fem,
                                      ),
                                    ),
                                    Container(
                                      // vector2389M5 (148:967)
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          0 * fem, 12.16 * fem, 97.65 * fem),
                                      width: 11.84 * fem,
                                      height: 4.91 * fem,
                                      child: Image.asset(
                                        'assets/dark-mode/images/vector-238-FMd.png',
                                        width: 11.84 * fem,
                                        height: 4.91 * fem,
                                      ),
                                    ),
                                    Container(
                                      // autogrouph1xhckT (L65PZr9kjbxJhZgkmeH1XH)
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          31 * fem, 4.66 * fem, 36.14 * fem),
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // ellipse54WL3 (148:972)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 42.67 * fem),
                                            width: 6.33 * fem,
                                            height: 7.08 * fem,
                                            child: Image.asset(
                                              'assets/dark-mode/images/ellipse-54-S4B.png',
                                              width: 6.33 * fem,
                                              height: 7.08 * fem,
                                            ),
                                          ),
                                          Container(
                                            // ellipse52oK9 (148:970)
                                            margin: EdgeInsets.fromLTRB(
                                                4.18 * fem,
                                                0 * fem,
                                                0 * fem,
                                                0 * fem),
                                            width: 7.08 * fem,
                                            height: 7.67 * fem,
                                            child: Image.asset(
                                              'assets/dark-mode/images/ellipse-52-VDM.png',
                                              width: 7.08 * fem,
                                              height: 7.67 * fem,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // autogroupzxkx63M (L65PhG74zSi4WJpHw4zXkX)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 37.92 * fem, 0 * fem, 0 * fem),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // vector239Cs5 (148:969)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0.41 * fem, 43.87 * fem),
                                            width: 16.52 * fem,
                                            height: 9.96 * fem,
                                            child: Image.asset(
                                              'assets/dark-mode/images/vector-239-ofH.png',
                                              width: 16.52 * fem,
                                              height: 9.96 * fem,
                                            ),
                                          ),
                                          Container(
                                            // vector246J9R (148:966)
                                            width: 23.07 * fem,
                                            height: 18.66 * fem,
                                            child: Image.asset(
                                              'assets/dark-mode/images/vector-246-mGF.png',
                                              width: 23.07 * fem,
                                              height: 18.66 * fem,
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
                          Positioned(
                            // lawyerQCT (148:858)
                            left: 0 * fem,
                            top: 34 * fem,
                            child: Container(
                              width: 373 * fem,
                              height: 259 * fem,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // lawyerbgVjh (148:859)
                                    left: 0 * fem,
                                    top: 80 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 373 * fem,
                                        height: 179 * fem,
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
                                  Positioned(
                                    // imgNoV (148:860)
                                    left: 123 * fem,
                                    top: 0 * fem,
                                    child: Container(
                                      width: 125 * fem,
                                      height: 125 * fem,
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
                                      child: Center(
                                        // autogroupwfhuR15 (L5m46UzizxaR2dvVSuwfhu)
                                        child: SizedBox(
                                          // width: 125 * fem,
                                          // height: 125 * fem,
                                          child:
                                          ClipOval(
                                            child:Image.network(
                                              widget.logindata.profilePic,
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
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // katiesyrusTiT (148:864)
                                    left: 129 * fem,
                                    top: 137 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 115 * fem,
                                        height: 34 * fem,
                                        child: Text(
                                          widget.logindata.name,
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Poppins SemiBold',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3999999364 * ffem / fem,
                                            letterSpacing: 0.24 * fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // phPEj (150:1314)
                                    left: 99 * fem,
                                    top: 211 * fem,
                                    child: Container(
                                      width: 176 * fem,
                                      height: 27 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // phicon1mu (150:1315)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                1 * fem, 6 * fem, 0 * fem),
                                            width: 18 * fem,
                                            height: 18 * fem,
                                            child: Image.asset(
                                              'assets/dark-mode/images/ph-icon-9gw.png',
                                              width: 18 * fem,
                                              height: 18 * fem,
                                            ),
                                          ),
                                          Text(
                                            // bEK (150:1316)
                                            "+91 " +
                                                widget.logindata.mobileNumber,
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Poppins',
                                              fontSize: 18 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5 * ffem / fem,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // mailcv7 (150:1317)
                                    left: 86 * fem,
                                    top: 176 * fem,
                                    child: Container(
                                      width: 202 * fem,
                                      height: 27 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // mailicondqD (150:1319)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 9 * fem, 1 * fem),
                                            width: 21 * fem,
                                            height: 18 * fem,
                                            child: Image.asset(
                                              'assets/dark-mode/images/mail-icon-J7m.png',
                                              width: 21 * fem,
                                              height: 18 * fem,
                                            ),
                                          ),
                                          FittedBox(
                                            fit:BoxFit.fill,
                                            child: Text(
                                              // katiesgmailcomHPy (150:1318)
                                              widget.logindata.email,
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Poppins',
                                                fontSize: 16 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.5 * ffem / fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileDetails(widget.logindata)));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(5),
                              child: Divider(
                                thickness: 6,
                                color: Colors.grey,
                              )),
                          SizedBox(
                            width: 6.w,
                          ),
                          Align(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              width: 18 * fem,
                              height: 42 * fem,
                              child: Image.asset(
                                'assets/dark-mode/images/mng-prfl-icon-Vp7.png',
                                width: 18 * fem,
                                height: 20 * fem,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 200,
                            ),
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                'Manage Profile',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 3.5 * ffem / fem,
                                  color: Color(0xffa8b1c5),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(50, 0, 15, 0),
                            alignment: Alignment.bottomCenter,
                            height: 70,
                            child: IconButton(
                              visualDensity: VisualDensity.comfortable,
                              iconSize: 20,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xffA9B1C6),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProfileDetails(widget.logindata)));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReferralListPage(
                            widget.logindata),
                      ));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(5),
                              child: Divider(
                                thickness: 6,
                                color: Colors.grey,
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          Align(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              width: 30 * fem,
                              height: 42 * fem,
                              child: Image.asset(
                                'assets/dark-mode/images/crrncy-icon-Ezo.png',
                                width: 28 * fem,
                                height: 20 * fem,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 200,
                            ),
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                'Referral',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 3.5 * ffem / fem,
                                  color: Color(0xffa8b1c5),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(48, 0, 15, 0),
                            alignment: Alignment.bottomCenter,
                            height: 70,
                            child: IconButton(
                              visualDensity: VisualDensity.comfortable,
                              iconSize: 20,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xffA9B1C6),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReferralListPage(
                                      widget.logindata),
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AskListPage(
                              widget.logindata.id,widget.logindata.name)));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(5),
                              child: Divider(
                                thickness: 6,
                                color: Colors.grey,
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          Align(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              width: 30 * fem,
                              height: 42 * fem,
                              child: Image.asset(
                                'assets/dark-mode/images/trms-icon-z3u.png',
                                width: 28 * fem,
                                height: 20 * fem,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 200,
                            ),
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                'Ask',
                                style: SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 3.5 * ffem / fem,
                                  color: Color(0xffa8b1c5),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(48, 0, 15, 0),
                            alignment: Alignment.bottomCenter,
                            height: 70,
                            child: IconButton(
                              visualDensity: VisualDensity.comfortable,
                              iconSize: 20,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xffA9B1C6),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AskListPage(
                                        widget.logindata.id,widget.logindata.name)));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                    },
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            child: Divider(
                              thickness: 6,
                              color: Colors.grey,
                            )),
                        SizedBox(
                          width: 5.w,
                        ),
                        Align(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            width: 30 * fem,
                            height: 42 * fem,
                            child: Image.asset(
                              'assets/dark-mode/images/mng-pymtn-icon-Mz3.png',
                              width: 28 * fem,
                              height: 20 * fem,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Container(
                          constraints: const BoxConstraints(
                            maxWidth: 200,
                          ),
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              'Change Password',
                              style: SafeGoogleFont(
                                'Poppins Medium',
                                fontSize: 22 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 3.5 * ffem / fem,
                                color: Color(0xffa8b1c5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(50, 0, 15, 0),
                          alignment: Alignment.bottomCenter,
                          height: 70,
                          child: IconButton(
                            visualDensity: VisualDensity.comfortable,
                            iconSize: 20,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffA9B1C6),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen()));
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => GuestListPage(widget.user_id),
                              // ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: (){
                  //     _launchInBrowser(Uri.parse('https://mothering.in/web/terms'));
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //           padding: EdgeInsets.all(5),
                  //           child: Divider(
                  //             thickness: 6,
                  //             color: Colors.grey,
                  //           )),
                  //       SizedBox(
                  //         width: 5.5.w,
                  //       ),
                  //       Align(
                  //         child: Container(
                  //           alignment: Alignment.bottomCenter,
                  //           width: 30 * fem,
                  //           height: 42 * fem,
                  //           child: Image.asset(
                  //             'assets/dark-mode/images/abt-icon-wNj.png',
                  //             width: 28 * fem,
                  //             height: 20 * fem,
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 2.5.w,
                  //       ),
                  //       Container(
                  //         constraints: const BoxConstraints(
                  //           maxWidth: 200,
                  //         ),
                  //         alignment: Alignment.centerLeft,
                  //         child: FittedBox(
                  //           fit: BoxFit.fill,
                  //           child: Text(
                  //             'Terms & Conditions',
                  //             style: SafeGoogleFont(
                  //               'Poppins Medium',
                  //               fontSize: 22 * ffem,
                  //               fontWeight: FontWeight.w400,
                  //               height: 3.5 * ffem / fem,
                  //               color: Color(0xffa8b1c5),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         margin: EdgeInsets.fromLTRB(47, 0, 15, 0),
                  //         alignment: Alignment.bottomCenter,
                  //         height: 70,
                  //         child: IconButton(
                  //           visualDensity: VisualDensity.comfortable,
                  //           iconSize: 20,
                  //           icon: Icon(
                  //             Icons.arrow_forward_ios,
                  //             color: Color(0xffA9B1C6),
                  //           ),
                  //           onPressed: () async {
                  //             _launchInBrowser(Uri.parse('https://mothering.in/web/terms'));
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: (){
                  //     _launchInBrowser(Uri.parse('https://mothering.in/web/privacy-policy'));
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //           padding: EdgeInsets.all(5),
                  //           child: Divider(
                  //             thickness: 6,
                  //             color: Colors.grey,
                  //           )),
                  //       SizedBox(
                  //         width: 5.5.w,
                  //       ),
                  //       Align(
                  //         child: Container(
                  //           alignment: Alignment.bottomCenter,
                  //           width: 30 * fem,
                  //           height: 42 * fem,
                  //           child: Image.asset(
                  //             'assets/dark-mode/images/abt-icon-wNj.png',
                  //             width: 28 * fem,
                  //             height: 20 * fem,
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 3.w,
                  //       ),
                  //       Container(
                  //         constraints: const BoxConstraints(
                  //           maxWidth: 200,
                  //         ),
                  //         alignment: Alignment.centerLeft,
                  //         child: FittedBox(
                  //           fit: BoxFit.fill,
                  //           child: Text(
                  //             'Privacy Policy',
                  //             style: SafeGoogleFont(
                  //               'Poppins Medium',
                  //               fontSize: 22 * ffem,
                  //               fontWeight: FontWeight.w400,
                  //               height: 3.5 * ffem / fem,
                  //               color: Color(0xffa8b1c5),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         margin: EdgeInsets.fromLTRB(47, 0, 15, 0),
                  //         alignment: Alignment.bottomCenter,
                  //         height: 70,
                  //         child: IconButton(
                  //           visualDensity: VisualDensity.comfortable,
                  //           iconSize: 20,
                  //           icon: Icon(
                  //             Icons.arrow_forward_ios,
                  //             color: Color(0xffA9B1C6),
                  //           ),
                  //           onPressed: () async {
                  //             _launchInBrowser(Uri.parse('https://mothering.in/web/privacy-policy'));
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: (){
                      // Utils.clearAllValue();
                      // // prefs.remove('userData');
                      // Navigator.of(context, rootNavigator: true).pop();
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      //   builder: (context) => Login(),
                      // ), (route) => false);
                    },
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            child: Divider(
                              thickness: 6,
                              color: Colors.grey,
                            )),
                        SizedBox(
                          width: 6.w,
                        ),
                        Align(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            width: 30 * fem,
                            height: 42 * fem,
                            child: Image.asset(
                              'assets/dark-mode/images/logout-icon-yrB.png',
                              width: 28 * fem,
                              height: 20 * fem,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.5.w,
                        ),
                        Container(
                          constraints: const BoxConstraints(
                            maxWidth: 200,
                          ),
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              'Sign Out',
                              style: SafeGoogleFont(
                                'Poppins Medium',
                                fontSize: 22 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 3.5 * ffem / fem,
                                color: Color(0xffa8b1c5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(47, 0, 15, 0),
                          alignment: Alignment.bottomCenter,
                          height: 70,
                          child: IconButton(
                            visualDensity: VisualDensity.comfortable,
                            iconSize: 20,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffA9B1C6),
                            ),
                            onPressed: () async {
                              Utils.clearAllValue();
                              // prefs.remove('userData');
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ), (route) => false);
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) => Login(),
                              // ));
                              // Navigator.pushReplacement(context, MaterialPageRoute(
                              //   builder: (context) => Login(),
                              // ));
                              // Navigator.pushReplacement(MaterialPageRoute(
                              //   builder: (context) => Login(),
                              // ));
                              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                              //   builder: (context) => Login(),
                              // ), (route) => false);
                              // Navigator.of(context, rootNavigator: true).pop();
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => GuestListPage(widget.user_id),
                              // ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0,0,12,0),
                    child: Wrap(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                  "To know more about our company ",
                                style:SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 15 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 3.5 * ffem / fem,
                                  color: Color(0xffa8b1c5),
                                ),
                              ),
                              TextSpan(
                                  text: "T&Cs",
                                  style:SafeGoogleFont(
                                    'Poppins Medium',
                                    fontSize: 16 * ffem,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400,
                                    height: 3.5 * ffem / fem,
                                    color: Color(0xffa8b1c5),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        _launched = _launchInBrowser(Uri.parse('https://mothering.in/web/terms'));
                                      });
                                    }),
                              TextSpan(
                                  text: " and ",
                                style:SafeGoogleFont(
                                  'Poppins Medium',
                                  fontSize: 15 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 3.5 * ffem / fem,
                                  color: Color(0xffa8b1c5),
                                ),
                              ),
                              TextSpan(
                                  text: "Privacy Policy",
                                  style:SafeGoogleFont(
                                    'Poppins Medium',
                                    fontSize: 16 * ffem,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400,
                                    height: 3.5 * ffem / fem,
                                    color: Color(0xffa8b1c5),
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
                    ))],
              )
            ],
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
}
