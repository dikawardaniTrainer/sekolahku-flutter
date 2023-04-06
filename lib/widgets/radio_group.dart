import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';

enum RadioOrientation {
  horizontal,
  vertical
}

class RadioGroup extends StatefulWidget {
  final RadioOrientation orientation;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final String label;
  final double marginTop;
  final TextEditingController controller;

  const RadioGroup({
    super.key,
    required this.options,
    required this.onChanged,
    required this.label,
    required this.controller,
    this.orientation = RadioOrientation.horizontal,
    this.marginTop = DimenRes.size_0
  });

  @override
  State<RadioGroup> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {

  void _updateSelectedOption(String newValue) {
    setState(() {
      widget.controller.text = newValue;
      widget.onChanged.call(newValue);
    });
  }

  Widget _createHorizontal() {
    return Row(
      children: widget.options.map((e) => Expanded(child: InkWell(
        onTap: () {
          final index = widget.options.indexOf(e);
          _updateSelectedOption(widget.options[index]);
        },
        child: ListTile(
          title: Text(e),
          leading: Radio<String>(
            value: e,
            groupValue: widget.controller.text,
            onChanged: (s) {
              if (s != null) {
                _updateSelectedOption(s);
              }
            },
          ),
        ),
      ))).toList(),
    );
  }

  Widget _createVertical() {
    return Column(
      children: widget.options.map((e) => InkWell(
        onTap: () {
          final index = widget.options.indexOf(e);
          _updateSelectedOption(widget.options[index]);
        },
        child: ListTile(
            title: Text(e),
            leading: Radio<String>(
              value: e,
              groupValue: widget.controller.text,
              onChanged: (s) {
                if (s != null) {
                  _updateSelectedOption(s);
                }
              },
            )
        ),
      )).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    // if (widget.controller.text.isEmpty) {
    //   widget.controller.text = widget.options.first;
    // }
  }

  @override
  Widget build(BuildContext context) {
    Widget options;
    if (widget.orientation == RadioOrientation.horizontal) {
      options = _createHorizontal();
    } else {
      options = _createVertical();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.marginTop > DimenRes.size_0) SizedBox(height: widget.marginTop,),
        Text(widget.label, style: const TextStyle(fontSize: DimenRes.size_16)),
        const SizedBox(height: DimenRes.size_8),
        options
      ],
    );
  }
}