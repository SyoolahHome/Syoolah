import 'package:flutter/material.dart';

import '../../../constants/strings.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: AppStrings.searchUsersHint,
      ),
    );
  }
}
