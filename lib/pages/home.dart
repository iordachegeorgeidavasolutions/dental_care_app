import 'package:dental_care_app/data/home_dosarulmeu_data.dart';
import 'package:dental_care_app/data/programari_data.dart';
import 'package:dental_care_app/pages/webview.dart';
import 'package:dental_care_app/widgets/items/dosarulMeu_item.dart';
import 'package:dental_care_app/widgets/items/servicii_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/items/home_butonUrmatoareProgramare.dart';
import '../widgets/modals/user_modal.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<List<String>>? getNumePrenumeFuture;

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
  @override
  void initState() {
    super.initState();
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
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 20, 10),
                child: Row(children: [
                  Text('Urmatoarea programare : ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
                ]),
              ),
              ButonUrmatoareaProgramare(
                ora: programariList[programariList.length - 1].ora,
                data: programariList[programariList.length - 1].data,
              ),
              dosarulMeu(context),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  children: [
                    Text('Servicii', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 10, 0),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Dosarul meu',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dosarulMeuList.length,
                        itemBuilder: (context, index) {
                          return DosarulMeuItem(
                            titlu: dosarulMeuList[index].titlu,
                            widgetRoute: dosarulMeuList[index].widgetRoute,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset('./assets/images/dentist.png', height: 130, color: Colors.black.withOpacity(0.4))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container urmatoareaProgramareWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)), color: Color.fromARGB(255, 243, 68, 68)),
      child: const Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined, color: Colors.white, size: 30),
                      SizedBox(width: 8),
                      Text('Sambata, 16.02.2023',
                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '18:30',
                      style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ])
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  size: 50,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  welcomeWidget(BuildContext context) {
    return FutureBuilder(
      future: getNumePrenumeFuture,
      builder: (context, snapshot) {
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
                        userModal(context);
                      },
                      child: Image.asset('./assets/images/person-icon.jpg', height: 40)),
                  const SizedBox(height: 20),
                  const Text('Bine ai venit,', style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold)),
                  Text(
                    '${snapshot.data![0]} ${snapshot.data![1]}',
                    style: const TextStyle(fontSize: 26),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<String>> getUserName() async {
    List<String> dateUser = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nume = prefs.getString(pref_keys.userNume);
    var prenume = prefs.getString(pref_keys.userPrenume);
    dateUser.add(nume ?? "");
    dateUser.add(prenume ?? "");
    return dateUser;
  }
}
