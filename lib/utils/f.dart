import 'package:shared_preferences/shared_preferences.dart';
import './shared_pref_keys.dart' as pref_keys;
import 'api_call.dart';
import 'classes.dart';

Future<DetaliiProgramare?> getDetaliiProgramare(String pIdProgramare) async {
  ApiCall apiCall = ApiCall();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final Map<String, String> params = {
    // 'pCheie': 'uniqueID',
    'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
    'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
    'pIdProgramare': pIdProgramare,
  };
  String? lmao = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetDetaliiProgramare', pParametrii: params);
  print(lmao);
  List<String>? ayy = lmao?.split('%\$%');
  if (lmao == null) {
    return null;
  } else {
    return null;
  }
}
