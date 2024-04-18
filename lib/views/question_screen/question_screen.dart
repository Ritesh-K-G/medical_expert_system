import 'package:flutter/material.dart';

class question_screen extends StatefulWidget {
  @override
  _question_screen createState() => _question_screen();
}

class _question_screen extends State<question_screen> {
  int _selectedIndex = -1; // Variable to keep track of selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Implement back button functionality here
          },
        ),
        title: Text('Title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Implement button functionality here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ExpansionTile(
              leading: Radio(
                value: index,
                groupValue: _selectedIndex,
                onChanged: (int? value) {
                  setState(() {
                    _selectedIndex = value!;
                  });
                },
              ),
              title: Text('Item $index'),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Description of item $index',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}