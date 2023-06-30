// import 'dart:convert';
// import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'api_responses.dart' as api_response;
import 'api_config.dart' as api_config;
import 'package:xml/xml.dart';
// import 'package:istoma_pacienti/localizations/1_localizations.dart';
// import 'package:istoma_pacienti/utils/utile_clase.dart';
// import 'package:istoma_pacienti/utils/utile_servicii.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:istoma_pacienti/utils/shared_pref_keys.dart' as prefKeys;
// import 'app_config.dart' as appConfig;

class ApiCall {
  Future<String?> apeleazaMetodaString({
    required String pNumeMetoda,
    Map<String, String>? pParametrii,
    bool afiseazaMesajPacientNeasociat = true,
  }) async {
    String url, host, key, xmlns;
    key = api_config.keyAppPacienti;
    url = '${api_config.serviciuAppPacienti}?op=$pNumeMetoda';
    xmlns = api_config.xmlnsAppPacienti;
    host = api_config.hostAppPacienti;

    //  urlRoot =
    //   'http://192.168.1.56/iStomaMobileView'; //////////////////////////////////////////////////////////////////////////

    pParametrii ??= <String, String>{};

    final Map<String, String> headers = {
      'Host': host,
      'Content-Type': 'application/soap+xml; charset=utf-8',
    };

    String parametrii = '';

    pParametrii.forEach((key, value) {
      parametrii = '$parametrii<$key>$value</$key>\n';
    });

    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // String user = prefs.getString(prefKeys.userEmail) ?? '';
    // String pass = prefs.getString(prefKeys.userPassMD5) ?? '';

    // String paramMail = user.isEmpty ? '' : '<pAdresaMail>$user</pAdresaMail>';
    // String paramPass = pass.isEmpty ? '' : '<pParola>$pass</pParola>';
    // String paramPassMD5 = pass.isEmpty ? '' : '<pParolaMD5>$pass</pParolaMD5>';

    var envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <$pNumeMetoda xmlns="$xmlns">
      <pCheie>$key</pCheie>
      $parametrii
      </$pNumeMetoda>
  </soap12:Body>
</soap12:Envelope>
''';

    var response = await http
        .post(Uri.parse(url), headers: headers, body: envelope)
        .timeout(const Duration(seconds: 20), onTimeout: () {
      return http.Response('', 408);
    });

    if (response.statusCode == 408) {
      // print(pNumeMetoda + ' TIMEOUT');
      return 'Timeout';
    }

    String data = '';

    // var l = LocalizationsApp.of(Shared.navigatorKey.currentContext!)!;

    try {
      data = XmlDocument.parse(response.body).findAllElements('${pNumeMetoda}Result').first.firstChild.toString();
    } catch (e) {
      // print('EROARE XML - ' + pNumeMetoda);
      // print(response.body);
      // showSnackbar(l.universalEroare);
      return 'error parsing';
    }

    switch (data) {
      case 'null':
        print('EROARE XML - ' + pNumeMetoda);
        print(response.body);
        return 'null';

      case api_response.succes:
        // ignore: avoid_print
        print('SUCCESS - $pNumeMetoda');
        print(response.body);
        return '13';

      case api_response.eroare:
        print(response.body);
        print("eroare");
        // print('EROARE - ' + pNumeMetoda);
        // print(envelope);
        // showSnackbar(l.universalEroare);
        return 'Eroare';

      case api_response.dateGresite:
        // print('DATE GRESITE - ' + pNumeMetoda);
        // print('3');
        if (afiseazaMesajPacientNeasociat) {
          // showSnackbar(l.universalMesajUserNeasociat);
        }

        print('66');
        print(response.body);
        return '66';

      case api_response.cheieGresita:
        // print('CHEIE GRESITA - ' + pNumeMetoda);
        // print(envelope);
        // showSnackbar(l.universalEroare);

        print('cheie gresita');
        print(response.body);
        return 'cheie gresita';

      default:
        return data;
    }
  }
}
