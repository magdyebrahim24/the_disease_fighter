import 'package:flutter/material.dart';

import '../constants.dart';

class FlatBTN extends StatelessWidget {
  final txt;

  final Function fun;

  const FlatBTN({this.txt, required this.fun});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: fun(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        txt,
        style: TextStyle(color: subTextColor, fontSize: 14),
      ),
    );
  }
}
