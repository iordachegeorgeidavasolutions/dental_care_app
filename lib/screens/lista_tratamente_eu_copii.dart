// ignore_for_file: avoid_print
import 'package:dental_care_app/screens/programari.dart';
import 'package:dental_care_app/screens/tratamente.dart';
import 'package:dental_care_app/utils/functions.dart';
import 'package:flutter/material.dart';
import '../utils/classes.dart';
import '../widgets/modals/user_modal.dart';
import '../utils/api_call_functions.dart';

class ListaTratamenteEuCopii extends StatefulWidget {
  const ListaTratamenteEuCopii({super.key});

  @override
  State<ListaTratamenteEuCopii> createState() => _ListaTratamenteEuCopiiState();
}

class _ListaTratamenteEuCopiiState extends State<ListaTratamenteEuCopii> {
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
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => TratamenteScreen(idCopil: '-1',)));
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TratamenteScreen()));
                        }, child: Text('Tratamentele mele')),
                        for(int i = 0; i < Shared.familie.length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: (){
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => TratamenteScreen(idCopil: Shared.familie[i].id,)));
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TratamenteScreen()));
                              }, 
                                child: Text('Tratamentele lui ${Shared.familie[i].nume.capitalizeFirst()} ${Shared.familie[i].prenume.capitalizeFirst()}')),
                            ],
                          ),
                        ],
                    )  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
