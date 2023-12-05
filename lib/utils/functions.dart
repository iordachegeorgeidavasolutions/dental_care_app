import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;

extension StringExtension on String {
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Future<List<String>> getUserName() async {
  List<String> user = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var nume = prefs.getString(pref_keys.userNume);
  var prenume = prefs.getString(pref_keys.userPrenume);
  user.add(nume ?? "asd");
  user.add(prenume ?? " asd");
  // print(user);
  return user;
}

void showSnackbar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text, style: TextStyle(color: Colors.black,),),
    
    backgroundColor: Color.fromARGB(255,200,200,200),
    duration: Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
