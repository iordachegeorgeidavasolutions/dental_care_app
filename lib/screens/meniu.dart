import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:dental_care_app/screens/home.dart';
import 'package:dental_care_app/screens/locatii.dart';
import 'package:dental_care_app/screens/lista_programari_eu_copii.dart';
import 'package:dental_care_app/screens/programari.dart';
import 'package:dental_care_app/screens/my_account_screen.dart';
import 'package:dental_care_app/screens/webview.dart';
import 'package:dental_care_app/utils/classes.dart';
import 'package:dental_care_app/widgets/modals/user_modal_remade.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/items/meniu_grid_item.dart';
import '../widgets/modals/user_modal.dart';

class MeniuScreen extends StatefulWidget {

  final PageController myController;

  
  final GlobalKey myBottomNavigationKey;

  late Function(int num) myLocatiiCallback;

  //CurvedNavigationBar myCurvedNavigationBar;

  //int indexMyCurvedNavigationBar;

  //MeniuScreen({super.key, required this.myController, required this.indexMyCurvedNavigationBar});

  
  MeniuScreen({super.key, required this.myController, required this.myBottomNavigationKey, required this.myLocatiiCallback});

  @override
  State<MeniuScreen> createState() => _MeniuScreenState();
}

List<Function> meniuGridItemFunctions = [
  () {
    // behavior for item 0
  },
  () {
    // behavior for item 1
  },
  () {
    // behavior for item 2
  }, // add more functions as needed
];

List<String> links = [
  'https://app.dentocare.ro/oferte',
  'https://app.dentocare.ro/lista-preturi',
  'https://www.facebook.com',
  'https://app.dentocare.ro',
  'https://app.dentocare.ro/info',
  // more links
];

class _MeniuScreenState extends State<MeniuScreen> {
  final List items = [
    ["Oferte", "./assets/images/meniu/oferte.png"],
    ["Listă prețuri", "./assets/images/meniu/listapreturi.png"],
    ["Locații", "./assets/images/meniu/locatii.png"],
    ["Educație", "./assets/images/meniu/educatie.png"],
    ["Informații", "./assets/images/meniu/info.png"],
    //["Informații", ''],
    ["Contul meu", "./assets/images/meniu/contulmeu.png"],
  ];

  final List<Widget> _screens = [
    const Placeholder(),
    HomePage(myController: MyController, myBottomNavigationKey: myBottomNavigationKeyMain,),
    //const ListaProgramariEuCopii(),
    LocatiiScreen(),
    LocatiiScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(children: [
          logoTitle(context),
          GridView.builder(
            physics: const ScrollPhysics(),
            itemCount: items.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 20, childAspectRatio: (1 / .6)),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (index == 2)
                  {

                    indexMyCurvedNavigationBar = 2;
                    widget.myLocatiiCallback(2);
                    final CurvedNavigationBarState? navBarStateProgramari = myBottomNavigationKeyProgramari.currentState;
                    navBarStateProgramari?.setPage(2);
                    final CurvedNavigationBarState? navBarStateMain = myBottomNavigationKeyMain.currentState;
                    navBarStateMain?.setPage(2);
                    print('meniu curvedNavigationIndex $indexMyCurvedNavigationBar');

                  }
                  index == 0
                      ? Navigator.push(context, MaterialPageRoute(builder: (context) => WebScreen(url: links[index])))
                      : index == 1
                          ? Navigator.push(
                              context, MaterialPageRoute(builder: (context) => WebScreen(url: links[index])))
                          : index == 2
                              //? MyController.jumpToPage(2) //old Andrei Bădescu
                              ? widget.myController.jumpToPage(2)
                              : index == 3
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => WebScreen(url: links[index])),
                                    )
                              : index == 4
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => WebScreen(url: links[index])),
                                    )
                                  : 
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                    context: context,
                                    builder: (context) {
                                      return const UserModalRemade();
                                    }
                                  );
                                  /*Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => UserProfileScreen()));
                                  */    
                },
                child: MeniuGridItem(nume: items[index][0], image: items[index][1] ),
              );
            },
          )
        ]),
      ),
    );
  }
}

Row logoTitle(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                context: context,
                builder: (context) {
                  return const UserModalRemade();
                });
          },
          child: Image.asset('./assets/images/person-icon.jpg', height: 40)
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Meniu', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
      ]),
    ],
  );
}
