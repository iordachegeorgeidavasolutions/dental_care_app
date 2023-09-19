import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'image_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Image Picker';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      /// Alternatively save picked image permanently
      //final imagePermanent = await saveImagePermanently(image.path);
      //setState(() => this.image = imagePermanent);

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.amber.shade300,
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Spacer(),
              image != null
                  ? ImageWidget(
                      image: image!,
                      onClicked: (source) => pickImage(source),
                    )
                  : FlutterLogo(size: 160),
              const SizedBox(height: 24),
              Text(
                'Image Picker',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              buildButton(
                title: 'Pick Gallery',
                icon: Icons.image_outlined,
                onClicked: () => pickImage(ImageSource.gallery),
              ),
              const SizedBox(height: 24),
              buildButton(
                title: 'Pick Camera',
                icon: Icons.camera_alt_outlined,
                onClicked: () => pickImage(ImageSource.camera),
              ),
              Spacer(),
            ],
          ),
        ),
      );

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(56),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
        onPressed: onClicked,
      );
}
