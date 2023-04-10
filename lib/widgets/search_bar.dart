import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';

import '../resources/string_res.dart';
import 'icon_back_button.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String>? onValueChanged;
  final TextEditingController controller;
  final VoidCallback onClearTapped;

  const SearchBar({
    super.key,
    this.onValueChanged,
    required this.controller,
    required this.onClearTapped
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(DimenRes.size_16)),
        child: TextField(
          style: const TextStyle(color: ColorRes.black),
          onSubmitted: widget.onValueChanged,
          onChanged: widget.onValueChanged,
          controller: widget.controller,
          decoration: InputDecoration(
              prefixIcon: const IconBackButton(iconColor: ColorRes.teal),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: ColorRes.teal),
                onPressed: () {
                  widget.controller.text = StringRes.emptyString;
                  widget.onClearTapped.call();
                },
              ),
              hintText: 'Search...',
              border: InputBorder.none
          ),
        )
    );
  }
}