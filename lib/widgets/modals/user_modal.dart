import 'package:dental_care_app/screens/lista_programari_eu_copii.dart';
import 'package:dental_care_app/screens/lista_tratamente_eu_copii.dart';
import 'package:dental_care_app/screens/login.dart';
import 'package:dental_care_app/screens/tratamente.dart';
import "package:flutter/material.dart";
import '../../main.dart';
import '../../screens/home.dart';
import '../../screens/programari.dart';
import '../items/profile_modal_item.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';

Future<dynamic> userModal(BuildContext context) {
  final List profileItemsList = [
    ["Profilul meu", "./assets/images/profile_modal_images/person-icon.jpg", HomePage(myController: MyController, myBottomNavigationKey: myBottomNavigationKeyMain,)],
    //["Programari", "./assets/images/profile_modal_images/programari.png", const ProgramariScreen()], //old Andrei Bădescu
    ["Programari", "./assets/images/profile_modal_images/programari.png", ProgramariScreen(fromLocatiiPage: false, fromOtherPage: true, currentIndex: 0, isSelectedTrecute: true, isSelectedViitoare: false,)],
    //["Programari", "./assets/images/profile_modal_images/programari.png", const ListaProgramariEuCopii()],
    //["Programari", "./assets/images/profile_modal_images/programari.png", const ProgramariScreen(idCopil: '-1')], //old George Valentin Iordache
    //["Tratamente", "./assets/images/profile_modal_images/syringe.png", const ListaTratamenteEuCopii()],
    ["Tratamente", "./assets/images/profile_modal_images/syringe.png", const TratamenteScreen()],
    // ["Sold curent", "./assets/images/profile_modal_images/soldcurent.png"],
    ["Iesi din cont", "./assets/images/profile_modal_images/exiticon.png"],
  ];

  return showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.86,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 236, 236, 236),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: Image.asset('./assets/images/person-icon.jpg', height: 60)),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                      flex: 3,
                      child: Text(
                        ' Stefan Elefterescu',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              itemCount: profileItemsList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      child: ProfileModalItem(icon: profileItemsList[index][1], text: profileItemsList[index][0]),
                      onTap: () {
                        if (index == 1)
                        {

                          final CurvedNavigationBarState? navBarStateProgramari = myBottomNavigationKeyProgramari.currentState;
                          navBarStateProgramari?.setPage(1);
                          final CurvedNavigationBarState? navBarStateMain = myBottomNavigationKeyMain.currentState;
                          navBarStateMain?.setPage(1);
                          print('user modal curvedNavigationIndex $indexMyCurvedNavigationBar');
                          //Navigator.of(context).pushAndRemoveUntil(
                          //    MaterialPageRoute(builder: (context) => dosarulMeuList[index].widgetRoute));

                          //Navigator.of(context).push(
                          //  MaterialPageRoute(builder: (context) => ProgramariScreen(fromOtherPage: false, currentIndex: 0, isSelectedTrecute: true, isSelectedViitoare: false,)));

                        }
                        index == 3
                            ? Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => LoginPage()), (route) => false)
                            : index == 1
                                ? {
                                  
                                    MyController.jumpToPage(1),
                                    Navigator.pop(context),
                                  }
                                : Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => profileItemsList[index][2]));
                      },
                    ),
                  ],
                );
              },
            ),
          ]),
        ),
      );
    },
  );
}
