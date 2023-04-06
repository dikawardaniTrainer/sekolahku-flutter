import 'package:flutter/material.dart';
import 'package:sekolah_ku/constant/student_const.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/widgets/button.dart';
import 'package:sekolah_ku/widgets/dropdown.dart';
import 'package:sekolah_ku/widgets/input_education.dart';
import 'package:sekolah_ku/widgets/radio_gender.dart';
import 'package:sekolah_ku/widgets/title_text.dart';

typedef OnApplyCallback = void Function(String? education, String? gender);

class DialogFilterStudent extends StatelessWidget {
  final VoidCallback onCancel, onReset;
  final OnApplyCallback onApply;
  final DropDownController<String> _educationCtrl = DropDownController<String>(educationOptions[0]);
  final TextEditingController _genderCtrl = TextEditingController();

  DialogFilterStudent({
    super.key,
    required this.onCancel,
    required this.onApply,
    required this.onReset,
    String? lastSelectedGender,
    String? lastSelectedEducation,
  }) {
    if (lastSelectedGender != null && lastSelectedGender.isNotEmpty) {
      _genderCtrl.value = TextEditingValue(text: lastSelectedGender);
    }
    if (lastSelectedEducation != null && lastSelectedEducation.isNotEmpty) {
      _educationCtrl.value = lastSelectedEducation;
    }
  }

  void _applyFilter() {
    String? selectedEducation, selectedGender;
    if (_educationCtrl.value != educationOptions[0]) {
      selectedEducation = _educationCtrl.value;
    }
    if (_genderCtrl.value.text.isNotEmpty) {
      selectedGender = _genderCtrl.value.text;
    }
    onApply.call(selectedEducation, selectedGender);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DimenRes.size_16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(label: StringRes.filter, color: Colors.teal,),
          const SizedBox(height: DimenRes.size_8,),
          const Divider(height: DimenRes.size_1, color: ColorRes.teal,),
          InputEducation(
            controller: _educationCtrl,
            marginTop: DimenRes.size_20,
          ),
          RadioGenderFilter(
            controller: _genderCtrl,
            marginTop: DimenRes.size_16,
          ),
          const SizedBox(height: DimenRes.size_16),
          Row(
            children: [
              Expanded(
                child: Button(
                  label: StringRes.apply,
                  marginTop: DimenRes.size_16,
                  onPressed: () => _applyFilter()
                )
              ),
              const SizedBox(width: DimenRes.size_8,),
              if (_educationCtrl.value != educationOptions[0] || _genderCtrl.text.isNotEmpty) Expanded(
                child: Button(
                  label: StringRes.resetFilter,
                  marginTop: DimenRes.size_16,
                  onPressed: onReset
                )
              )
            ],
          ),
          Button(label: StringRes.cancel, marginTop: DimenRes.size_16, backgroundColor: ColorRes.red, onPressed: onCancel),
        ],
      ),
    );
  }
}