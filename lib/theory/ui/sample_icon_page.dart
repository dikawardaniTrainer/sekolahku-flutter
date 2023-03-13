import 'package:flutter/material.dart';

class SampleIconPage extends StatelessWidget {
  const SampleIconPage({super.key});

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
          children: const [
            Icon(
              Icons.confirmation_num,
              size: 100,
            ),
            Icon(
              Icons.confirmation_num_outlined,
              size: 50,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
