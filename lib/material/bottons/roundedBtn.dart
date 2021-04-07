import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.fun, this.text, this.minWdthRatio = .9, this.borderRadious = 10});

  @required
  final String text;
  final Function fun;
  final minWdthRatio;
  final double borderRadious;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: primaryColor,
      minWidth: MediaQuery.of(context).size.width * minWdthRatio,
      height: 50,
      // padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
      splashColor: primaryColor.withOpacity(.65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadious),
      ),
      onPressed: fun,
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
