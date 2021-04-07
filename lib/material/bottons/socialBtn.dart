import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  SocialButton({this.iconColor, this.icon, this.onTap});

  final iconColor;
  final icon;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: MaterialButton(
        padding: EdgeInsets.all(17),
        color: Colors.white,
        elevation: 3.5,
        hoverElevation: 5.0,
        minWidth: 54,
        height: 54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        onPressed: onTap,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
