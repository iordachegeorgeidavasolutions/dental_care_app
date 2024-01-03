import 'package:dental_care_app/screens/password_reset_pin.dart';
import 'package:dental_care_app/utils/functions.dart';
import 'package:dental_care_app/utils/classes.dart';
import 'package:intl/intl.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_call_functions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class EditJudet extends StatefulWidget {
  final String? selectedIdJudet;

  const EditJudet({Key? key, required this.selectedIdJudet}) : super(key: key);

  @override
  _EditJudetState createState() => _EditJudetState();
}

class _EditJudetState extends State<EditJudet> {
  
  String? selectedIdJudet;

  bool isOffline = false;
  bool loading = false;
  final TextEditingController controllerjudet = TextEditingController();
  
  final TextEditingController textSearchEditingController = TextEditingController();

  String? errorjudet;

  late String initialjudet='';
  bool shouldShowFirstContainer = false;


  @override
  void initState() {
    super.initState();

    SharedPrefs.getSelectedIdJudet().then((judet) {
      setState(() {
        selectedIdJudet = judet;
      });
    });
  }

  void onChanged(String? newValue) {
    setState(() {
      selectedIdJudet = newValue?? '';
      //SharedPrefs.setSelectedJudet(newValue!);
      SharedPrefs.setSelectedIdJudet(newValue!);
    });
  }

  Future<void> connectionChanged(dynamic hasConnection) async {
    isOffline = !hasConnection;
    setState(() {});
  }


  void onSavePressed(BuildContext context) async {
    //save(context); // Call the save function from _EditJudetState

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(pref_keys.judet, selectedIdJudet!);

    print('id judet selectat date facturare: ${selectedIdJudet} judet: ${Shared.judete.elementAt(int.parse(selectedIdJudet!)).denumire}');

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: ListView(children: [

        Column(
          children: [
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
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              //color: Colors.white,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.05 * MediaQuery.of(context).size.width),
                  child: Row(
                    children: [
                      /*Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      */
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.2 * MediaQuery.of(context).size.width),
                          child: Text(
                            'Modifică județul',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        Center(
          child: SelectorJudete(
            value: selectedIdJudet,
            onChanged: (newValue) {
              print('new value: $newValue');
              setState(() {
                selectedIdJudet = newValue!;
                controllerjudet.text = newValue;
                 // Update the controller text
              });
            },
            onSavePressed: () { 
              onSavePressed(context);
              
              //print('judet selectat: ${Shared.judeteDateFacturare.elementAt(int.parse(selectedIdJudet?? '1')+1).denumire} id judet selectat: $selectedIdJudet');

              Navigator.pop(context, selectedIdJudet);
            },
            judetSelectat: selectedIdJudet,
            textEditingController: textSearchEditingController,
          ),
        ),
      ]),
    );
  }
}

class SharedPrefs {
  static Future<String?> getSelectedJudet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedJudet');
  }

  static Future<String?> getSelectedIdJudet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idJudet');
  }

  static Future<void> setSelectedJudet(String judet) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedJudet', judet);
  }

  static Future<void> setSelectedIdJudet(String idJudet) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idJudet', idJudet);
  }

}

typedef OnChanged = void Function(String?);

class SelectorJudete extends StatelessWidget {
  final String? value;
  final String? judetSelectat;
  final OnChanged onChanged; // Adăugăm funcția onChanged în clasa SelectorJudete
  final VoidCallback onSavePressed;
  final TextEditingController textEditingController;

  const SelectorJudete({
    Key? key,
    required this.value,
    required this.judetSelectat,
    required this.onChanged, required this.onSavePressed,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Alegeți judetul',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          /*Card(elevation: 0,
            child: DropdownButton<String?>(
              isExpanded: true,
              value: value,
              underline: const SizedBox(),
              hint: const Text("Selectează județul"),
              items: [
                ...Shared.judete
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Center(
                          child: Text(e.denumire, style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),),
                        ),
                      ),
                    )
                    .toList(),
              ],
              onChanged: onChanged, // Setăm funcția onChanged pentru DropdownButton
            ),
          ),
          */ //old IGV
          Card(elevation: 0,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Text(
                  'Selectează județ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                items: [
                  ...Shared.judete
                      .map(
                        (e) => DropdownMenuItem(
                      value: e.id,
                      child: Center(
                        child: Text(e.denumire,style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                      ),
                    ),
                  )
                  .toList(),
              ],
              value: judetSelectat,
              onChanged: onChanged,
              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Căutați un județ...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  
                  List<Judet> judeteDupaId = <Judet>[];
                  if (searchValue.isNotEmpty)
                  {
                    judeteDupaId = Shared.judete.where((e) => e.denumire.startsWith(searchValue.capitalizeFirst())).toList();
                  }

                  if (judeteDupaId.isNotEmpty)
                  {
                    return judeteDupaId.any((judet) => judet.id == item.value);
                  }
                  return item.value.toString().contains(searchValue);
                },
              ),
              ), // Setăm funcția onChanged pentru DropdownButton
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ), 
            ),
            onPressed: () {
              onSavePressed(); 
            },
            child: Text(
              'Salvați',
              style: TextStyle(fontSize: 24, color:Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}