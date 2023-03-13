import 'package:flutter/material.dart';
import 'package:sekolah_ku/widgets/input.dart';

class SampleExpandedRowPage extends StatelessWidget {
  const SampleExpandedRowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // header
      appBar: AppBar( 
        title: const Text("Expanded Column Widget"),
      ),
      // body
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InputField(
                label: "Satu",
                textInputType: TextInputType.text,
                validator: (x) {},
              ),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: InputField(
                label: "Satu",
                textInputType: TextInputType.text,
                validator: (x) {},
              ),
            ),
          ],
        ),
      )
    );
  }
}