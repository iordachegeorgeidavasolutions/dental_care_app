import 'package:dental_care_app/screens/register.dart';
import 'package:dental_care_app/utils/classes.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../widgets/items/tratemente_item.dart';
import 'package:dental_care_app/utils/functions.dart';

class TratamenteScreen extends StatefulWidget {

  //final String idCopil;

  const TratamenteScreen({super.key,});


  @override
  State<TratamenteScreen> createState() => _TratamenteScreenState();
}

class _TratamenteScreenState extends State<TratamenteScreen> {
  late Future<List<LinieFisaTratament>?> tratamenteRealizate;
  //late Future<List<LinieFisaTratament>?> tratamenteDeFacut;
  //late Future<List<LinieFisaTratament>?> tratamenteDeFacutCopilUser;
  late Future<List<LinieFisaTratament>?> tratamenteRealizateCopilUser;

  bool areCopii = false;
  bool isSelectedTrecute = true;
  bool isSelectedViitoare = false;
  int initialLabelIndex = 0;

  String idCopil = '';

  MembruFamilie? _selectedMembru;

  bool afiseazaDropDownFamilie = Shared.familie.length > 0? true : false;

  static List<MembruFamilie> listaInitialaMembri = <MembruFamilie>[MembruFamilie(id: '-1', nume: 'Tratamentele', prenume: ' mele')];

  @override
  void initState() {
    super.initState();
    
    setState(() {

      isSelectedTrecute = true;
      isSelectedViitoare = false;
      listaInitialaMembri = <MembruFamilie>[MembruFamilie(id: '-1', nume: 'Tratamentele', prenume: ' mele')];
      listaInitialaMembri.addAll(Shared.familie);

    });

    //print('Lista initială membri: ${listaInitialaMembri.length} ');


    areCopii = false;
    tratamenteRealizate = getListaTratamente();
      //tratamenteDeFacut = getListaTratamenteDeFacut();  

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context)),
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text("Înapoi",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)))
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SizedBox(height: 10),
                    const Text('Tratamente', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 10),
            //switchWidget(),
            afiseazaDropDownFamilie? DropdownButton(
            hint: Text('Alege un membru al familiei'), // Not necessary for Option 1
            value: _selectedMembru,
            onChanged: (newValue) {
              setState(() {

                _selectedMembru = newValue;
                if (_selectedMembru!.id != '-1')
                {
                  areCopii = true;  
                  idCopil = _selectedMembru!.id;
                  tratamenteRealizateCopilUser = getListaLiniiFisaTratamentRealizateMembruFamilie();
                  ;
                }
                else {
                  areCopii = false;  
                  idCopil = '-1';
                  tratamenteRealizate = getListaTratamente();
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
            (areCopii && isSelectedTrecute)?
              FutureBuilder(
                    future: tratamenteRealizateCopilUser,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          return listaTratamente(snapshot);
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Eroare"),
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }):
                /*: (areCopil && isSelectedViitoare)? FutureBuilder(
                    future: tratamenteDeFacutCopilUser,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          return listaTratamente(snapshot);
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Eroare"),
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }):
                  */  
                (!areCopii && isSelectedTrecute)
                  ? FutureBuilder(
                    future: tratamenteRealizate,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          return listaTratamente(snapshot);
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Eroare"),
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })
                /*: (!areCopil && isSelectedViitoare)? FutureBuilder(
                    future: tratamenteDeFacut,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          return listaTratamente(snapshot);
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Eroare"),
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }):
                  */  
                    : SizedBox(),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Row switchWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleSwitch(
          initialLabelIndex: initialLabelIndex,
          minWidth: 110,
          activeBgColor: [Colors.red[400]!],
          inactiveBgColor: Colors.white,
          totalSwitches: 2,
          labels: const ['Istoric', 'Viitor'],
          dividerColor: Colors.black,
          onToggle: (index) {
            setState(() {
              initialLabelIndex = index!;
              if (index == 0)
              {
                isSelectedTrecute = true;
                isSelectedViitoare = false;
              }
              else
              {
                isSelectedTrecute = false;
                isSelectedViitoare = true;
              }
            });
          },
        ),
      ],
    );
  }

  ListView listaTratamente(AsyncSnapshot<List<LinieFisaTratament>?> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Center(
            child: TratamenteItem(
                data: snapshot.data![index].dataDateTime,
                doctor: snapshot.data![index].numeMedic,
                price: snapshot.data![index].pret,
                procedure: snapshot.data![index].denumireInterventie),
          );
        });
  }

  Future<List<LinieFisaTratament>?> getListaTratamente() async {
    List<LinieFisaTratament>? lista1 = await apiCallFunctions.getListaLiniiFisaTratamentRealizate();
    if (lista1 == null) {
      return null;
    } else {
      // ignore: avoid_print
      print(lista1);
      return lista1;
    }
    // ignore: avoid_print
  }

  Future<List<LinieFisaTratament>?> getListaTratamenteDeFacut() async {
    List<LinieFisaTratament>? lista1 = await apiCallFunctions.getListaLiniiFisaTratamentDeFacut();
    if (lista1 == null) {
      return null;
    } else {
      // ignore: avoid_print
      print(lista1);
      return lista1;
    }
    // ignore: avoid_print
  }

  
  Future<List<LinieFisaTratament>?> getListaLiniiFisaTratamentRealizateMembruFamilie() async {
    
    
    var membruFamilie = Shared.familie.where((e) => e.id == idCopil);
    if (membruFamilie.length > 0) {

      List<LinieFisaTratament>? lista1 = 
        await apiCallFunctions.getListaLiniiFisaTratamentRealizateMembruFamilie(membruFamilie.first);
        //await apiCallFunctions.getListaLiniiFisaTratamentRealizateMembruFamilie(Shared.familie[0]); //old Andrei Bădescu
      if (lista1 == null) {
        return null;
      } else {
        // ignore: avoid_print
        //print(lista1);
        //print('Lista tratamente realizate: ${lista1.length}');
        return lista1;
      }
    }
    return null;  
    // ignore: avoid_print
  }

  Future<List<LinieFisaTratament>?> getListaLiniiFisaTratamentDeFacutMembruFamilie() async {

    var membruFamilie = Shared.familie.where((e) => e.id == idCopil);
    if (membruFamilie.length > 0) {

      List<LinieFisaTratament>? lista1 =
          await apiCallFunctions.getListaLiniiFisaTratamentDeFacutPeMembruFamilie(membruFamilie.first);
          //await apiCallFunctions.getListaLiniiFisaTratamentDeFacutPeMembruFamilie(Shared.familie[0]); //old Andrei Bădescu
      if (lista1 == null) {
        return null;
      } else {
        // ignore: avoid_print
        print('Lista tratamente de făcut...: ${lista1.length}');
        return lista1;
      }
    // ignore: avoid_print
    }
    return null;
  }  
}
