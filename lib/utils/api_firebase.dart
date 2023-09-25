// ignore_for_file: avoid_print
import 'package:dental_care_app/utils/api_call_functions.dart';
import './shared_pref_keys.dart' as pref_keys;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Title: ${message.notification?.body}');
  print('Title: ${message.data}');
}

// Updates the User's FCM Token in the DB
Future<void> saveTokenToDB(String token) async {
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(pref_keys.fcmToken, token);
  String? res = await apiCallFunctions.updateDeviceID(
    pAdresaEmail: prefs.getString(pref_keys.userEmail) ?? "User has not registered yet!",
    pFirebaseGoogleDeviceID: prefs.getString(pref_keys.fcmToken)!,
    pParolaMD5: prefs.getString(pref_keys.userPassMD5) ?? "User has not registered yet!",
  );
  if (res == null) {
    print("Error: Could not save token!");
    return;
  } else if (res.startsWith('66')) {
    print("Error: Could not save token!");
    return;
  } else if (res.startsWith('13')) {
    print("Succes, token saved!");
    return;
  } else {
    print("Unkown error saving token!");
    return;
  }
}

class FirebaseApi {
  late Stream<String> _tokenStream;
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    final fcmToken = await firebaseMessaging.getToken() ?? "Error: Could not retrieve token!";
    saveTokenToDB(fcmToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(saveTokenToDB);
    print('Token: $fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
