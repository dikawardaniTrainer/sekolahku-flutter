
import 'package:flutter/material.dart';

class SampleMappingDataToWidgetPage extends StatelessWidget {
  const SampleMappingDataToWidgetPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    const data = ["Dika Wardani", 24, 65.98];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Mapping Data To Widget"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.map((e) => Text(e.toString()))
            .toList(),
      ),
    );
  }
}