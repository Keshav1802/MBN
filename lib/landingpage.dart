import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mothering_business_network/dashboard.dart';
import 'package:mothering_business_network/guest.dart';
import 'package:mothering_business_network/meeting.dart';
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:mothering_business_network/settings.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class landingPage extends StatefulWidget {
  String name;
  String user_id;
  String chapter_id;
  String city_id;
  ChapterDetails chapterDetails;
  List<ChapterUserDetails> chapterUserDetails;
  Data logindata;

  landingPage(this.name, this.user_id, this.chapter_id, this.city_id,
      this.chapterDetails, this.chapterUserDetails,this.logindata);
  @override
  State<landingPage> createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      DashboardPage(widget.name, widget.logindata.email,widget.user_id, widget.chapter_id,widget.chapterDetails,widget.chapterUserDetails),
      MeetingPage(widget.user_id, widget.city_id, widget.chapter_id,
          widget.chapterDetails, widget.chapterUserDetails),
      GuestPage(widget.user_id, widget.city_id, widget.chapter_id),
      SettingsPage(widget.logindata)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.home,
        ),
        title: ("Dashboard"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: Color(0xff616A7A),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.handshake_outlined,
        ),
        title: ("Meeting"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: Color(0xff616A7A),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.map,
        ),
        title: ("Guest"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: Color(0xff616A7A),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person_outline_outlined,
        ),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: Color(0xff616A7A),
      ),
    ];
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        elevation: 24,
        backgroundColor: Colors.white,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: new Text(
          'Are you sure?',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        content: new Text('Do you want to exit the App',
            style: TextStyle(fontWeight: FontWeight.w400)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',
                style: TextStyle(fontWeight: FontWeight.w400)),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: new Text('Yes',
                style: TextStyle(fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Color(0xff000000), // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(1.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style12, // Choose the nav bar style with this property.
      ),
    );
  }
}
