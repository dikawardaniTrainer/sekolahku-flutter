import 'package:flutter/material.dart';

class SampleWrapPage extends StatelessWidget {
  const SampleWrapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // header
      appBar: AppBar(
        title: Text("Wrap Widget"),
      ),
      // body
      body: Wrap(
        children: <Widget>[
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
            margin: EdgeInsets.only(bottom: 5, right: 5),
          ),
          Container(
            color: Colors.yellow,
            width: 100,
            height: 100,
            margin: EdgeInsets.only(bottom: 5, right: 5),
          ),
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
            margin: EdgeInsets.only(bottom: 5, right: 5),
          ),
          Container(
            color: Colors.yellow,
            width: 100,
            height: 100,
            margin: EdgeInsets.only(bottom: 5, right: 5),
          ),
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
            margin: EdgeInsets.only(bottom: 5, right: 5),
          ),
          Container(
            color: Colors.yellow,
            width: 100,
            height: 100,
            margin: EdgeInsets.only(bottom: 5, right: 5),
          ),
        ],
      ),
    );
  }
}