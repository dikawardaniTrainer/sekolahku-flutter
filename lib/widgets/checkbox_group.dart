import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';

class CheckboxOption {
  var value = false;
  var title = StringRes.emptyString;

  CheckboxOption({
    required this.value,
    required this.title
  });

  static List<CheckboxOption> toCheckBoxOptions(List<String> options) {
    return options.map((e) => CheckboxOption(value: false, title: e))
      .toList();
  }
}

class CheckBoxGroup extends StatefulWidget {
  final double marginTop;
  final List<String> options;
  final String label;
  final ValueChanged<List<String>> onChanged;
  final List<String> selectedOptions;

  const CheckBoxGroup({
    super.key,
    required this.label,
    required this.options,
    required this.onChanged,
    this.selectedOptions = const [],
    this.marginTop = 0,
  });

  @override
  State<CheckBoxGroup> createState() => _CheckBoxGroupState();
}

class _CheckBoxGroupState extends State<CheckBoxGroup> {
  List<CheckboxOption> _checkBoxOptions = [];

  void updateSelectedOptions(bool isSelected, int pos, String value) {
    final selectedOptions = widget.selectedOptions;

    setState(() {
      _checkBoxOptions[pos].value = isSelected;
    });

    if (isSelected) {
      if (!selectedOptions.contains(value)) {
        widget.selectedOptions.add(value);
      }
    } else {
      if (selectedOptions.contains(value)) {
        widget.selectedOptions.remove(value);
      }
    }

    widget.onChanged.call(widget.selectedOptions);
  }

  List<Widget> _createCheckBoxes() {
    final List<Widget> checkBoxes = [];

    for( var i = 0 ; i < widget.options.length; i++ ) {
      if (widget.selectedOptions.contains(_checkBoxOptions[i].title)) {
        _checkBoxOptions[i].value = true;
      }

      final checkBox = InkWell(
        onTap: () {
          final current = _checkBoxOptions[i].value;
          updateSelectedOptions(!current, i, _checkBoxOptions[i].title);
        },
        child: Row(
          children: [
            Checkbox(
              value: _checkBoxOptions[i].value,
              onChanged: (s) {
                if (s != null) {
                  updateSelectedOptions(s, i,_checkBoxOptions[i].title);
                }
              },
            ),
            Text(_checkBoxOptions[i].title)
          ],
        ),
      );
      checkBoxes.add(checkBox);
    }

    return checkBoxes;
  }

  @override
  void initState() {
    super.initState();
    _checkBoxOptions = CheckboxOption.toCheckBoxOptions(widget.options);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    if (widget.marginTop > DimenRes.size_0) widgets.add(SizedBox(height: widget.marginTop));
    widgets.add(Text(widget.label, style: const TextStyle(fontSize: DimenRes.size_16)));
    widgets.add(const SizedBox(height: DimenRes.size_8));
    widgets.addAll(_createCheckBoxes());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}