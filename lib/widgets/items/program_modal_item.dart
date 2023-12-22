// ignore_for_file: sized_box_for_whitespace
import 'package:dental_care_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/classes.dart';
import '../../utils/api_call_functions.dart';

class ProgramModalItem extends StatefulWidget {
  final String total;
  final Programare? programare;

  final Function(Programare) callbackStatusProgramare;

  ProgramModalItem({super.key, required this.programare, required this.total, required this.callbackStatusProgramare});
  

  @override
  State<ProgramModalItem> createState() => _ProgramModalItemState();
}

class _ProgramModalItemState extends State<ProgramModalItem> {
  late String status = widget.programare!.status;
  late String anulatDinApi = widget.programare!.anulata;
  DateTime currentDate = DateTime.now();
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  bool get confirmabil => PoateFiConfirmata();
  bool get anulabil => PoateFiAnulata();

  bool programareAnulata = false;

// TODO: Ideea e asa: Vor sa poti anula oricand si sa poti confirma doar daca mai sunt 24H sau mai putin, dup care sunt greyed out.
// Daca este in trecut, nici nu ar trebui sa ai butoanele tbh

  bool PoateFiConfirmata() {
    //print('Început programare: ${widget.programare!.inceput}');
    if (widget.programare!.status == Programare.statusConfirmat) return false;
    // if (widget.programare!.inceput.difference(dateNow).inDays > 1) return false;
    if (widget.programare!.inceput.difference(DateTime.now()).inDays > 2) 
    {
      return false;
    }  
    if (widget.programare!.inceput.isBefore(DateTime.now())) return false;
    if (anulatDinApi == "1") return false;


    return true;
  }

  bool PoateFiAnulata() {
    if (widget.programare!.status == Programare.statusAnulat) return false;
    if (anulatDinApi == "1") return false;
    if (widget.programare!.status == Programare.statusConfirmat) return false;
    if (widget.programare!.inceput.isBefore(DateTime.now())) return false;
    // if (widget.programare!.inceput.difference(DateTime.now()).inDays > 1) return false;
    if (DateTime.now().difference(widget.programare!.inceput).inDays > 1) return true;

    return true;
  }

  // void impodobesteMamaBradul() {
  //   status == "Confirmat" ? isVisible = false : isVisible = true;
  // }

  // void disableButtonsIfBefore() {
  //   print("DateTime programare: ${widget.programare!.inceput}");
  //   widget.programare!.inceput.isBefore(currentDate)
  //       ? setState(() {
  //           isVisible = false;
  //         })
  //       : setState(
  //           () {
  //             isVisible = true;
  //           },
  //         );
  // }

  // void hideButtons() {
  //   setState(() {
  //     isVisible = !isVisible;
  //   });
  // }

  // void disableButtonsAfterClick() {
  //   setState(() {
  //     isDisabled = !isDisabled;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    setState(() {

      status = widget.programare!.status;
      status == 'Anulat'? programareAnulata = true: programareAnulata = false;

    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.programare == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.only(right: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           width: 100,
                //           // width: MediaQuery.of(context).size.width * 0.3,
                //           child: const Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 "Data:",
                //                 style: TextStyle(fontSize: 18),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Container(
                //           // padding: EdgeInsets.only(right: 70),
                //           // width: MediaQuery.of(context).size.width * 0.5,
                //           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                //             Text(
                //                 DateFormat('EEEE, d.M.yyyy', 'ro').format(widget.programare!.inceput).capitalizeFirst(),
                //                 maxLines: 9,
                //                 overflow: TextOverflow.ellipsis,
                //                 style: const TextStyle(fontSize: 18)),
                //           ]),
                //         ),
                //       ],
                //     ),
                //     const Divider(color: Colors.black12, thickness: 2),
                //     const SizedBox(height: 20),
                //   ],
                // ),
                // Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           width: 100,
                //           // width: MediaQuery.of(context).size.width * 0.3,
                //           child: const Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 "Ora:",
                //                 style: TextStyle(fontSize: 18),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Container(
                //           width: MediaQuery.of(context).size.width * 0.5,
                //           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                //             Text(DateFormat.jm().format(widget.programare!.inceput),
                //                 maxLines: 9, style: const TextStyle(fontSize: 18)),
                //           ]),
                //         ),
                //       ],
                //     ),
                //     const Divider(color: Colors.black12, thickness: 2),
                //     const SizedBox(height: 20),
                //   ],
                // ),

                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dată:",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // padding: EdgeInsets.only(right: 70),
                          // width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(
                                DateFormat('EEEE, d.M.yyyy', 'ro').format(widget.programare!.inceput).capitalizeFirst(),
                                maxLines: 9,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18)),
                          ]),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.black12, thickness: 2),
                    const SizedBox(height: 20),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Oră:",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(DateFormat.jm().format(widget.programare!.inceput),
                                maxLines: 9, style: const TextStyle(fontSize: 18)),
                          ]),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.black12, thickness: 2),
                    const SizedBox(height: 20),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Locație:",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("DentoCare", maxLines: 9, style: const TextStyle(fontSize: 18)),
                          ]),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.black12, thickness: 2),
                    const SizedBox(height: 20),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status:",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(widget.programare!.status, maxLines: 9, style: const TextStyle(fontSize: 18)),
                          ]),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.black12, thickness: 2),
                    const SizedBox(height: 20),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Financiar:",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("${widget.total} RON", maxLines: 9, style: const TextStyle(fontSize: 18)),
                          ]),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.black12, thickness: 2),
                    const SizedBox(height: 20),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Doctor:",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(widget.programare!.medic, maxLines: 9, style: const TextStyle(fontSize: 18)),
                          ]),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.black12, thickness: 2),
                    const SizedBox(height: 30),
                    Visibility(
                      visible: confirmabil || anulabil,
                      child: Column(
                        children: [
                          programareAnulata == false ? 
                          ElevatedButton( //IGV confirmă programarea
                            style: !confirmabil
                                ? ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(40, 15, 40, 15), 
                                    backgroundColor: Colors.grey,
                                    foregroundColor: Colors.red,
                                    minimumSize: const Size.fromHeight(40),
                                    
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // <-- Radius
                                    ),
                                  )
                                : 
                                /*
                                ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                                    backgroundColor: Colors.red,
                                    // minimumSize: const Size.fromHeight(50), // NEW
                                  ),
                                */
                                ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // <-- Radius
                                  ), // NEW
                                ),
                            child: const Text(
                              'Confirmă programarea',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              
                              !confirmabil
                                  ? 
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context).size.height * 0.7,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 40),
                                                const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                  Text(
                                                    "Puteți confirma programările cu maxim 48h înainte",
                                                    maxLines: 4,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 18))
                                                ]),
                                                const SizedBox(height: 20),
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center, 
                                                  children: [
                                                  Text("Vă mulțumim!", style: TextStyle(fontSize: 18)),
                                                ]),
                                                const SizedBox(height: 60),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    foregroundColor: Colors.white,
                                                    minimumSize: const Size.fromHeight(50),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10), // <-- Radius
                                                    ), // NEW
                                                  ),
                                                  onPressed: () => {
                                                    print(widget.programare!.id),
                                                    //apiCallFunctions.confirmaProgramarea(widget.programare!.id),
                                                    Navigator.pop(context),
                                                  },
                                                  child: const Text(
                                                    'Am înțeles',
                                                    style: TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : showModalBottomSheet(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context).size.height * 0.7,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 40),
                                                const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                  Text("Confirmare",
                                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                                ]),
                                                const SizedBox(height: 20),
                                                const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                  Text(
                                                      "Prin apăsarea butonului 'Confirm', confirmați că veți ajunge la programarea stabilită.",
                                                      maxLines: 4,
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 16))
                                                ]),
                                                const SizedBox(height: 20),
                                                const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                  Text("Vă mulțumim!", style: TextStyle(fontSize: 18)),
                                                ]),
                                                const SizedBox(height: 60),
                                                IntrinsicWidth(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      ElevatedButton(
                                                        child: const Text(
                                                          'Confirm',
                                                          style: TextStyle(fontSize: 24),
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                                          backgroundColor: Colors.red,
                                                          foregroundColor: Colors.white,
                                                          minimumSize: const Size.fromHeight(50),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10), // <-- Radius
                                                          ),
                                                        ),
                                                        onPressed: () => {
                                                          print(widget.programare!.id),
                                                          //apiCallFunctions.confirmaProgramarea(widget.programare!.id),


                                                          setState(() {
                                                            
                                                            widget.programare!.status = Programare.statusConfirmat;
                                                            widget.callbackStatusProgramare(widget.programare!);
                                                            print(context);
                                                            print(PoateFiConfirmata().toString());
                                                            print(widget.programare!.status);
                                                          }),
                                                          Navigator.pop(context),
                                                        },
                                                      ),
                                                      const SizedBox(height: 30),
                                                      ElevatedButton(
                                                        style:
                                                        ElevatedButton.styleFrom(
                                                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                                          backgroundColor: Colors.white,
                                                          foregroundColor: Colors.red,
                                                          minimumSize: const Size.fromHeight(50),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10), // <-- Radius
                                                          ),
                                                        ),
                                                        onPressed: () => Navigator.pop(context),
                                                        child: const Text(
                                                          'Nu confirm',
                                                          style: TextStyle(fontSize: 24, color: Colors.red),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            },
                          ): 
                          SizedBox(),
                          programareAnulata == false ? const SizedBox(height: 10) : const SizedBox(),
                          programareAnulata == false ? 
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 236, 236, 236),
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // <-- Radius
                              ), // NEW
                            ),
                            child: const Text(
                              'Anulează programarea',
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                            onPressed: () {
                              !anulabil
                                  ? null
                                  : showModalBottomSheet(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context).size.height * 0.7,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 40),
                                                const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                  Text("Atenție!",
                                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                                ]),
                                                const SizedBox(height: 20),
                                                const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                  Text(
                                                      "Doriți anularea programării. Trebuie avut în vedere faptul că timpul și locurile sunt limitate și astfel este posibil să nu gasiți un interval orar disponibil în perioada imediat următoare.",
                                                      maxLines: 5,
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 15))
                                                ]),
                                                const SizedBox(height: 60),
                                                IntrinsicWidth(
                                                  child: Column(
                                                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      ElevatedButton(
                                                        style: 
                                                        /*ElevatedButton.styleFrom(
                                                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                                          backgroundColor: Colors.red,
                                                          // minimumSize: const Size.fromHeight(50), // NEW
                                                        ),*/ //old Andrei Bădescu
                                                        ElevatedButton.styleFrom(
                                                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                                          backgroundColor: Colors.red,
                                                          foregroundColor: Colors.white,
                                                          minimumSize: const Size.fromHeight(50),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10), // <-- Radius
                                                          ),
                                                        ),  
                                                        onPressed: () => {
                                                          print(widget.programare!.id),
                                                          apiCallFunctions.anuleazaProgramarea(widget.programare!.id),
                                                          setState(() {
                                                            programareAnulata = true;
                                                            widget.programare!.status = Programare.statusAnulat;
                                                            widget.callbackStatusProgramare(widget.programare!);
                                                          }),
                                                          // hideButtons(),
                                                          Navigator.pop(context),
                                                        },
                                                        child: const Text(
                                                          'Anulez',
                                                          style: TextStyle(fontSize: 24),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 30),
                                                      ElevatedButton(
                                                        style: 
                                                        /*OutlinedButton.styleFrom(
                                                          side: const BorderSide(color: Colors.red, width: 1),
                                                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                                          backgroundColor: Colors.white,
                                                          // minimumSize: const Size.fromHeight(50), // NEW
                                                        ),
                                                        */
                                                        ElevatedButton.styleFrom(
                                                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                                          backgroundColor: Colors.white,
                                                          foregroundColor: Colors.red,
                                                          minimumSize: const Size.fromHeight(50),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10), // <-- Radius
                                                          ),
                                                        ),
                                                        onPressed: () => {
                                                          Navigator.pop(context),
                                                        },
                                                        child: const Text(
                                                          'Nu anulez',
                                                          style: TextStyle(fontSize: 24, color: Colors.red),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            },
                          ): 
                          SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
