import 'package:flutter/material.dart';
import '../constants.dart';
class BottomSheetItem extends StatelessWidget {
  final label;
  final icon;
  final fun;

  const BottomSheetItem({
    this.label,
    this.icon,
    this.fun,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 40, bottom: 10),
      onTap: fun,
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: backGroundColor, borderRadius: BorderRadius.circular(10)),
        child: Icon(
          icon,
          color: darkBlueColor,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
            color: darkBlueColor, fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
