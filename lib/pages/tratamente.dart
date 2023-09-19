import 'package:dental_care_app/pages/register.dart';
import 'package:dental_care_app/utils/classes.dart';
import 'package:flutter/material.dart';
import '../widgets/items/tratemente_item.dart';

class TratamenteScreen extends StatefulWidget {
  const TratamenteScreen({super.key});

  @override
  State<TratamenteScreen> createState() => _TratamenteScreenState();
}

class _TratamenteScreenState extends State<TratamenteScreen> {
  late Future<List<LinieFisaTratament>?> tratamente;

  @override
  void initState() {
    super.initState();
    tratamente = getListaTratamente();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(children: [
            IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.black,
                onPressed: () => Navigator.pop(context)),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text("Inapoi",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)))
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Image.asset('./assets/images/person-icon.jpg', height: 40),
                  const SizedBox(height: 10),
                  const Text('Tratamente', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                ]),
              ],
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder(
              future: tratamente,
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
        ],
      ),
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
}
