// ignore_for_file: avoid_print

import 'package:dental_care_app/data/programari_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../utils/api_call.dart';
import '../utils/classes.dart';
import '../widgets/modals/programari_modal.dart';
import '../widgets/modals/user_modal.dart';
import '../utils/api_call_functions.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;

class ProgramariScreen extends StatefulWidget {
  const ProgramariScreen({super.key});

  @override
  State<ProgramariScreen> createState() => _ProgramariScreenState();
}

class _ProgramariScreenState extends State<ProgramariScreen> {
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  Future<Programari?>? getProgramari;
  bool isSelected = true;
  int initialLabelIndex = 0;
  var _selectedIndex = 0;
  List<Programare> viitoare = <Programare>[];
  List<Programare> trecute = <Programare>[];
  ApiCall apiCall = ApiCall();

  @override
  void initState() {
    super.initState();
    getProgramari = getListaProgramari();
  }

  Future<Programari?> getListaProgramari() async {
    viitoare.clear();
    trecute.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String idUser = prefs.getString(pref_keys.userIdInregistrare)!;
    final Map<String, String> param = {
      'pCheie': 'uniqueID',
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pIdLimba': '0',
    };

    String? res = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaProgramarileLui', pParametrii: param);

    List<Programare> programariViitoare = <Programare>[];
    List<Programare> programariTrecute = <Programare>[];

    if (res == null) {
      // errorInfo = l.universalEroare;
      // infoWidget = InfoWidget.error;
      print("Eroare null");
      return null;
    }
    if (res.startsWith('13\$#\$')) {
      print("success");
    }
    if (res.startsWith('66\$#\$')) {
      print("dategresite");
    }

    if (res.startsWith('132\$#\$')) {
      print("register error");
    }

    if (res.contains('%\$%')) {
      List<String> list = res.split('%\$%');
      List<String> viitoare = list[0].split('*\$*');
      List<String> trecute = list[1].split('*\$*');
      viitoare.removeWhere((element) => element.isEmpty);
      trecute.removeWhere((element) => element.isEmpty);

      for (var element in viitoare) {
        List<String> l = element.split('\$#\$');

        DateTime date = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[0].substring(8, 10)),
          int.parse(l[0].substring(10, 12)),
        );
        DateTime dateSf = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[1].substring(0, 2)),
          int.parse(l[1].substring(3, 5)),
        );

//TODO verif
        Programare p = Programare(
            nume: '',
            prenume: '',
            idPacient: '',
            medic: l[2],
            categorie: l[3],
            status: l[4],
            anulata: l[5] == '1',
            inceput: date,
            sfarsit: dateSf,
            id: l[6]);
        programariViitoare.add(p);
      }

      for (var element in trecute) {
        List<String> l = element.split('\$#\$');
//data inceput, ora final, identitate medic, categorie, status programare, 0/1 (este sau nu anulata)
        DateTime date = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[0].substring(8, 10)),
          int.parse(l[0].substring(10, 12)),
        );
        DateTime dateSf = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[1].substring(0, 2)),
          int.parse(l[1].substring(3, 5)),
        );
//TODO verif
        Programare p = Programare(
            nume: '',
            prenume: '',
            idPacient: '',
            id: '',
            medic: l[2],
            categorie: l[3],
            status: l[4],
            anulata: l[5] == '1',
            inceput: date,
            sfarsit: dateSf);
        programariTrecute.add(p);
      }
    }
    programariTrecute.sort((a, b) => b.inceput.compareTo(a.inceput));
    programariViitoare.sort((a, b) => a.inceput.compareTo(b.inceput));
    Programari? pP = Programari(trecute: programariTrecute, viitoare: programariViitoare);
    viitoare.addAll(pP.viitoare);
    trecute.addAll(pP.trecute);
    return pP;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(leading: Icon(icon)),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  switchWidget(),
                ],
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                  future: getProgramari,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return isSelected ? viitoareList() : istoricList();
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Padding viitoareList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: viitoare.length,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ListTile(
                leading: Icon(Icons.circle,
                    color: programariList[index].state == "undetermined"
                        ? Colors.red
                        : programariList[index].state == "cancelled"
                            ? Colors.green
                            : programariList[index].state == "confirmed"
                                ? Colors.yellow
                                : Colors.grey),
                title: Text(
                  // viitoare[index].nume,
                  "samly",
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black87),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding istoricList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: trecute.length,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return ProgramariModal(selectedIndex: _selectedIndex);
                      });
                },
                child: ListTile(
                  leading: Image.asset('./assets/images/programari.png', height: 25),
                  title: Text(
                    DateFormat('EEEE, d.M.yyyy').format(trecute[index].inceput),
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black87),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row switchWidget() {
    return Row(
      children: [
        ToggleSwitch(
          initialLabelIndex: initialLabelIndex,
          minWidth: 110,
          activeBgColor: const [Colors.red],
          inactiveBgColor: Colors.white,
          totalSwitches: 2,
          labels: const ['Istoric', 'Viitor'],
          dividerColor: Colors.black,
          onToggle: (index) {
            setState(() {
              initialLabelIndex = index!;
              isSelected = !isSelected;
            });
          },
        ),
      ],
    );
  }

  Row logotitle(BuildContext context) {
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
          const Text('Programari', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
        ]),
      ],
    );
  }
}
