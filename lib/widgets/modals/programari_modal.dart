import 'package:flutter/material.dart';
import '../../utils/classes.dart';
import '../items/program_modal_item.dart';
import '../../screens/programari.dart';
import '../../main.dart';
import 'package:dental_care_app/screens/home.dart';

class ProgramariModal extends StatelessWidget {
  final String total;
  final Programare? programare;
  final bool fromHome;

  final Function(Programare) callbackStatusProgramare;

  const ProgramariModal({super.key, required this.programare, required this.total, required this.callbackStatusProgramare, required this.fromHome});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_outlined),
                    color: Colors.red,
                    onPressed: () => 
                    {
                      if (fromHome)
                      {
                        
                        //MyController.jumpToPage(0),
                        Navigator.of(context)
                          .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp(fromPinPage: false,)), (route) => false),
                          if (MyController.page == 0) {
                            MyController
                                .nextPage(
                                    duration: const Duration(milliseconds: 40), curve: Curves.easeIn)
                                .whenComplete(() => MyController.previousPage(
                                    duration: const Duration(milliseconds: 1), curve: Curves.easeIn)),
                          } else {
                            MyController
                                .previousPage(
                                    duration: const Duration(milliseconds: 40), curve: Curves.easeIn)
                                .whenComplete(() => MyController.nextPage(
                                    duration: const Duration(milliseconds: 1), curve: Curves.easeIn)),
                          }
                      }
                      else 
                      {

                        Navigator.pop(context), //old Andrei Bădescu

                      }
                    }  
                    //onPressed: () => Navigator.of(context)
                    //  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ProgramariScreen()), (route) => false)
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  //onTap: () => Navigator.of(context)
                  //    .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ProgramariScreen()), (route) => false),
                  child: const Text(
                    "Înapoi",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.red),
                  ),
                )
              ]),
              const SizedBox(height: 15),
              Column(
                children: [
                  const SizedBox(height: 20),
                  ProgramModalItem(
                    total: total,
                    programare: programare,
                    callbackStatusProgramare: callbackStatusProgramare,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
