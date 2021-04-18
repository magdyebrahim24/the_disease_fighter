import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  CircleButton({
    required this.icn,
    required this.fun,
    required this.color,
  });

  final IconData icn;
  final fun;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 3.0,
      hoverElevation: 5.0,
      padding: EdgeInsets.all(10),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 40,
      height: 45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      onPressed: fun,
      child: Icon(
        icn,
        color: color,
      ),
    );
  }
}

class ImgButton extends StatelessWidget {
  ImgButton({
    this.img,
    this.fun,
    this.imgWidth,
    this.imgHigh,
  });

  final img;
  final fun;
  final imgWidth;
  final imgHigh;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 3.0,
      hoverElevation: 5.0,
      padding: EdgeInsets.all(10),
      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 40,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      onPressed: fun,
      child: Image.asset(
        img,
        width: imgWidth,
        height: imgHigh,
      ),
    );
  }
}
