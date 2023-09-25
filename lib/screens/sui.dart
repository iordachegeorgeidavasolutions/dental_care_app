import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _items = ['Item 1', 'Item 2', 'Item 3'];
  List<bool> _isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toggle Button Example'),
      ),
      body: Column(
        children: [
          ToggleButtons(
            children: [
              Icon(Icons.looks_one),
              Icon(Icons.looks_two),
              Icon(Icons.looks_3),
            ],
            isSelected: _isSelected,
            onPressed: (index) {
              setState(() {
                _isSelected[index] = !_isSelected[index];
              });
            },
          ),
          Visibility(
            visible: _isSelected[0],
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_items[index]),
                );
              },
            ),
          ),
          Visibility(
            visible: _isSelected[1],
            child: Text('Different list for toggle button 2'),
          ),
          Visibility(
            visible: _isSelected[2],
            child: Text('Different list for toggle button 3'),
          ),
        ],
      ),
    );
  }
}
