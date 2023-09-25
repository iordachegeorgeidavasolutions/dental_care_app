import 'package:dental_care_app/screens/create_appointment.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/my_account_screen.dart';
import '../../utils/shared_pref_keys.dart' as pref_keys;
import '../../main.dart';
import '../../screens/login.dart';
import '../../screens/programari.dart';
import '../../screens/tratamente.dart';
import '../../utils/functions.dart';
import '../items/profile_modal_item.dart';

class UserModalRemade extends StatefulWidget {
  const UserModalRemade({super.key});

  @override
  State<UserModalRemade> createState() => _UserModalRemadeState();
}

class _UserModalRemadeState extends State<UserModalRemade> {
  List<String>? getNumePrenumeFuture;

  final List profileItemsList = [
    ["Profilul meu", "./assets/images/profile_modal_images/person-icon.jpg", CreateAppointmentScreen()],
    ["Programari", "./assets/images/profile_modal_images/programari.png", const ProgramariScreen()],
    ["Istoric tratamente", "./assets/images/profile_modal_images/syringe.png", const TratamenteScreen()],
    // ["Sold curent", "./assets/images/profile_modal_images/soldcurent.png"],
    ["Iesi din cont", "./assets/images/profile_modal_images/exiticon.png"],
  ];

  void asd() async {
    var userName = await getUserName();
    setState(() {
      getNumePrenumeFuture = userName;
    });
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(pref_keys.loggedIn, false);
  }

  @override
  void initState() {
    super.initState();
    asd();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
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
                Expanded(
                    flex: 3,
                    child: getNumePrenumeFuture == null
                        ? const Text("Unable to retrieve text")
                        : Text(
                            '${getNumePrenumeFuture![0]} ${getNumePrenumeFuture![1]}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      index == 3
                          ? {
                              logout(),
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => LoginPage()), (route) => false)
                            }
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
          SizedBox(height: 10),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('./assets/images/logo-dentocare.png', height: 22),
            ],
          )),
        ]),
      ),
    );
  }
}
