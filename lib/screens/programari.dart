// ignore_for_file: avoid_print
import 'package:dental_care_app/screens/create_appointment.dart';
import 'package:dental_care_app/utils/functions.dart';
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

  const ProgramariScreen({super.key,});

  @override
  State<ProgramariScreen> createState() => _ProgramariScreenState();
}

class _ProgramariScreenState extends State<ProgramariScreen> {
  
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  Future<Programari?>? programari;
  Future<Programari?>? programariCopil;
  bool isSelectedTrecute = true;
  bool isSelectedViitoare = false;
  int initialLabelIndex = 0;
  var _selectedIndex = 0;
  List<Programare> viitoare = <Programare>[];
  List<Programare> trecute = <Programare>[];
  List<Programare> viitoareCopil = <Programare>[];
  List<Programare> trecuteCopil = <Programare>[];
  ApiCall apiCall = ApiCall();

  String idCopil = '-1';

  String? userNume = '';
  String? userPrenume = '';
  String? userIdPacientAsociat = '';

  static List<MembruFamilie> listaInitialaMembri = <MembruFamilie>[MembruFamilie(id: '-1', nume: 'Progrămarile', prenume: ' mele')];

  MembruFamilie? _selectedMembru;

  bool afiseazaDropDownFamilie = Shared.familie.length > 0? true : false;

/*
  int currentIndexprogramariToggle = 0;
  int currentIndexprogramariCopilToggle = 0;
  int currentIndexprogramarileTaleToggle = 0;
  bool programariCopilToggle = false;
  bool programarileTaleToggle = false;
  bool programariToggle = true; //old
  bool programariUserCompleteToggle = false;
  bool programariUserViitoareToggle = false;
  bool programariCopilCompleteToggle = false;
  bool programariCopilViitoareToggle = false;
*/

  bool areCopii = false;

  void loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userNume = prefs.getString(pref_keys.userNume);
      userPrenume = prefs.getString(pref_keys.userPrenume);
      userIdPacientAsociat = prefs.getString(pref_keys.userIdPacientAsociat);
    });
  }

  Future refresh() async {
    setState(() {
      if (idCopil == '-1')
      {
        programari = getListaProgramari();
      }
      else {
        areCopii = true; 
        programariCopil = getListaProgramariCopil();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    
    setState(() {

      loadUserData();
      isSelectedTrecute = true;
      isSelectedViitoare = false;
      //listaInitialaMembri = [MembruFamilie(id: '-1', nume: userNume!, prenume: userPrenume!), ...listaInitialaMembri];
      listaInitialaMembri = <MembruFamilie>[MembruFamilie(id: '-1', nume: 'Progrămarile', prenume: ' mele')];
      listaInitialaMembri.addAll(Shared.familie);

    });

    print('Lista initială membri: ${listaInitialaMembri.length} ');

    //programari = getListaProgramari();
    if (idCopil == '-1')
    {

      programari = getListaProgramari();

    }
    else 
    {

      areCopii = true;  
      programariCopil = getListaProgramariCopil();

    }

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      // appBar: AppBar(leading: Icon(icon)),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: RefreshIndicator(
        onRefresh: () async {
          await refresh();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    switchWidget(),
                  ],
                ),
                afiseazaDropDownFamilie?
                DropdownButton(
                  hint: Text('Alege un membru al familiei'), // Not necessary for Option 1
                  value: _selectedMembru,
                  onChanged: (newValue) {
                    setState(() {

                      _selectedMembru = newValue;
                      if (_selectedMembru!.id != '-1')
                      {
                        areCopii = true;  
                        idCopil = _selectedMembru!.id;
                        programariCopil = getListaProgramariCopil();
                      }
                      else {
                        areCopii = false;
                        idCopil = '-1';
                        programari = getListaProgramari();
                      }
                    });
                  },
                  items: 
                  //Shared.familie.map((membru) {
                  listaInitialaMembri.map((membru){  
                    return DropdownMenuItem(
                      child: new Text(membru.nume.capitalizeFirst() + ' ' + membru.prenume.capitalizeFirst()),
                      value: membru,
                    );
                  }).toList(),
                ):
                SizedBox(),
                const SizedBox(height: 15),
                FutureBuilder(
                  future: areCopii? programariCopil: programari,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return isSelectedViitoare ? viitoareList() : isSelectedTrecute ? istoricList() : (!isSelectedTrecute && !isSelectedViitoare)? istoricList(): viitoareList();
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack viitoareList() {
    return 
    Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: areCopii? viitoareCopil.length : viitoare.length,
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
                      apiCallFunctions.getDetaliiProgramare(areCopii? viitoareCopil[index].id : viitoare[index].id).then((value) {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return ProgramariModal(
                              total: value!,
                              programare: areCopii? viitoareCopil[index] : viitoare[index],//viitoare[_selectedIndex],
                            );
                          });
                      });
                    },
                    child: (areCopii && viitoareCopil.isEmpty)? const Center(
                            child: Text("Nu aveți programări viitoare"),
                          )
                        : (areCopii && viitoareCopil.isNotEmpty)? ListTile(
                            leading: Icon(Icons.circle,
                              color: viitoareCopil[index].status == "Programat" || viitoareCopil[index].status == "În curs"
                                  ? Colors.blue
                                  : viitoareCopil[index].status == "Confirmat" || viitoareCopil[index].status == "Sosit"
                                      ? Colors.green
                                      : viitoareCopil[index].status == "Finalizat" || viitoareCopil[index].status == "Terminat"
                                          ? Colors.yellow
                                          : viitoareCopil[index].status == "Anulat" || viitoareCopil[index].status == "Anulat de medic"
                                           || viitoareCopil[index].status == "Anulat telefonic de pacient" || viitoareCopil[index].status == "Întârziere laborator"
                                           || viitoareCopil[index].status == "De reconfirmat" || viitoareCopil[index].status == "Cât mai curând"
                                           || viitoareCopil[index].status == "Urgență"
                                              ? Colors.red
                                              : Colors.grey),
                            title: Text(
                              DateFormat('EEEE, d.M.yyyy', 'ro').format(viitoareCopil[index].inceput).capitalizeFirst(),
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black87),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black,
                            ),
                          ):
                          (!areCopii && viitoare.isEmpty)? const Center(
                            child: Text("Nu aveți programări viitoare"),
                          )
                          :
                          ListTile(
                            leading: Icon(Icons.circle,
                                color: viitoare[index].status == "Programat" || viitoare[index].status == "În curs"
                                  ? Colors.blue
                                  : viitoare[index].status == "Confirmat" || viitoare[index].status == "Sosit"
                                      ? Colors.green
                                      : viitoare[index].status == "Finalizat" || viitoare[index].status == "Terminat"
                                          ? Colors.yellow
                                          : viitoare[index].status == "Anulat" || viitoare[index].status == "Anulat de medic"
                                           || viitoare[index].status == "Anulat telefonic de pacient" || viitoare[index].status == "Întârziere laborator"
                                           || viitoare[index].status == "De reconfirmat" || viitoare[index].status == "Cât mai curând"
                                           || viitoare[index].status == "Urgență"
                                              ? Colors.red
                                              : Colors.grey),
                            title: Text(
                              DateFormat('EEEE, d.M.yyyy', 'ro').format(viitoare[index].inceput).capitalizeFirst(),
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
        ),
        SizedBox(height: 20),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height:400
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAppointmentScreen())),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red[400],
                    ),
                    height: 50,
                    width: 200,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      Icon(Icons.add, color: Colors.white),
                      Text('Solicită programare  ',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget istoricList() {
    
    return (areCopii && trecuteCopil.length == 0)?
      Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Text(
            "Nu aveți programări trecute.",
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAppointmentScreen())),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[400],
              ),
              height: 50,
              width: 200,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Icon(Icons.add, color: Colors.white),
                Text('Solicită programare  ',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ]),
            ),
          )
        ],
      )
        : 
        (areCopii && trecuteCopil.length != 0)? 
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: trecuteCopil.length,
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
                          //print(' Rezultat $res');
                          apiCallFunctions.getDetaliiProgramare(trecuteCopil[_selectedIndex].id).then((value) {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return ProgramariModal(
                                    total: value!,
                                    programare: trecuteCopil[_selectedIndex],
                                  );
                                });
                          });
                        },
                        child: ListTile(
                          leading: Image.asset('./assets/images/programari.png', height: 25),
                          title: Text(
                            DateFormat('EEEE, d.M.yyyy', 'ro').format(trecuteCopil[index].inceput).capitalizeFirst(),
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
            ),
            /*  
            SizedBox(height: 20),
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAppointmentScreen())),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red[400],
                ),
                height: 50,
                width: 200,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  Icon(Icons.add, color: Colors.white),
                  Text('Solicită programare  ',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            */
          ],
        ):
      trecute.length == 0
        ? Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text(
                "Nu aveți programări trecute",
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAppointmentScreen())),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red[400],
                  ),
                  height: 50,
                  width: 200,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Icon(Icons.add, color: Colors.white),
                    Text('Solicită programare  ',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ]),
                ),
              )
            ],
          )
        : Column(
            children: [
            Padding(
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
                          apiCallFunctions.getDetaliiProgramare(trecute[_selectedIndex].id).then((value) {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return ProgramariModal(
                                    total: value!,
                                    programare: trecute[_selectedIndex],
                                  );
                                });
                          });
                        },
                        child: ListTile(
                          leading: Image.asset('./assets/images/programari.png', height: 25),
                          title: Text(
                            DateFormat('EEEE, d.M.yyyy', 'ro').format(trecute[index].inceput).capitalizeFirst(),
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
            ),
          /*
          SizedBox(height: 20),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAppointmentScreen())),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[400],
              ),
              height: 50,
              width: 200,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Icon(Icons.add, color: Colors.white),
                Text('Solicită programare  ',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
          */
        ],
      );
  }

  Row switchWidget() {
    return Row(
      children: [
        ToggleSwitch(
          initialLabelIndex: initialLabelIndex,
          minWidth: 110,
          activeBgColor: [Colors.red[400]!],
          inactiveBgColor: Colors.white,
          totalSwitches: 2,
          labels: const ['Trecute', 'Viitoare'],
          dividerColor: Colors.black,
          onToggle: (index) {
            setState(() {
              initialLabelIndex = index!;
              if (index == 0)
              {
                isSelectedTrecute = true;
                isSelectedViitoare = false;
              }
              else if (index == 1)
              {
                isSelectedTrecute = false;
                isSelectedViitoare = true;
              }
              else
              {
                isSelectedTrecute = true;
                isSelectedViitoare = false;
              }
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
          const Text('Programări', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
        ]),
      ],
    );
  }

  Future<Programari?> getListaProgramari() async {
    
    viitoare.clear();
    trecute.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String idUser = prefs.getString(pref_keys.userIdInregistrare)!;
    final Map<String, String> param = {
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
      print(res);
    }
    if (res.startsWith('66\$#\$')) {
      print("dategresite");
      print(res);
    }

    if (res.startsWith('132\$#\$')) {
      print("register error");
      print(res);
    }

    if (res.contains('%\$%')) {
      print(res);
      List<String> list = res.split('%\$%');
      List<String> viitoare = list[0].split('*\$*');
      List<String> trecute = list[1].split('*\$*');
      viitoare.removeWhere((element) => element.isEmpty);
      trecute.removeWhere((element) => element.isEmpty);

      if(viitoare.length > 0)
      {
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
              anulata: l[5],
              inceput: date,
              sfarsit: dateSf,
              id: l[6],
              hasFeedback: l[7],
              idMedic: l[8],
              locatie: l[9]);
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
              id: l[6],
              medic: l[2],
              categorie: l[3],
              status: l[4],
              anulata: l[5],
              inceput: date,
              sfarsit: dateSf,
              hasFeedback: l[7],
              idMedic: l[8],
              locatie: l[9]);
          programariTrecute.add(p);
        }
      }
      else {

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
          if (date.compareTo(DateTime.now()) < 0)
          {
            //TODO verif
            Programare p = Programare(
              nume: '',
              prenume: '',
              idPacient: '',
              id: l[6],
              medic: l[2],
              categorie: l[3],
              status: l[4],
              anulata: l[5],
              inceput: date,
              sfarsit: dateSf,
              hasFeedback: l[7],
              idMedic: l[8],
              locatie: l[9]);
            programariTrecute.add(p);
          }
          else {

            Programare p = Programare(
              nume: '',
              prenume: '',
              idPacient: '',
              id: l[6],
              medic: l[2],
              categorie: l[3],
              status: l[4],
              anulata: l[5],
              inceput: date,
              sfarsit: dateSf,
              hasFeedback: l[7],
              idMedic: l[8],
              locatie: l[9]);
            programariViitoare.add(p);

          }

        }
      }
    }
    programariTrecute.sort((a, b) => b.inceput.compareTo(a.inceput));
    programariViitoare.sort((a, b) => a.inceput.compareTo(b.inceput));
    Programari? pP = Programari(trecute: programariTrecute, viitoare: programariViitoare);
    //viitoare.addAll(pP.viitoare.reversed); //old Andrei Bădescu
    viitoare.addAll(pP.viitoare);
    trecute.addAll(pP.trecute.reversed);
    return pP;
  }

  Future<Programari?> getListaProgramariCopil() async {


    viitoare.clear();
    trecute.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> param = {};

    //if(Shared.limba.textLimba == 'ro')
    //{
    // final String idUser = prefs.getString(pref_keys.userIdInregistrare)!;
    param = {
      'pIdMembru':  idCopil.toString(),
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      //'pIdLimba': '0', //Andrei Bădescu
      'pIdLimba': '',//George Valentin Iordache
    };
    //}
    /*
    else
    {
      param = {
        'pIdMembru': Shared.familie[0].id,
        'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
        'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
        //'pIdLimba': '0', //Andrei Bădescu
        'pIdLimba': '2',//George Valentin Iordache
      };
    }
    */

    String? res =
        await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaProgramariPeMembruFamilie', pParametrii: param);

    List<Programare> programariViitoareCopil = <Programare>[];
    List<Programare> programariTrecuteCopil = <Programare>[];

    if (res == null) {
      // errorInfo = l.universalEroare;
      // infoWidget = InfoWidget.error;
      print("Eroare null");
      return null;
    }
    if (res.startsWith('13\$#\$')) {
      print("success");
      print(res);
    }
    if (res.startsWith('66\$#\$')) {
      print("dategresite");
      print(res);
    }

    if (res.startsWith('132\$#\$')) {
      print("register error");
      print(res);
    }

    if (res.contains('%\$%')) {
      print(res);
      List<String> list = res.split('%\$%');
      List<String> viitoare = list[0].split('*\$*');
      List<String> trecute = list[1].split('*\$*');
      viitoare.removeWhere((element) => element.isEmpty);
      trecute.removeWhere((element) => element.isEmpty);

      if (viitoare.length > 0 && trecute.length > 0)
      {

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

          //print('date inceput viitoare = ${date} date sfarsit viitoare = ${dateSf} ');

  //TODO verif
          Programare p = Programare(
              nume: '',
              prenume: '',
              idPacient: '',
              medic: l[2],
              categorie: l[3],
              status: l[4],
              anulata: l[5],
              inceput: date,
              sfarsit: dateSf,
              id: l[6],
              hasFeedback: l[7],
              idMedic: l[8],
              locatie: l[9]);
          programariViitoareCopil.add(p);
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

          //print('date inceput trecute = ${date} date sfarsit trecute = ${dateSf} ');
          //TODO verif
          Programare p = Programare(
              nume: '',
              prenume: '',
              idPacient: '',
              id: l[6],
              medic: l[2],
              categorie: l[3],
              status: l[4],
              anulata: l[5],
              inceput: date,
              sfarsit: dateSf,
              hasFeedback: l[7],
              idMedic: l[8],
              locatie: l[9]);

          
          programariTrecuteCopil.add(p);
        }
      } 
      else if (viitoare.length > 0)
      {
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
          if (date.compareTo(DateTime.now()) <= 0)
          {
            Programare p = Programare(
              nume: '',
              prenume: '',
              idPacient: '',
              id: l[6],
              medic: l[2],
              categorie: l[3],
              status: l[4],
              anulata: l[5],
              inceput: date,
              sfarsit: dateSf,
              hasFeedback: l[7],
              idMedic: l[8],
              locatie: l[9]);
            programariTrecuteCopil.add(p);
          }
          else if (date.compareTo(DateTime.now()) > 0)
          {
            Programare p = Programare(
              nume: '',
              prenume: '',
              idPacient: '',
              medic: l[2],
              categorie: l[3],
              status: l[4],
              anulata: l[5],
              inceput: date,
              sfarsit: dateSf,
              id: l[6],
              hasFeedback: l[7],
              idMedic: l[8],
              locatie: l[9]);
          programariViitoareCopil.add(p);
          }
        }  
      }
    }

    programariTrecuteCopil.sort((a, b) => b.inceput.compareTo(a.inceput));
    programariViitoareCopil.sort((a, b) => a.inceput.compareTo(b.inceput));
    Programari? pP = Programari(trecute: programariTrecuteCopil, viitoare: programariViitoareCopil);
    // print(" Asta e ${programariViitoareCopil.length}");
    setState(() {
      viitoareCopil = programariViitoareCopil.toList();
      trecuteCopil = programariTrecuteCopil.reversed.toList();
    });
    //print(" Programări trecute: ${trecute.length} : ${trecuteCopil.length}");
    //print(" Programări viitoare: ${viitoare.length} : ${viitoareCopil.length}");
    return pP;

  }
}
