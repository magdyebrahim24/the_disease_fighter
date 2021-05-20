import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: must_be_immutable
class ErrorMaterialBanner extends StatelessWidget {
  final errorMessage;
  final fun;
  ErrorMaterialBanner({this.errorMessage, this.fun});

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      forceActionsBelow: true,
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 10),
      contentTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      content: Text(
        errorMessage.toString(),
      ),
      leading: Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
      backgroundColor: darkBlueColor.withOpacity(.8),
      actions: <Widget>[
        MaterialButton(
          onPressed: fun,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Text(
            'OK',
            style: TextStyle(color: darkBlueColor),
          ),
        ),
      ],
    );
  }
}
