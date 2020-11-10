import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenicos_nextline/utils/app_colors.dart';
import 'package:tenicos_nextline/widgets/jbutton.dart';

Future<void> showConfirmationDialog(context, yesAction, noAction,
    {title = const Text("Confirmación"),
    content = const Text("¿Está seguro?")}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _showDialogAndroid(context, 'Sí', yesAction),
                _showDialogAndroid(context, 'No', noAction)
              ])
            ],
          ),
        ),
      );
    },
  );
}

Widget _showDialogAndroid(context, option, yesNoAction) {
  return JButton(
      label: option,
      background: AppColors.ligth_blue_color,
      buttonHeight: 40,
      minWidth: 100,
      padding: EdgeInsets.all(10),
      onTab: () {
        Navigator.pop(context);
        yesNoAction();
      });
}
