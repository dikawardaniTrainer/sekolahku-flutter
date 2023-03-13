import 'package:flutter/material.dart';
import 'package:sekolah_ku/theory/ui/sample_button_page.dart';
import 'package:sekolah_ku/theory/ui/sample_expanded_column_page.dart';
import 'package:sekolah_ku/theory/ui/sample_expanded_row_page.dart';
import 'package:sekolah_ku/theory/ui/sample_icon_page.dart';
import 'package:sekolah_ku/theory/ui/sample_mapping_data_to_widget.dart';
import 'package:sekolah_ku/theory/ui/sample_stack_page.dart';
import 'package:sekolah_ku/theory/ui/sample_text_page.dart';
import 'package:sekolah_ku/theory/ui/sample_textfield_page.dart';
import 'package:sekolah_ku/theory/ui/sample_textformfield_page.dart';
import 'package:sekolah_ku/theory/ui/sample_wrap_page.dart';

void main() {
  runApp(const SampleUIApp());
}

class SampleUIApp extends StatelessWidget {
  const SampleUIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sample Text",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Poppins'
      ),
      home: const SampleMappingDataToWidgetPage(),
      // home: const SampleStackPage(),
      // home: const SampleExpandedRowPage(),
      // home: const SampleExpandedColumnPage(),
      // home: const SampleWrapPage(),
      // home: const SampleButtonPage(),
      // home: const SampleIconPage(),
      // home: const SampleTextFormFieldPage(),
      // home: const SampleTextFieldPage(),
      // home: const SampleTextPage(),
    );
  }
}