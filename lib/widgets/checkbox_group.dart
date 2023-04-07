import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';

class CheckBoxController extends ValueNotifier<List<String>> {
  List<String> options;

  CheckBoxController(this.options, super.value);

  void clear() {
    value = [];
  }
}

class CheckBoxGroup extends StatefulWidget {
  final double marginTop;
  final String label;
  final CheckBoxController controller;

  const CheckBoxGroup({
    super.key,
    required this.label,
    required this.controller,
    this.marginTop = 0,
  });

  @override
  State<CheckBoxGroup> createState() => _CheckBoxGroupState();
}

class _CheckBoxGroupState extends State<CheckBoxGroup> {
  void _updateSelectedOptions(bool isSelected, String value) {
    final selectedOptions = widget.controller.value;

    if (isSelected) {
      if (!selectedOptions.contains(value)) {
        selectedOptions.add(value);
      }
    } else {
      if (selectedOptions.contains(value)) {
        selectedOptions.remove(value);
      }
    }

    setState(() {
      widget.controller.value = selectedOptions;
    });
  }

  List<Widget> _createCheckboxes(List<String> options) {
    return options.map((option) => InkWell(
      onTap: () {
        final lastSelected = widget.controller.value.contains(option);
        _updateSelectedOptions(!lastSelected, option);
      },
      child: Row(
        children: [
          Checkbox(
            value: widget.controller.value.contains(option),
            onChanged: (selected) {
              if (selected != null) {
              _updateSelectedOptions(selected, option);
            }
          }),
          Text(option)
        ],
      ),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (widget.marginTop > DimenRes.size_0) widgets.add(SizedBox(height: widget.marginTop));
    widgets.add(Text(widget.label, style: const TextStyle(fontSize: DimenRes.size_16)));
    widgets.add(const SizedBox(height: DimenRes.size_8));
    widgets.addAll(_createCheckboxes(widget.controller.options));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}