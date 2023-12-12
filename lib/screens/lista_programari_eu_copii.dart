// ignore_for_file: avoid_print
import 'package:dental_care_app/screens/programari.dart';
import 'package:dental_care_app/utils/functions.dart';
import 'package:flutter/material.dart';
import '../utils/classes.dart';
import '../widgets/modals/user_modal.dart';
import '../utils/api_call_functions.dart';

class ListaProgramariEuCopii extends StatefulWidget {
  const ListaProgramariEuCopii({super.key});

  @override
  State<ListaProgramariEuCopii> createState() => _ListaProgramariEuCopiiState();
}

class _ListaProgramariEuCopiiState extends State<ListaProgramariEuCopii> {
  ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  

  @override
  void initState() {
    
    super.initState();
    //programari = getListaProgramari();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(leading: Icon(icon)),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children:[
                      ElevatedButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProgramariScreen()));
                      }, child: Text('Programarile mele')),
                      for(int i = 0; i < Shared.familie.length; i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProgramariScreen()));
                            }, 
                              child: Text('Programarile lui ${Shared.familie[i].nume.capitalizeFirst()} ${Shared.familie[i].prenume.capitalizeFirst()}')),
                          ],
                        ),
                      ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
