import 'package:dental_care_app/pages/educatie.dart';
import 'package:dental_care_app/pages/home.dart';
import 'package:dental_care_app/pages/locatii.dart';
import 'package:dental_care_app/pages/oboarding.dart';
import 'package:dental_care_app/pages/programari.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/login.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "./pages/meniu.dart";
import "./utils/shared_pref_keys.dart" as pref_keys;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loggedIn = prefs.getBool('loggedIn');
  var firstTime = prefs.getBool('firstTime') ?? true;
  runApp(
    MaterialApp(
        home: firstTime == true
            ? const OnBoardingPage()
            : loggedIn == true
                ? const MyApp()
                : LoginPage()), // use MaterialApp
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int pageindex = 0;

  final List<Widget> pages = [
    HomePage(),
    const ProgramariScreen(),
    const LocatiiScreen(),
    EducatieScreen(),
    MeniuScreen(),
  ];

  List<Widget> icons = const [
    ImageIcon(AssetImage("./assets/images/navbar/home.png")),
    ImageIcon(AssetImage("./assets/images/navbar/programari.png")),
    ImageIcon(AssetImage("./assets/images/navbar/contact.png")),
    ImageIcon(AssetImage("./assets/images/navbar/educatie.png")),
    ImageIcon(AssetImage("./assets/images/navbar/menu.png")),
  ];
  void changePage(index) {
    setState(
      () {
        pageindex = index;
      },
    );
  }

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: curvedNavigation(),
      body: pages[pageindex],
    );
  }

  CurvedNavigationBar curvedNavigation() {
    return CurvedNavigationBar(
      onTap: changePage,
      key: bottomNavigationKey,
      animationDuration: const Duration(milliseconds: 400),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      buttonBackgroundColor: Colors.white,
      color: Colors.white,
      items: icons,
      height: 60,
      index: 0,
    );
  }
}
