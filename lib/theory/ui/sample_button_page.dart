import 'package:flutter/material.dart';

class SampleButtonPage extends StatelessWidget {
  const SampleButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Icon"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () {
                  print("Text button clicked");
                },
                child: const Text("Hit me")),
            ElevatedButton(
                onPressed: () {
                  print("Elevated button clicked");
                },
                child: const Text("Hitme")),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                  side: const BorderSide(color: Colors.red, width: 1)
                ),
                onPressed: () {
                  print("Outlined button clicked");
                },
                child: const Text("hit me"))
          ],
        ),
      ),
    );
  }
}
