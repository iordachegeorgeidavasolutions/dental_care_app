import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../data/locatii_data.dart';
import 'package:maps_launcher/maps_launcher.dart';

class LocatiiModal extends StatelessWidget {
  final int selectedIndex;
  const LocatiiModal({super.key, required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context)),
              Expanded(
                child: Center(
                  child: Text(
                    locatiiList[selectedIndex].nume,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ]),
            const Divider(
              thickness: 2,
              color: Colors.black26,
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                const Row(children: [Text('Nr. contact', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20))]),
                const SizedBox(height: 10),
                Row(children: [
                  SelectableText(
                    locatiiList[selectedIndex].telefon,
                    style: const TextStyle(color: Colors.red, fontSize: 25, fontWeight: FontWeight.w700),
                    onTap: () async {
                      final Uri url = Uri(
                        scheme: 'tel',
                        path: locatiiList[selectedIndex].telefon,
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        print("Cannot launch!");
                      }
                    },
                  )
                ]),
                const SizedBox(height: 20),
                const Row(children: [Text('Adresa', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20))]),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                    child: Text(locatiiList[selectedIndex].adresa,
                        maxLines: 2,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w400, fontSize: 20)),
                  )
                ]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        backgroundColor: Colors.red,
                        // minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      onPressed: () => MapsLauncher.launchQuery(locatiiList[selectedIndex].maps),
                      child: const Text(
                        'Harta',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
