import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/material/constants.dart';
class EmptyListWidget extends StatelessWidget {
  final icon;
  final iconSize;
  final label ;
  final iconColor ;
  final labelColor;

  EmptyListWidget({ this.icon, this.iconSize, this.label, this.iconColor ,  this.labelColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          icon ?? FontAwesomeIcons.folderOpen,
          color: iconColor ?? darkBlueColor.withOpacity(.2),
          size: iconSize.toDouble() ??  70.0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            label ?? 'Empty List',
            style:
            TextStyle(color: labelColor ?? darkBlueColor.withOpacity(.4), fontSize: 20),
          ),
        )
      ]),
    );
  }
}
