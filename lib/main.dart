import 'package:dental_care_app/pages/educatie.dart';
import 'package:dental_care_app/pages/home.dart';
import 'package:dental_care_app/pages/locatii.dart';
import 'package:dental_care_app/pages/programari.dart';
import 'package:dental_care_app/utils/api_firebase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/login.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "./pages/meniu.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
// import "./utils/shared_pref_keys.dart" as pref_keys;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  var loggedIn = prefs.getBool('loggedIn');

  runApp(
    MaterialApp(
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('en'), Locale('ro')],
        home: loggedIn == true ? const MyApp() : LoginPage()), // use MaterialApp
  );
}

PageController MyController = PageController();

class MyApp extends StatefulWidget {
  // final VoidCallback setPage;
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int pageIndex = 0;

  // HomePage? tab1;
  // final ProgramariScreen tab2 = ProgramariScreen();

  final List<Widget> pages = [
    const HomePage(),
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

  void setPage(index) {
    final CurvedNavigationBarState? navBarState = _bottomNavigationKey.currentState;
    navBarState?.setPage(index);
  }

  @override
  void initState() {
    // (setPage);
    super.initState();
  }

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: curvedNavigation(),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: MyController,
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          children: <Widget>[
            HomePage(),
            ProgramariScreen(),
            LocatiiScreen(),
            EducatieScreen(),
            MeniuScreen(),
          ],
        ));
  }

  CurvedNavigationBar curvedNavigation() {
    return CurvedNavigationBar(
      onTap: (index) {
        MyController.jumpToPage(index);
      },
      key: _bottomNavigationKey,
      animationDuration: const Duration(milliseconds: 400),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      buttonBackgroundColor: Colors.white,
      color: Colors.white,
      items: icons,
      height: 60,
      index: pageIndex,
    );
  }
}
