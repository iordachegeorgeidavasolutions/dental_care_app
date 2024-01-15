import 'package:dental_care_app/screens/password_reset_pin.dart';
import 'package:dental_care_app/utils/functions.dart';
import 'package:dental_care_app/utils/classes.dart';
import 'package:intl/intl.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_call_functions.dart';
import '../screens/edit_judet.dart';
import '../screens/edit_localitate.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool dateChosen = false;
  bool verificationOk = false;
  final adressKey = GlobalKey<FormState>();
  final registerKey = GlobalKey<FormState>();
  final controllerNume = TextEditingController();
  final controllerPrenume = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerTelefon = TextEditingController();
  final controllerPass = TextEditingController();
  final controllerPassConfirm = TextEditingController();
  final controllerBirthdate = TextEditingController();
  final controllerJudet = TextEditingController();
  final controllerLocalitate = TextEditingController();

  final FocusNode focusNodeJudet = FocusNode();
  final FocusNode focusNodeLocalitate = FocusNode();
  final FocusNode focusNodeNume = FocusNode();
  final FocusNode focusNodePrenume = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeTelefon = FocusNode();
  final FocusNode focusNodePass = FocusNode();
  final FocusNode focusNodePassConfirm = FocusNode();
  final FocusNode focusNodeBirthdate = FocusNode();

  DateTime dataNasterii = DateTime.now();
  String hintLocalitate = '';
  String hintJudet = '';
  String hintNume = '';
  String hintPrenume = '';
  String hintEmail = '';
  String hintTelefon = '';
  String hintDataNastere = '';
  String hintParola = '';
  
  String emailVechi = '';
  String telefonVechi = '';
  
  String dataDeNastereVeche = '';

  bool isHidden = true;

  String judet = '';
  String idJudetRez = '';
  String localitate = '';
  String idLocalitateRez = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Profilul meu",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  registrationFields(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ), 
                    ),
                    onPressed: () async {

                      final isValidForm = registerKey.currentState!.validate();
                      //if (isValidForm) {
                      print('My Account Screen isValidForm: $isValidForm');
                      //}
                      // Scenario 1: User selected date and wants to change only the date
                      if (controllerEmail.text.isEmpty && controllerTelefon.text.isEmpty && dateChosen) {

                        await changeAddressDetails();
                      } else if ((controllerEmail.text.isNotEmpty || controllerTelefon.text.isNotEmpty) && dateChosen) {
                        // Scenario 2: User selected date and wants to change the date and the contact details
                        await changeAddressDetails();
                        await changeUserData();
                      } else if ((controllerEmail.text.isNotEmpty || controllerTelefon.text.isNotEmpty) && !dateChosen) {
                        // Scenario 3: User wants to change only the contact details
                        await changeUserData();
                      } else if (controllerEmail.text.isEmpty && controllerTelefon.text.isEmpty && !dateChosen) {
                        // Scenario 4: User wants to change nothing
                        showSnackbar(context, "Nu ai schimbat nimic!");
                      }
                    },
                    child: const Text(
                      'Schimbă datele',
                      style: TextStyle(fontSize: 24, color:Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Row(
                    children: [Text("Adresa mea", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))],
                  ),
                  SizedBox(height: 20),
                  adressFields(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      if (controllerJudet.text.isNotEmpty || controllerLocalitate.text.isNotEmpty) {
                        changeAddressDetails();
                      }
                      else if (controllerJudet.text.isEmpty && controllerLocalitate.text.isEmpty) {
                        // Scenario 4: User wants to change nothing
                        showSnackbar(context, "Nu ai schimbat nimic!");
                      }
                    },
                    child: const Text(
                      'Adaugă datele',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form adressFields() {
    return Form(
      key: adressKey,
      child: Column(children: [
        TextFormField(
            focusNode: focusNodeJudet,
            controller: controllerJudet,
            autocorrect: false,
            readOnly: true,
            onFieldSubmitted: (String s) {
              focusNodeLocalitate.requestFocus();
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    String idJudet = await Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => const EditJudet(
                        selectedIdJudet: '',
                      ),
                    ));
              
                    setState(() {
                      if(idJudetRez != idJudet)
                      {
                        localitate = '';
                        idLocalitateRez = '';
                      }
                      idJudetRez = idJudet;
                      var judetDupaId = Shared.judete.where((e) => e.id == idJudetRez);
                      if(judetDupaId.isNotEmpty)
                      {
                        judet = judetDupaId.elementAt(0).denumire;  
                      }
                      
                      controllerJudet.text = judet;
                      controllerLocalitate.text = '';
                      hintJudet = judet;
                      hintLocalitate = 'Introduceți o localitate';

                    });

                    List<Localitate> localitatiGetLista = await apiCallFunctions.getListaLocalitati(idJudet);

                    if (!mounted) {
                      return;
                    }
                    Shared.localitati.clear();
                    Shared.localitati.addAll(localitatiGetLista);

                  },  
                ),
                hintText: hintJudet,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
        TextFormField(
            focusNode: focusNodeLocalitate,
            controller: controllerLocalitate,
            autocorrect: false,
            readOnly: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    
                    print('my_account_screen controllerLocalitate length lista localități: ${Shared.localitati.length}');

                    String idLocalitate = await Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => const EditLocalitate(
                        selectedLocalitate: '',
                        idSelectedLocalitate: '',
                      ),
                    ));

                    if (!mounted) {
                      return;
                    }

                    setState(() {

                      idLocalitateRez = idLocalitate;

                      var localitateDupaId = Shared.localitati.where((e) => e.id == idLocalitate);
                      if(localitateDupaId.isNotEmpty)
                      {
                        localitate = localitateDupaId.elementAt(0).denumire;  
                      }
                      controllerLocalitate.text = localitate;

                    });

                  },  
                ),
                hintText: hintLocalitate,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
      ]),
    );
  }

  Form registrationFields() {
    return Form(
      key: registerKey,
      child: Column(children: [
        TextFormField(
            readOnly: true,
            focusNode: focusNodeNume,
            controller: controllerNume,
            autocorrect: false,
            onFieldSubmitted: (String s) {
              focusNodePrenume.requestFocus();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintPrenume,
              enabledBorder:
                  const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
              filled: true,
              fillColor: Colors.white),
              /*validator: (value) {
                if (value!.isEmpty) {
                  //return "Enter a valid Email Address or Password"; //old Andrei Bădescu
                  return "Introduceți un nume!"; //old Andrei Bădescu
                }
                return null;
              },
              */  
              /*if (value!.isEmpty || !RegExp(r'.+@.+\.+').hasMatch(value) && !RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                //return "Enter a valid Email Address or Password"; //old Andrei Bădescu
                return "Introduceți o adresă de e-mail sau telefon valide"; //old Andrei Bădescu
              } else {
                if (RegExp(r'.+@.+\.+').hasMatch(value)) {
                  setState(() {
                    loginPhoneOrEmail = false;
                  });
                  return null;
                } else if (RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                  setState(() {
                    loginPhoneOrEmail = true;
                  });
                  return null;
                } else {
                  return null;
                }
              }*/
        ),
        const SizedBox(height: 3),
        TextFormField(
          readOnly: true,
          focusNode: focusNodePrenume,
          controller: controllerPrenume,
          autocorrect: false,
          onFieldSubmitted: (String s) {
            focusNodeEmail.requestFocus();
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintNume,
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
            filled: true,
            fillColor: Colors.white),
          /*
          validator: (value) {
            if (value!.isEmpty) {
              //return "Enter a valid Email Address or Password"; //old Andrei Bădescu
              return "Introduceți un prenume!"; //old Andrei Bădescu
            }
            return null;
          }
          */
        ),
        const SizedBox(height: 3),
        TextFormField(
            focusNode: focusNodeEmail,
            controller: controllerEmail,
            readOnly: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (String s) {
              focusNodeTelefon.requestFocus();
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      hintEmail = 'Introduceți adresa de e-mail';
                      controllerEmail.text = '';
                    });
                    
                  },
                ),
                hintText: hintEmail,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white),
            validator: (value) {
              String emailPattern = r'.+@.+\.+';
              RegExp emailRegExp = RegExp(emailPattern);
              if ((emailVechi.isEmpty) &&(value!.isEmpty || !emailRegExp.hasMatch(value))) {
                return "Introduceți o adresă de Email corectă";
              } else {
                return null;
              }
            },
          ),
        const SizedBox(height: 3),
        TextFormField(
          focusNode: focusNodeTelefon,
          controller: controllerTelefon,
          keyboardType: TextInputType.number,
          autocorrect: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  hintTelefon = 'Introduceți un telefon nou';
                  controllerTelefon.text = '';
                });  
              },
            ),
            hintText: hintTelefon,
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
            filled: true,
            fillColor: Colors.white
          ),
          validator: (value) {
            String phonePattern = r'(^(?:[+0]4)?[0-9]{10}$)';
            RegExp phoneRegExp = RegExp(phonePattern);
            if ((telefonVechi.isEmpty) && (value!.isEmpty || (!(value.length != 10) && !(value.length != 12)))) {
              return '"Introduceti un număr de telefon corect"';
            }
            else if ((telefonVechi.isEmpty) && !phoneRegExp.hasMatch(value!)) {
              return 'Introduceți un număr de mobil corect';
            }
            return null;
          },
        ),
        const SizedBox(height: 3),
        TextFormField(
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context, 
                locale : const Locale("ro","RO"),
                initialDate: DateTime.now(), firstDate: DateTime(1960), lastDate: DateTime(2040),
                builder: (context, child) {
                return Theme(

                  data: Theme.of(context).copyWith(
                    splashColor: Color.fromARGB(255,200,200,200), //Colors.red,
                    colorScheme: ColorScheme.light(
                      surface: Colors.white,
                      primary: Colors.red, // // <-- SEE HERE
                      //onSurface: Colors.white, // <-- SEE HERE
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black, // button text color
                      ),
                    ),
                  ),
                  child: child!,
                  );
                },
              );
              
              setState(() {
                
                controllerBirthdate.text = DateFormat('dd/MM/yyyy').format(date!).toString();
                dataNasterii = date;
                dateChosen = true;
                hintDataNastere = controllerBirthdate.text;

              });

            },
            controller: controllerBirthdate,
            focusNode: focusNodeBirthdate,
            autocorrect: false,
            readOnly: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {

                  DateTime? date = await showDatePicker(
                    context: context, 
                    locale : const Locale("ro","RO"),
                    initialDate: DateTime.now(), firstDate: DateTime(1960), lastDate: DateTime(2040),
                    builder: (context, child) {
                    return Theme(

                      data: Theme.of(context).copyWith(
                        
                        splashColor: Color.fromARGB(255,200,200,200), //Colors.red,
                        colorScheme: ColorScheme.light(
                          surface: Colors.white,
                          primary: Colors.red, // // <-- SEE HERE
                          //onSurface: Colors.white, // <-- SEE HERE
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black, // button text color
                          ),
                        ),
                      ),
                      child: child!,
                      );
                    },
                  );

                  setState(() {
                
                    controllerBirthdate.text = DateFormat('dd/MM/yyyy').format(date!).toString();
                    dataNasterii = date;
                    dateChosen = true;
                    hintDataNastere = controllerBirthdate.text;

                  });  
                },
              ),
              hintText: formatDate(hintDataNastere),
              enabledBorder:
                  const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
              filled: true,
              fillColor: Colors.white
            ),
            validator: (value) {
              value = controllerBirthdate.text;
              if ((dataDeNastereVeche.isEmpty) && value.isEmpty) {
                //return "Enter a valid Email Address or Password"; //old Andrei Bădescu
                return "Introduceți o dată de naștere!"; //old Andrei Bădescu
              }
              return null;
            }
          ),
        const SizedBox(height: 3),
      ]),
    );
  }

  String formatDate(String dateString) {
    // Check if the input string has the correct length
    if (dateString.length != 8) {
      //return 'Invalid date format'; //old Andrei Bădescu
      return 'Format dată invalid';
    }

    // Parse the received date string
    String year = dateString.substring(4, 8);
    String month = dateString.substring(2, 4);
    String day = dateString.substring(0, 2);

    // Format the date into "dd-MM-yyyy" format
    //String formattedDate = '$day-$month-$year';
    String formattedDate = '$day/$month/$year';
    return formattedDate;
  }

  void loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Judet> z = await apiCallFunctions.getListaJudete();

    Shared.judete.clear();
    Shared.judete.addAll(z);
    
    idJudetRez = prefs.getString(pref_keys.idJudet) ?? "1";

    List<Localitate> l = await apiCallFunctions.getListaLocalitati(idJudetRez);

    Shared.localitati.clear();
    Shared.localitati.addAll(l);

    //print('My account screen: loadUserData judete = ${Shared.judete.length}');

    setState(() {

      var judetDupaId = Shared.judete.where((e) => e.id == idJudetRez);
      if(judetDupaId.isNotEmpty)
      {
        judet = judetDupaId.elementAt(0).denumire;  
      }

      hintJudet = judet;

      //print("my account screen hintJudet: $judet");

      idLocalitateRez = prefs.getString(pref_keys.idLocalitate) ?? "";

      var localitateDupaId = Shared.localitati.where((e) => e.id == idLocalitateRez);
      if(localitateDupaId.isNotEmpty)
      {
        localitate = localitateDupaId.elementAt(0).denumire;  
      }

      hintLocalitate = localitate;

      hintNume = prefs.getString(pref_keys.userNume)!;
      hintPrenume = prefs.getString(pref_keys.userPrenume)!;
      hintDataNastere = prefs.getString(pref_keys.userDDN)?? DateTime.now().toString();
      
      dataDeNastereVeche = hintDataNastere;

      hintTelefon = prefs.getString(pref_keys.userTelefon)!;
      telefonVechi = hintTelefon;
      hintEmail = prefs.getString(pref_keys.userEmail)!;
      emailVechi = hintEmail;

    });

    focusNodeTelefon.addListener(() {
      if (focusNodeTelefon.hasFocus) {
        hintTelefon = 'Introduceți un telefon nou';
      } else {
        hintTelefon = prefs.getString(pref_keys.userTelefon)!;
      }
      setState(() {});
    });

    focusNodeEmail.addListener(() {

      if (focusNodeEmail.hasFocus) {
        hintEmail = 'Introduceți adresa de e-mail';
      } else {
        hintEmail = prefs.getString(pref_keys.userEmail)!;
      }
      setState(() {});

    });

  }

  changeAddressDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    String dataNastere = DateTime.now().toString();

    String dNow = DateFormat('ddMMyyyy').format(DateTime.now());

    //String dDN

    if (dataNasterii.compareTo(DateTime.parse(dNow)) != 0)
    {

      dataNastere = DateFormat('dd.MM.yyyy').format(dataNasterii).toString(); 

    }
    String? res = await apiCallFunctions.schimbaDatelePersonale(
        //pDataDeNastereDDMMYYYY: controllerBirthdate.text.isEmpty ? hintDataNastere : controllerBirthdate.text, //old Andrei Bădescu
        pDataDeNastereDDMMYYYY: dataNasterii.compareTo(DateTime.parse(dNow)) != 0? dataNastere: DateFormat('dd.MM.yyyy').format(DateTime.parse(dataDeNastereVeche)).toString(),
        //pDataDeNastereDDMMYYYY: DateFormat('dd.MM.yyyy').format(dataNasterii),
        judet: controllerJudet.text.isEmpty ? hintJudet : idJudetRez, //controllerJudet.text, //old Andrei Bădescu
        localitate: controllerLocalitate.text.isEmpty ? hintLocalitate : idLocalitateRez); //controllerLocalitate.text); //old Andrei Bădescu

    print('changeAddressDetails rezultat: $res dataNastere: ${dataNastere} judet: ${idJudetRez} localitate: ${idLocalitateRez}');

    if (res == null) {
      showSnackbar(
        context,
        "Eroare schimbare date personale!",
      );
      return;
    } else if (res.startsWith('66')) {
      showSnackbar(context, "Date greșite");
      return;
    } else if (res.startsWith('13')) {
      showSnackbar(context, "Date personale corecte - cerere trimisă!");
      //if (dateChosen && idJudetRez == '' && idLocalitateRez == '') {
      //  return;
      //} else
      if(dataNasterii != DateTime.now())
      {

        prefs.setString(pref_keys.userDDN, DateFormat('ddMMyyyy').format(dataNasterii!).toString());

      }

      if (controllerJudet.text.isNotEmpty && controllerLocalitate.text.isNotEmpty) {
        
        prefs.setString(pref_keys.judet, controllerJudet.text);
        prefs.setString(pref_keys.idJudet, idJudetRez);
        prefs.setString(pref_keys.localitate, controllerLocalitate.text);
        prefs.setString(pref_keys.idLocalitate, idLocalitateRez);

      } else if (controllerJudet.text.isEmpty) {
        
        prefs.setString(pref_keys.judet, controllerJudet.text);
        prefs.setString(pref_keys.idJudet, idJudetRez);

      } else {
        
        prefs.setString(pref_keys.localitate, controllerLocalitate.text);
        prefs.setString(pref_keys.idLocalitate, idLocalitateRez);

      }
    }
  }

  changeUserData() async {

    //print('changeUserData init: ');
    
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //print('changeUserData rezultat: pNouaAdresaDeEmail: ${controllerEmail.text.isEmpty ? emailVechi : controllerEmail.text} pNoulTelefon: ${controllerTelefon.text.isEmpty ? telefonVechi : controllerTelefon.text}, ${prefs.getString(pref_keys.userEmail)}, ${prefs.getString(pref_keys.userPassMD5)!}');

    String? res = await apiCallFunctions.schimbaDateleDeContact(
      pNouaAdresaDeEmail: controllerEmail.text.isEmpty ? hintEmail : controllerEmail.text,
      pNoulTelefon: controllerTelefon.text.isEmpty ? hintTelefon : controllerTelefon.text,
      pAdresaDeEmail: prefs.getString(pref_keys.userEmail)!,
      pParola: prefs.getString(pref_keys.userPassMD5)!,
    );
    //print(res);

    print('my_account_screen changeUserData rezultat: $res');


    if (res == null) {
      showSnackbar(
        context,
        "Eroare schimbare date contact!",
      );
      return;
    } else if (res.startsWith('66')) {
      showSnackbar(context, "Date greșite");
      return;
    } else if (res.startsWith('13')) {
      showSnackbar(context, "Date contact corecte - cerere trimisă!");
      setState(
        () {

          verificationOk = true;
          
        },
      );
      if (verificationOk) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PasswordResetPin(
              resetDoarTelefon: (controllerEmail.text.isEmpty && controllerTelefon.text.isNotEmpty)? true: false,
              resetEmailOrPhoneNumber: true,
              //email: hintEmail, //old Andrei Bădescu
              email: prefs.getString(pref_keys.userEmail)!,
              //password: hintParola, //old Andrei Bădescu
              password: prefs.getString(pref_keys.userPassMD5)!,
              telefon: controllerTelefon.text.isEmpty ? hintTelefon : controllerTelefon.text,
            ),
          ),
        );
      }
    }
  }
}
