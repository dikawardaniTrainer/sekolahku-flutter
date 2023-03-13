import 'package:flutter/material.dart';

class SampleStackPage extends StatelessWidget {
  const SampleStackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // header
      appBar: AppBar( 
        title: Text("Stack Widget"),
      ),
      // body
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.blue,
            width: 300,
            height: 300,
          ),
          Container(
            color: Colors.yellow,
            width: 200,
            height: 200,
          ),
          Container(
            color: Colors.green,
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}