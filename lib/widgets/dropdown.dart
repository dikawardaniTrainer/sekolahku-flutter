import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/widgets/input.dart';

class DropDown<T> extends StatefulWidget {
  final DropDownController<T> controller;
  final double marginTop;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final String label;
  final FormFieldValidator<T>? validator;
  final OnDrawItem<T> onDrawItem;

  const DropDown({
    super.key,
    required this.options,
    required this.onChanged,
    required this.controller,
    required this.label,
    required this.onDrawItem,
    this.marginTop = DimenRes.size_0,
    this.validator
  });

  @override
  State<DropDown<T>> createState() => _DropDownState<T>();
}

class _DropDownState<T> extends State<DropDown<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.options.isNotEmpty) {
      widget.controller.value ??= widget.options.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.marginTop > DimenRes.size_0)
          SizedBox(
            height: widget.marginTop,
          ),
        if (widget.options.isNotEmpty)
          DropdownButtonFormField<T>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            value: widget.controller.value,
            decoration: InputDecoration(
                labelText: widget.label,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(DimenRes.size_16))
            ),
            items: widget.options
                .map((e) => DropdownMenuItem<T>(value: e, child: widget.onDrawItem(e)))
                .toList(),
            onChanged: (s) {
              if (s != null) {
                widget.controller.value = s;
                widget.onChanged.call(s);
              }
            },
          ),
        if (widget.options.isEmpty)
          InputField(
            label: widget.label,
            textInputType: TextInputType.none,
            readOnly: true,
            enabled: false,
          )
      ],
    );
  }
}

class DropDownController<T> extends ValueNotifier<T> {
  late T initValue;

  DropDownController(super.value) {
    initValue = value;
  }

  void clear() {
    value = initValue;
  }
}

typedef OnDrawItem<T> = Widget Function(T item);