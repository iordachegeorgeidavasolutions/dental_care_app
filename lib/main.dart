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
import 'package:flutter_localizations/flutter_localizations.dart';
// import "./utils/shared_pref_keys.dart" as pref_keys;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loggedIn = prefs.getBool('loggedIn');
  var firstTime = prefs.getBool('firstTime') ?? true;

  runApp(
    MaterialApp(
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('en'), Locale('ro')],
        home: firstTime == true
            ? const OnBoardingPage()
            : loggedIn == true
                ? MyApp()
                : LoginPage()), // use MaterialApp
  );
}

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
    const EducatieScreen(),
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
      body: pages[pageIndex],
    );
  }

  CurvedNavigationBar curvedNavigation() {
    return CurvedNavigationBar(
      onTap: (index) {
        setState(() {
          pageIndex = index;
        });
      },
      key: _bottomNavigationKey,
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
