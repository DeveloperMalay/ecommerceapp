import 'package:ecommerceapp/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'An error occur',
    content: text,
    optionBuilder: () => {'OK': null},
  );
}
