import 'package:flutter/material.dart';
import 'package:medical_expert_system/utils/styles/text.dart';

class question_screen extends StatefulWidget {
  @override
  _question_screen createState() => _question_screen();
}

class _question_screen extends State<question_screen> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Back to Home', style: AppTextStyles.appBarText),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose the symptom you are affected with',
              softWrap: true,
              style: AppTextStyles.questionText,
            ),
            const SizedBox(height: 15),
            Expanded(
                child: ListView.builder(
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
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Description of item $index',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
            )
          ],
        ),
      )
    );
  }
}