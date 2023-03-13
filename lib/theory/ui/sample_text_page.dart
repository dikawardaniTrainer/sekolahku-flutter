import 'package:flutter/material.dart';

class SampleTextPage extends StatelessWidget {
  const SampleTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Text View"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Hello world"),
          Text(
            "Hello guys",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Itim'
            ),
          )
        ],
      ),
    );
  }
}
