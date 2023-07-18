import 'package:shared_preferences/shared_preferences.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;

extension StringExtension on String {
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Future<List<String?>>? getUserName() async {
  List<String?>? user = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var nume = prefs.getString(pref_keys.userNume);
  var prenume = prefs.getString(pref_keys.userPrenume);
  nume ??= "undefined";
  prenume ??= "undefined";
  user.add(nume);
  user.add(prenume);
  // print(user);
  return user;
}
