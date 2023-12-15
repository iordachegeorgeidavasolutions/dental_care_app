import 'package:dental_care_app/screens/password_reset_pin.dart';
import 'package:dental_care_app/utils/functions.dart';
import 'package:dental_care_app/utils/classes.dart';
import 'package:intl/intl.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_call_functions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class EditLocalitate extends StatefulWidget {
  final String? selectedLocalitate;
  final String? idSelectedLocalitate;

  const EditLocalitate({Key? key, this.selectedLocalitate, this.idSelectedLocalitate}) : super(key: key);

  @override
  _EditLocalitateState createState() => _EditLocalitateState();
}

class _EditLocalitateState extends State<EditLocalitate> {
  
  String? selectedIdLocalitate;

  bool isOffline = false;
  bool loading = false;
  final TextEditingController controllerlocalitate = TextEditingController();

  final TextEditingController textSearchEditingController = TextEditingController();

  String? errorlocalitate;

  late String initiallocalitate='';
  bool shouldShowFirstContainer = false;


  @override
  void initState() {
    super.initState();

    SharedPrefs.getSelectedIdLocalitate().then((judet) {
      setState(() {
        selectedIdLocalitate = judet;
      });
    });
  }

  void onChanged(String? newValue) {
    setState(() {
      selectedIdLocalitate = newValue?? '';
      //SharedPrefs.setSelectedLocalitate(newValue!);
      SharedPrefs.setSelectedIdLocalitate(newValue!);
    });
  }


  void onSavePressed(BuildContext context) async {
    //save(context); // Call the save function from _EditLocalitateState

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(pref_keys.localitate, selectedIdLocalitate!);

    //print('id localitate selectată date facturare: ${selectedIdLocalitate} judet: ${Shared.judete.elementAt(int.parse(selectedIdLocalitate!)).denumire}');

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffECF4F8),
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
                        child: Center(
                          //padding: EdgeInsets.only(left: 0.2 * MediaQuery.of(context).size.width),
                          child: Text(
                            'Modifică localitatea',
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
          child: SelectorLocalitate(
            value: selectedIdLocalitate,
            onChanged: (newValue) {
              print('new value: $newValue');
              setState(() {
                selectedIdLocalitate = newValue!;
                controllerlocalitate.text = newValue;
                 // Update the controller text
              });
            },
            onSavePressed: () { 
              onSavePressed(context);
              
              //print('judet selectat: ${Shared.judeteDateFacturare.elementAt(int.parse(selectedIdJudet?? '1')+1).denumire} id judet selectat: $selectedIdJudet');

              Navigator.pop(context, selectedIdLocalitate);
            },
            localitateSelectata: selectedIdLocalitate,
            textEditingController: textSearchEditingController,
          ),  
        ),
      ]),
    );
  }
}

class SharedPrefs {
  static Future<String?> getSelectedLocalitate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLocalitate');
  }

  static Future<String?> getSelectedIdLocalitate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idLocalitate');
  }

  static Future<void> setSelectedLocalitate(String localitate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLocalitate', localitate);
  }

  static Future<void> setSelectedIdLocalitate(String idLocalitate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idLocalitate', idLocalitate);
  }

}

typedef OnChanged = void Function(String?);

class SelectorLocalitate extends StatelessWidget {
  final String? value;
  final String? localitateSelectata;
  final OnChanged onChanged; // Adăugăm funcția onChanged în clasa SelectorJudete
  final VoidCallback onSavePressed;

  final TextEditingController textEditingController;

  const SelectorLocalitate({
    Key? key,
    required this.value,
    required this.localitateSelectata,
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
                'Alegeți localitatea',
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
              hint: const Text("Selectează localitatea"),
              items: [
                ...Shared.localitati
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
                  'Selectează localitate',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                items: [
                  ...Shared.localitati
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
              value: localitateSelectata,
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
                      hintText: 'Căutați o localitate...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  
                  List<Localitate> localitatiDupaId = <Localitate>[];
                  if (searchValue.isNotEmpty)
                  {
                    localitatiDupaId = Shared.localitati.where((e) => e.denumire.startsWith(searchValue.capitalizeFirst())).toList();
                  }

                  if (localitatiDupaId.isNotEmpty)
                  {
                    return localitatiDupaId.any((localitate) => localitate.id == item.value);
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