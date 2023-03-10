import 'package:flutter/material.dart';
import 'package:mothering_business_network/1to1/1to1list.dart';
import 'package:mothering_business_network/InterChapter/interChapterlist.dart';
import 'package:mothering_business_network/models/LoginData.dart';
import 'package:mothering_business_network/utils.dart';
import 'package:sizer/sizer.dart';

class MeetingPage extends StatefulWidget {
  String user_id;
  String city_id;
  String chapter_id;
  ChapterDetails chapterDetails;
  List<ChapterUserDetails> chapterUserDetails;

  MeetingPage(this.user_id, this.city_id, this.chapter_id, this.chapterDetails,
      this.chapterUserDetails);

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meeting",
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
        elevation: 0.2,
      ),
      backgroundColor: Color(0xff45536A),
      body: Container(
        // decoration: new BoxDecoration(
        //     gradient: new LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //         Color(0xff262B36).withOpacity(0.3),
        //         Color(0xff343946).withOpacity(0.3)
        //       ],
        //     )),
        decoration: BoxDecoration (
          gradient: LinearGradient (
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xff13161a), Color(0xff0f1218)],
            stops: <double>[0, 1],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 60, 20, 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => oneToOneListPage(
                          widget.user_id,
                          widget.chapter_id,
                          widget.chapterDetails,
                          widget.chapterUserDetails)));
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color(0xff45536A),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.5),
                          blurRadius: 1.0,
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text('1 to 1',
                            style: SafeGoogleFont(
                              'Poppins SemiBold',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2575 * ffem / fem,
                              color: Color(0xffA9B1C6),
                            )),
                      ),
                      SizedBox(
                        width: 55.w,
                      ),
                      Container(
                        child: IconButton(
                          visualDensity: VisualDensity.comfortable,
                          iconSize: 20,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA9B1C6),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => oneToOneListPage(
                                    widget.user_id,
                                    widget.chapter_id,
                                    widget.chapterDetails,
                                    widget.chapterUserDetails)));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => InterChapterListPage(
                          widget.user_id,
                          widget.chapter_id,
                          widget.chapterDetails,
                          widget.chapterUserDetails)));
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color(0xff45536A),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.5),
                          blurRadius: 1.0,
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text('Inter Chapter',
                            style: SafeGoogleFont(
                              'Poppins SemiBold',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2575 * ffem / fem,
                              color: Color(0xffA9B1C6),
                            )),
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Container(
                        child: IconButton(
                          visualDensity: VisualDensity.comfortable,
                          iconSize: 20,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA9B1C6),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => InterChapterListPage(
                                    widget.user_id,
                                    widget.chapter_id,
                                    widget.chapterDetails,
                                    widget.chapterUserDetails)));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
