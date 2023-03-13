import 'package:flutter/material.dart';

class SampleExpandedColumnPage extends StatelessWidget {
  const SampleExpandedColumnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // header
      appBar: AppBar( 
        title: const Text("Expanded Column Widget"),
      ),
      // body
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
          Expanded(
            child: Container(
              color: Colors.yellow,
              width: 100,
            ),
          ),
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}