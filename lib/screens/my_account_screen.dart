import 'package:dental_care_app/screens/password_reset_pin.dart';
import 'package:dental_care_app/utils/functions.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_call_functions.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool verificationOk = false;

  final registerKey = GlobalKey<FormState>();
  final controllerNume = TextEditingController();
  final controllerPrenume = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerTelefon = TextEditingController();
  final controllerPass = TextEditingController();
  final controllerPassConfirm = TextEditingController();
  final controllerBirthdate = TextEditingController();

  final FocusNode focusNodeNume = FocusNode();
  final FocusNode focusNodePrenume = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeTelefon = FocusNode();
  final FocusNode focusNodePass = FocusNode();
  final FocusNode focusNodePassConfirm = FocusNode();
  final FocusNode focusNodeBirthdate = FocusNode();
  DateTime? dataNasterii;

  String hintNume = '';
  String hintPrenume = '';
  String hintEmail = '';
  String hintTelefon = '';
  String hintDataNastere = '';
  String hintParola = '';
  bool isHidden = true;
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
                  child: const Text("Inapoi",
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
                      backgroundColor: Colors.red,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      final isValidForm = registerKey.currentState!.validate();
                      if (isValidForm) {
                        changeUserData();
                      }
                    },
                    child: const Text(
                      'Schimba datele',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form registrationFields() {
    return Form(
      key: registerKey,
      child: Column(children: [
        TextFormField(
            readOnly: true,
            focusNode: focusNodePrenume,
            controller: controllerNume,
            autocorrect: false,
            onFieldSubmitted: (String s) {
              focusNodeNume.requestFocus();
            },
            decoration: InputDecoration(
                hintText: hintPrenume,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
        TextFormField(
            readOnly: true,
            focusNode: focusNodeNume,
            controller: controllerPrenume,
            autocorrect: false,
            onFieldSubmitted: (String s) {
              focusNodeEmail.requestFocus();
            },
            decoration: InputDecoration(
                hintText: hintNume,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
        TextFormField(
            focusNode: focusNodeEmail,
            controller: controllerEmail,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (String s) {
              focusNodeTelefon.requestFocus();
            },
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.edit),
                hintText: hintEmail,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
        TextFormField(
            focusNode: focusNodeTelefon,
            keyboardType: TextInputType.number,
            controller: controllerTelefon,
            autocorrect: false,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.edit),
                hintText: hintTelefon,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
        TextFormField(
            focusNode: focusNodeBirthdate,
            autocorrect: false,
            readOnly: true,
            decoration: InputDecoration(
                hintText: hintDataNastere,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
                filled: true,
                fillColor: Colors.white)),
        const SizedBox(height: 3),
      ]),
    );
  }

  void loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hintNume = prefs.getString(pref_keys.userNume)!;
      hintPrenume = prefs.getString(pref_keys.userPrenume)!;
      hintDataNastere = prefs.getString(pref_keys.userDDN)!;
      hintTelefon = prefs.getString(pref_keys.userTelefon)!;
      hintEmail = prefs.getString(pref_keys.userEmail)!;
      hintParola = prefs.getString(pref_keys.userPassMD5)!;
    });
  }

  changeUserData() async {
    String? res = await apiCallFunctions.schimbaDateleDeContact(
      pNouaAdresaDeEmail: controllerEmail.text.isEmpty ? hintEmail : controllerEmail.text,
      pNoulTelefon: controllerTelefon.text.isEmpty ? hintTelefon : controllerTelefon.text,
      pAdresaDeEmail: hintEmail,
      pParola: hintParola,
    );
    print(res);
    if (res == null) {
      showSnackbar(
        context,
        "Eroare schimbare date contact!",
      );
      return;
    } else if (res.startsWith('66')) {
      showSnackbar(context, "Date gresite");
      return;
    } else if (res.startsWith('13')) {
      showSnackbar(context, "Date corecte - cerere trimisa!");
      setState(
        () {
          verificationOk = true;
          if (verificationOk) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PasswordResetPin(
                  resetEmailOrPhoneNumber: true,
                  email: hintEmail,
                  password: hintParola,
                ),
              ),
            );
          }
        },
      );
    }
  }
}
