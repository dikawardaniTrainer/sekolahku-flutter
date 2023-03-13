import 'package:flutter/material.dart';

class SampleTextFieldPage extends StatelessWidget {
  const SampleTextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample TextField"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(label: Text("Email in here")),
            ),
            SizedBox(height: 20),
            TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text(
                    "Label",
                    style: TextStyle(color: Colors.red),
                  ),
                  border: OutlineInputBorder(),
                ))
          ],
        ),
      ),
    );
  }
}
