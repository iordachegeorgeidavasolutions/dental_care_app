import 'package:dental_care_app/data/home_dosarulmeu_data.dart';
import 'package:dental_care_app/main.dart';
import 'package:dental_care_app/screens/webview.dart';
import 'package:dental_care_app/widgets/items/dosarulMeu_item.dart';
import 'package:dental_care_app/widgets/items/home_buttonNoUpcomingAppointments.dart';
import 'package:dental_care_app/widgets/items/servicii_grid_item.dart';
import 'package:dental_care_app/widgets/modals/programari_modal.dart';
import 'package:dental_care_app/widgets/modals/user_modal_remade.dart';
import 'package:flutter/material.dart';
import '../utils/api_call_functions.dart';
import '../utils/classes.dart';
import '../widgets/items/home_butonUrmatoareProgramare.dart';
import '../utils/functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  bool isVisible = true;
  Future<List<String?>>? getNumePrenumeFuture;
  Programare? ultimaProgramare;
  Future<Programare?>? programareFinala;
  final List serviciiItems = [
    [
      "Implanotologie",
      "./assets/images/homescreen_servicii/implantologie.png",
      "https://app.dentocare.ro/servicii/implantologie/",
    ],
    [
      "Ortodontie",
      "./assets/images/homescreen_servicii/ortodontie.png",
      "https://app.dentocare.ro/servicii/ortodontie/"
    ],
    ["Protetica", "./assets/images/homescreen_servicii/protetica.png", "https://app.dentocare.ro/servicii/protetica/"],
    ["Preventie", "./assets/images/homescreen_servicii/preventie.png", "https://app.dentocare.ro/servicii/preventie/"],
  ];

  // void loadUltimaProgramare() async {
  //   var ultimaProgramare1 = await loadData();
  //   setState(() {
  //     ultimaProgramare = ultimaProgramare1;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // loadUltimaProgramare();
    programareFinala = loadData();
    getNumePrenumeFuture = getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          welcomeWidget(context),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                color: Color.fromARGB(255, 236, 236, 236)),
            child: Column(children: [
              FutureBuilder(
                future: programareFinala,
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  // ignore: avoid_print
                  print(data);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Visibility(
                        visible: isVisible,
                        child: GestureDetector(
                            onTap: data == null
                                ? null
                                : () {
                                    apiCallFunctions.getDetaliiProgramare(snapshot.data!.id).then((value) {
                                      showModalBottomSheet(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return snapshot.data == null
                                              ? Container()
                                              : ProgramariModal(
                                                  programare: snapshot.data!,
                                                  total: value!,
                                                );
                                        },
                                      );
                                    });
                                  },
                            child: snapshot.data == null
                                ? const Center(child: Text(''))
                                : ButonUrmatoareaProgramare(
                                    numeZiUltimaProg: data!.inceput, oraInceputUltimaProg: data.inceput)));
                  } else
                    return Container();
                },
              ),
              Visibility(visible: !isVisible, child: const ButtonNoUpcomingAppointments()),
              SizedBox(height: 20),
              // dosarulMeu(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(children: [
                  Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Dosarul meu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Container(
                          width: 150,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: dosarulMeuList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                // onTap: () => MyController.jumpToPage(1),
                                onTap: () {
                                  if (index == 0) {
                                    MyController.jumpToPage(1);
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => dosarulMeuList[index].widgetRoute));
                                  }
                                },
                                child: DosarulMeuItem(
                                  titlu: dosarulMeuList[index].titlu,
                                  widgetRoute: dosarulMeuList[index].widgetRoute,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      './assets/images/dentist.png',
                      height: 130,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  )
                ]),
              ),
              SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  children: [
                    Text('Servicii', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              serviciiWidget(),
              const SizedBox(height: 20),
            ]),
          ),
        ]),
      ),
    );
  }

  GridView serviciiWidget() {
    return GridView.builder(
      physics: const ScrollPhysics(),
      itemCount: serviciiItems.length,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WebScreen(url: serviciiItems[index][2])));
          },
          child: ServiciuItem(nume: serviciiItems[index][0], image: serviciiItems[index][1]),
        );
      },
    );
  }

  Padding dosarulMeu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 170,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Dosarul meu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Container(
                      width: 150,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dosarulMeuList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            // onTap: () => MyController.jumpToPage(1),
                            onTap: () {
                              if (index == 0) {
                                MyController.jumpToPage(1);
                              } else {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => dosarulMeuList[index].widgetRoute));
                              }
                            },
                            child: DosarulMeuItem(
                              titlu: dosarulMeuList[index].titlu,
                              widgetRoute: dosarulMeuList[index].widgetRoute,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    './assets/images/dentist.png',
                    height: 130,
                    color: Colors.black.withOpacity(0.4),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  welcomeWidget(BuildContext context) {
    return FutureBuilder(
      future: getNumePrenumeFuture,
      builder: (context, snapshot) {
        var data = snapshot.data;
        // ignore: avoid_print
        print(data);
        if (data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      child: Image.asset('./assets/images/person-icon.jpg', height: 40)),
                  const SizedBox(height: 20),
                  const Text('Bine ai venit,', style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold)),
                  data.isEmpty
                      ? const Text("Data not found")
                      : Text(
                          '${data[0]} ${data[1]}',
                          style: const TextStyle(fontSize: 26),
                        )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<List<String?>>? getUserName() async {
  //   List<String?>? user = [];
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var nume = prefs.getString(pref_keys.userNume);
  //   var prenume = prefs.getString(pref_keys.userPrenume);
  //   nume ??= "undefined";
  //   prenume ??= "undefined";
  //   user.add(nume);
  //   user.add(prenume);
  //   // print(user);
  //   return user;
  // }

  Future<Programare?> loadData() async {
    Programari? programari = await apiCallFunctions.getListaProgramari();
    if (programari == null) {
      // TODO: show error message, nu ai NET/nu merge API-ul
      setState(() {
        isVisible = false;
      });
      return null;
    }
    // programari.viitoare = programari.trecute;
    if (programari.viitoare.isEmpty) {
      // TODO: show error message, nu ai programari viitoare
      setState(() {
        isVisible = false;
      });
      return null;
    }
    // Programare? ultimaProgramareP = programari.viitoare.reversed.elementAt(programari.viitoare.length - 1);
    List<Programare> programariReversed = programari.viitoare.toList();
    Programare? ultimaProgramareCorecta;
    List<Programare> programariReversedFiltrat = [];
    for (var programare in programariReversed) {
      if (!programare.status.startsWith('Anulat')) {
        programariReversedFiltrat.add(programare);
      }
    }
    if (programariReversedFiltrat.isEmpty) {
      print("Lista programari ${programariReversedFiltrat}");
      setState(() {
        isVisible = false;
      });
      return null;
    } else {
      ultimaProgramareCorecta = programariReversedFiltrat.elementAt(0);
      print('s-a ajuns aici');
      print(isVisible);
      return ultimaProgramareCorecta;
    }
  }

  // Container urmatoareaProgramareWidget() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 20),
  //     height: 100,
  //     decoration: const BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(10)), color: Color.fromARGB(255, 243, 68, 68)),
  //     child: const Row(
  //       children: [
  //         Expanded(
  //           flex: 5,
  //           child: Padding(
  //             padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Icon(Icons.calendar_month_outlined, color: Colors.white, size: 30),
  //                     SizedBox(width: 8),
  //                     Text('Sambata, 16.02.2023',
  //                         style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
  //                   ],
  //                 ),
  //                 SizedBox(height: 15),
  //                 Row(children: [
  //                   Icon(
  //                     Icons.access_time_rounded,
  //                     color: Colors.white,
  //                     size: 30,
  //                   ),
  //                   SizedBox(width: 8),
  //                   Text(
  //                     '18:30',
  //                     style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
  //                   )
  //                 ])
  //               ],
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 Icons.arrow_forward_ios,
  //                 size: 50,
  //                 color: Colors.white,
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
