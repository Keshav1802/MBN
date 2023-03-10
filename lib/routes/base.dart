
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mothering_business_network/routes/custom_app_bar.dart';


class BaseLayout extends StatefulWidget {
  final Widget page;
  final bool isAppBar;
  final String text;

   const BaseLayout({
    this.page,
    this.isAppBar,
    this.text = "",
  });

  @override
  _BaseLayoutState createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppBar
          ? CustomAppBar(
        title: Text(widget.text),
        backgroundColor: Colors.white,
        iconColor: Colors.black,
      )
          : null,
      // drawer: CustomDrawer(),
      body: widget.page,
    );
  }
}

