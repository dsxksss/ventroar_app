import 'package:flutter/material.dart';
import 'package:ventroar_app/functions/vent_bottom_sheet.dart';

class HomeFloatButton extends StatelessWidget {
  const HomeFloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        vBottomSheet(context: context);
      },
      child: const Icon(Icons.edit),
    );
  }
}
