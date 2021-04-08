import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
import 'package:mobile/screens/screen_profile.dart';
import 'package:mobile/screens/index.dart';
import 'package:mobile/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/sharedpreference.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ScreenHiddenDrawer> drawerItems = [];
  var sharedPreference = new SharedPreference();

  @override
  void initState() {
    drawerItems.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Home",
          colorLineSelected: green1,
          baseStyle: TextStyle(
            color: Colors.white,
          ),
          selectedStyle: TextStyle(color: green1, fontSize: 25.0),
        ),
        Container(color: Colors.teal, child: ScreenTabs())));

    drawerItems.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Profile",
          colorLineSelected: green1,
          baseStyle: TextStyle(
            color: Colors.white,
          ),
          selectedStyle: TextStyle(color: green1, fontSize: 25.0),
        ),
        Container(
          color: Colors.orange,
          child: Center(child: ProfileScreen()),
        )));
    drawerItems.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Contact Us",
          colorLineSelected: green1,
          baseStyle: TextStyle(
            color: Colors.white,
          ),
          selectedStyle: TextStyle(color: green1, fontSize: 25.0),
        ),
        Container(
          color: Colors.orange,
          child: Center(child: ContactsScreen()),
        )));
    drawerItems.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Help",
          colorLineSelected: green1,
          baseStyle: TextStyle(
            color: Colors.white,
          ),
          selectedStyle: TextStyle(color: green1, fontSize: 25.0),
        ),
        Container(
          color: Colors.orange,
          child: Center(child: HelpScreen()),
        )));
    drawerItems.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Logout",
          colorLineSelected: green1,
          baseStyle: TextStyle(
            color: Colors.white,
          ),
          onTap: () {
            this.sharedPreference.clearSF();
          },
          selectedStyle: TextStyle(color: green1, fontSize: 25.0),
        ),
        Container(
          color: Colors.orange,
          child: Center(child: Text("Logged Out")),
        )));

    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      if (index == 0) {
        Scaffold.of(context).openDrawer(); // This is what I've tried
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      initPositionSelected: 0,
      screens: drawerItems,
      backgroundColorMenu: blue,
      slidePercent: 60.0,
      elevationAppBar: 0.0,
      backgroundColorAppBar: colorPrimary,
    );
  }
}
