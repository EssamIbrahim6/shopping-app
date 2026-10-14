import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_strings.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(hintText:AppStrings.searchProductsHint ),
      onChanged: onChanged,
    );
  }
}
