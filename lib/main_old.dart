import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:dental_care_app/screens/educatie.dart';
import 'package:dental_care_app/screens/home.dart';
import 'package:dental_care_app/screens/locatii.dart';
import 'package:dental_care_app/screens/programari.dart';
import 'package:dental_care_app/utils/api_firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/login.dart';
import "./screens/meniu.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

// void _handleMessage(RemoteMessage message) {
//   if (message.data['tip'] == '0') {
//     navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) {
//       return ProgramariScreen();
//     }));
//   } else
//     print('sui');
// }

// import "./utils/shared_pref_keys.dart" as pref_keys;
final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  var loggedIn = prefs.getBool('loggedIn');
  runApp(
    MaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('ro')],
      home: loggedIn == true ? const MyApp() : LoginPage(),
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
      ), // use MaterialApp
    ),
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

  // void _handleMessage(RemoteMessage message) {
  //   if (message.data['tip'] == '0') {
  //     navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) {
  //       return ProgramariScreen();
  //     }));
  //   } else {
  //     print('alo?');
  //   }
  // }

  // Future<void> setupInteractedMessage() async {
  //   // Get any messages which caused the application to open from
  //   // a terminated state.
  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  //   // If the message also contains a data property with a "type" of "chat",
  //   // navigate to a chat screen
  //   if (initialMessage != null) {
  //     _handleMessage(initialMessage);
  //   }

  //   // Also handle any interaction when the app is in the background via a
  //   // Stream listener
  // }

  final List<Widget> pages = [
    const HomePage(),
    //const ProgramariScreen(), //old Andrei Bădescu
    const LocatiiScreen(),
    EducatieScreen(),
    MeniuScreen(),
  ];

  List<CurvedNavigationBarItem> icons = const [
    CurvedNavigationBarItem(
      child: ImageIcon(AssetImage("./assets/images/navbar/home.png")),
      label: 'Acasă',
    ),
    CurvedNavigationBarItem(
      child: ImageIcon(AssetImage("./assets/images/navbar/programari.png")),
      label: 'Programări',
    ),
    CurvedNavigationBarItem(
      child: ImageIcon(AssetImage("./assets/images/navbar/contact.png")),
      label: 'Contact',
    ),
    CurvedNavigationBarItem(
      child: ImageIcon(AssetImage("./assets/images/navbar/educatie.png")),
      label: 'Educație',
    ),
    CurvedNavigationBarItem(
      child: ImageIcon(AssetImage("./assets/images/navbar/menu.png")),
      label: 'Meniu',
    ),
  ];

  void setPage(index) {
    final CurvedNavigationBarState? navBarState = _bottomNavigationKey.currentState;
    navBarState?.setPage(index);
  }

  @override
  void initState() {
    super.initState();
    // setupInteractedMessage();
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: navigatorKey,
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
            //ProgramariScreen(),
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
      height: 65,
      index: pageIndex,
    );
  }
}
