import 'package:flutter/material.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/widgets/search_bar.dart';

import '../widgets/student_list.dart';

class StudentSearchPage extends StatefulWidget {
  const StudentSearchPage({
    super.key
  });

  @override
  State<StudentSearchPage> createState() => _StudentSearchPageState();
}

class _StudentSearchPageState extends State<StudentSearchPage> {
  final _studentService = AppService.studentService;
  final _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          controller: _searchCtrl,
          onValueChanged: (s) { setState(() {}); },
          onClearTapped: () { setState(() {}); },
        ),
        automaticallyImplyLeading: false,
      ),
      body: StudentList(
        onFetchingData: () => _studentService.findByName(_searchCtrl.text),
      )
    );
  }
}