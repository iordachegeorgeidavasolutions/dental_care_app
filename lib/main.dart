import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:dental_care_app/screens/educatie.dart';
import 'package:dental_care_app/screens/home.dart';
import 'package:dental_care_app/screens/locatii.dart';
import 'package:dental_care_app/screens/programari.dart';
import 'package:dental_care_app/utils/classes.dart';
import 'package:dental_care_app/utils/api_firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/login.dart';
import "./screens/meniu.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;

// void _handleMessage(RemoteMessage message) {
//   if (message.data['tip'] == '0') {
//     navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) {
//       return ProgramariScreen();
//     }));
//   } else
//     print('sui');
// }

int myIndexLocatii = 0;

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
      home: loggedIn == true ? const MyApp(fromPinPage: false,) : LoginPage(),
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
      ), // use MaterialApp
    ),
  );
}

PageController MyController = PageController();

GlobalKey<CurvedNavigationBarState> myBottomNavigationKeyMain = GlobalKey();

CurvedNavigationBar curvedNavigationBar = CurvedNavigationBar(items: [],);

class MyApp extends StatefulWidget {

  final bool fromPinPage;
  // final VoidCallback setPage;
  const MyApp({
    super.key,
    required this.fromPinPage,
  });

  @override
  State<MyApp> createState() => MyAppState();

}

class MyAppState extends State<MyApp> {
  
  //final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey(); //old IGV

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

  late List<Widget> pages = [
    HomePage(myController: MyController, myBottomNavigationKey: myBottomNavigationKeyMain,),
    //const ProgramariScreen(), //old Andrei Bădescu
    ProgramariScreen(fromLocatiiPage: false, fromOtherPage: true, currentIndex: 0, isSelectedTrecute: true, isSelectedViitoare: false,),
    //const ListaProgramariEuCopii(), //old IGV
    LocatiiScreen(),
    EducatieScreen(),
    MeniuScreen(myController: MyController, myBottomNavigationKey: myBottomNavigationKeyMain, myLocatiiCallback: onLocatiiChanged),
  ];

  List<CurvedNavigationBarItem> icons = const [
    CurvedNavigationBarItem(
      child: ImageIcon(AssetImage("./assets/images/navbar/home.png")),
      label: 'Acasă',
    ),
    CurvedNavigationBarItem(
      child: ImageIcon(AssetImage("./assets/images/navbar/programari.png")),
      label: 'Programări',
      labelStyle: TextStyle(fontSize: 13),
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
    //final CurvedNavigationBarState? navBarState = _bottomNavigationKey.currentState; //old IGV
    final CurvedNavigationBarState? navBarState = myBottomNavigationKeyMain.currentState;
    if (widget.fromPinPage == false)
    {
      navBarState?.setPage(index);
    }
    else 
    {
      navBarState?.setPage(0);
    }

    print('main setPage index: $index');

  }

  @override
  void initState() {
    super.initState();
    login(context);
    loadDataCopii();

    curvedNavigationBar = curvedNavigation();
    
    // setupInteractedMessage();
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

  }

  //IGV
  void onLocatiiChanged(int? newValue) {
    setState(() {
      indexMyCurvedNavigationBar = newValue?? 0;
    });
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
            pageIndex = widget.fromPinPage? 4 : indexMyCurvedNavigationBar == 2? 2 : pageIndex; 
          });
        },
        children: <Widget>[
          HomePage(myController: MyController, myBottomNavigationKey: myBottomNavigationKeyMain,),
          //ListaProgramariEuCopii(), //old IGV
          //ProgramariScreen(idCopil:'-1'), //old IGV
          //ProgramariScreen(), //old Andrei Bădescu
          ProgramariScreen(fromLocatiiPage: false, fromOtherPage: true, currentIndex: 0, isSelectedTrecute: true, isSelectedViitoare: false,),
          LocatiiScreen(),
          EducatieScreen(),
          MeniuScreen(myController: MyController, myBottomNavigationKey: myBottomNavigationKeyMain, myLocatiiCallback: onLocatiiChanged),
        ],
      ),
    );
  }

  CurvedNavigationBar curvedNavigation() {

    print('main curvedNavigation indexCurvedNavigationBar: $indexMyCurvedNavigationBar');
    return CurvedNavigationBar(
      onTap: (index) {

        /*if (index == 1){
          pages[1].getState().refresh();
        }
        */
        //setState(() {
        //  pageIndex = index;
        //});
        print('main curvedNavigation Aici index: $index pageIndex: $pageIndex');

        /* //old IGV
        if(index == 2)
        {

          myIndexLocatii = 2;

        }
        else 
        {

          myIndexLocatii = 0;

        }
        */

        /*if (index == 1)
        {

          //MyController.jumpToPage(1);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              ProgramariScreen(fromLocatiiPage: false, fromOtherPage: false, currentIndex: 0, isSelectedTrecute:true, isSelectedViitoare: false,)), (Route<dynamic> route) => false);

        }
        */

        MyController.jumpToPage(index);
      },
      //key: _bottomNavigationKey, //old IGV
      key: myBottomNavigationKeyMain,
      animationDuration: const Duration(milliseconds: 400),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      buttonBackgroundColor: Colors.white,
      color: Colors.white,
      items: icons,
      height: 60,
      index: widget.fromPinPage? 4 : pageIndex,
    );
  }

  void loadDataCopii() async 
  {

    Shared.familie.clear();
    List<MembruFamilie> f = await apiCallFunctions.getListaFamilie();
    Shared.familie.addAll(f);
    print('Lista copii length este ${f.length}');

  }

  login(BuildContext context) async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final token = await FirebaseMessaging.instance.getToken() ?? '';

    /*
    if (pref_keys.userPassMD5.compareTo('userPassMD5') == 0)
    {
      print('User Email: ${pref_keys.userEmail}');
      /*Navigator.of(context)
          .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
      return;
      */
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }));
    }
    else {
    */
    
    //print('User Email- ${pref_keys.userEmail} user password - ${pref_keys.userPassMD5}');

    String? res = await apiCallFunctions.login(
        pAdresaEmail: prefs.getString(pref_keys.userEmail)!,
        pParolaMD5: prefs.getString(pref_keys.userPassMD5)!,
        pFirebaseGoogleDeviceID:
            prefs.getString(pref_keys.fcmToken) ?? "FCM Token not available in Shared Preferences");

    //print('Loading screen rezultat: $res');
    
    if (res == null) {
      
      return;
      
      // } else if (res.startsWith('161')) {
      //   showsnackbar(
      //     context,
      //     "Date de login varule!",
      //   );
      // return;

    }
    else if (res.startsWith('66')) 
    {
      
      Navigator.of(context)
          .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);

    }
    else if (res.startsWith('264')) {

      return;

    }
    else if (res.contains('\$#\$')) 
    {

    }
  }
}
