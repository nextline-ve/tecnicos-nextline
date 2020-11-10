import 'package:flutter/material.dart';
import 'package:tenicos_nextline/utils/app_colors.dart';
import 'package:tenicos_nextline/utils/app_session.dart';
import 'package:tenicos_nextline/widgets/confirmation_modal.dart';

class ExitApp {

  static Widget exitFromAppButton(context) {
    return GestureDetector(
        onTap: () => showConfirmationExit(context),
        child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              color: AppColors.blue_dark,
              borderRadius: BorderRadius.circular(10),
            )));
  }

  static void exitFromApp(context) {
    AppSession()
        .unregister()
        .then((value) => Navigator.pushNamed(context, '/login'));
  }

  static void showConfirmationExit(context) {
    showConfirmationDialog(context, () => exitFromApp(context), () => {},
        title: Text("Cerrar Sesión"),
        content: Text("¿Está seguro de que desea salir?"));
  }
}
