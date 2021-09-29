import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second/pages/home_page.dart';
import 'package:second/pages/search_page.dart';
import 'dart:math' as math;
import '../theme/colors.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: getAppBar(),
        body: getBody(),
        bottomNavigationBar: getFooter());
  }

/* ======================= APP BODY ===================== */
  Widget getBody() {
    List<Widget> pages = [
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: HomePage()),
      Center(child: SearchPage()),
      Center(
        child: Text(
          "Upload Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: white),
        ),
      ),
      Center(
        child: Text(
          "Activity Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: white),
        ),
      ),
      Center(
        child: Text(
          "Account Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: white),
        ),
      ),
    ];

    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

/* ======================= APP BAR ===================== */
  PreferredSizeWidget getAppBar() {
    var size = MediaQuery.of(context).size;

    if (pageIndex == 0) {
      return PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppBar(
          backgroundColor: black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.photo_camera_outlined, size: 30, color: white),
              Text(
                "Instagram",
                style: GoogleFonts.grandHotel(fontSize: 35),
              ),
              Transform.rotate(
                  angle: -math.pi / 5,
                  child: Icon(Icons.send_outlined, size: 27))
            ],
          ),
        ),
      );
    } else if (pageIndex == 1) {
      return PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                Container(
                  width: size.width - 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: textFieldBackground),
                  child: TextField(
                    cursorColor: white.withOpacity(0.3),
                    style: TextStyle(color: white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search_outlined,
                            size: 27, color: white.withOpacity(0.4))),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
      );
    } else if (pageIndex == 2) {
      return AppBar(
          backgroundColor: appBarColor, title: Center(child: Text("Upload")));
    } else if (pageIndex == 3) {
      return AppBar(
          backgroundColor: appBarColor, title: Center(child: Text("Activity")));
    } else {
      return AppBar(
          backgroundColor: appBarColor, title: Center(child: Text("Account")));
    }
  }

/* ======================= APP FOOTER ===================== */
  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
      pageIndex == 1 ? Icons.search : Icons.search_outlined,
      pageIndex == 2 ? Icons.add_box : Icons.add_box_outlined,
      pageIndex == 3 ? Icons.favorite_rounded : Icons.favorite_border_outlined,
      pageIndex == 4 ? Icons.person_rounded : Icons.person_outline_rounded
    ];

    return Container(
      width: double.infinity,
      height: 60,
      //decoration: BoxDecoration(color: appFooterColor),
      child: Column(
        children: [
          Divider(
            color: black.withOpacity(0.3),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bottomItems.length, (index) {
                return InkWell(
                  onTap: () {
                    selectedTab(index);
                  },
                  child: Icon(bottomItems[index], size: 33, color: white),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

/* -------------------- Page's index -------------------- */
  selectedTab(index) {
    setState(() {
      pageIndex = index;
    }); // Setting a state to track the icon's list index with the pages
  }
}
