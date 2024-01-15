import 'package:flutter/material.dart';
import '../data/locatii_data.dart';
import '../widgets/modals/locatii_modal.dart';

class LocatiiScreen extends StatefulWidget {

  const LocatiiScreen({super.key});

  @override
  State<LocatiiScreen> createState() => _LocatiiScreenState();
}

class _LocatiiScreenState extends State<LocatiiScreen> {
  var _selectedIndex = 0;


  @override
  void initState() {
    super.initState();

    //myControllerProgramari = PageController(initialPage: 1);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            // child: Row(
            //   children: [
            //     IconButton(
            //         onPressed: () => Navigator.pop(context),
            //         icon: Icon(
            //           Icons.arrow_back_ios_new_rounded,
            //           size: 30,
            //         ))
            //   ],
            // ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
            child: logoTitle(),
          ),
          locatiiTiles(),
        ]),
      ),
    );
  }

  Row logoTitle() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Image.asset(
          //   './assets/images/person-icon.jpg',
          //   height: 40,
          // ),
          SizedBox(
            height: 20,
          ),
          Text('Locații', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
        ]),
      ],
    );
  }

  ListView locatiiTiles() {
    return ListView.builder(
        itemCount: locatiiList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: InkWell(
              onTap: () {
                setState(() => _selectedIndex = index);
                modalBottomSheet(context, index);
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locatiiList[index].nume,
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> modalBottomSheet(BuildContext context, selectedIndex) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      context: context,
      builder: (context) {
        return LocatiiModal(
          selectedIndex: _selectedIndex,
        );
      },
    );
  }
}
