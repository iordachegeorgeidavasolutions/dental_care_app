import 'package:dental_care_app/screens/register.dart';
import 'package:dental_care_app/utils/classes.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../widgets/items/tratemente_item.dart';

class TratamenteScreen extends StatefulWidget {
  const TratamenteScreen({super.key});

  @override
  State<TratamenteScreen> createState() => _TratamenteScreenState();
}

class _TratamenteScreenState extends State<TratamenteScreen> {
  late Future<List<LinieFisaTratament>?> tratamenteRealizate;
  late Future<List<LinieFisaTratament>?> tratamenteDeFacut;
  bool isSelected = true;
  int initialLabelIndex = 0;

  @override
  void initState() {
    super.initState();
    tratamenteRealizate = getListaTratamente();
    tratamenteDeFacut = getListaTratamenteDeFacut();
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
            switchWidget(),
            isSelected
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
                            child: Text("Error"),
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })
                : FutureBuilder(
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
                            child: Text("Error"),
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
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
              isSelected = !isSelected;
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
}
