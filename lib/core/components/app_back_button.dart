import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

import '../constants/constants.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(AppIcons.arrowBackward),
      onPressed: () {
    }

    );
  }
}
