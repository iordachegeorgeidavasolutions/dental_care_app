import 'package:dental_care_app/pages/home.dart';
import 'package:dental_care_app/pages/locatii.dart';
import 'package:dental_care_app/pages/programari.dart';
import 'package:dental_care_app/pages/my_account_screen.dart';
import 'package:dental_care_app/pages/webview.dart';
import 'package:dental_care_app/utils/classes.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/items/meniu_grid_item.dart';
import '../widgets/modals/user_modal.dart';

class MeniuScreen extends StatefulWidget {
  MeniuScreen({super.key});

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
  'https://dentocare.ro/promotii/',
  'https://dentocare.ro/preturi/',
  'https://www.facebook.com',
  'https://dentocare.ro/informatii-utile/',
  'https://app.dentocare.ro'
  // more links
];

class _MeniuScreenState extends State<MeniuScreen> {
  final List items = [
    ["Oferte", "./assets/images/meniu/oferte.png"],
    ["Lista preturi", "./assets/images/meniu/listapreturi.png"],
    ["Locatii", "./assets/images/meniu/locatii.png"],
    ["Educatie", "./assets/images/meniu/educatie.png"],
    ["Contul meu", "./assets/images/meniu/contulmeu.png"],
  ];

  final List<Widget> _screens = [
    const Placeholder(),
    const HomePage(),
    const ProgramariScreen(),
    const LocatiiScreen(),
    const LocatiiScreen(),
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
                  index == 0
                      ? Navigator.push(context, MaterialPageRoute(builder: (context) => WebScreen(url: links[index])))
                      : index == 1
                          ? Navigator.push(
                              context, MaterialPageRoute(builder: (context) => WebScreen(url: links[index])))
                          : index == 2
                              ? MyController.jumpToPage(2)
                              : index == 3
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => WebScreen(url: links[index])),
                                    )
                                  : Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => UserProfileScreen()));
                },
                child: MeniuGridItem(nume: items[index][0], image: items[index][1]),
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
              userModal(context);
            },
            child: Image.asset('./assets/images/person-icon.jpg', height: 40)),
        const SizedBox(
          height: 20,
        ),
        const Text('Meniu', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
      ]),
    ],
  );
}
