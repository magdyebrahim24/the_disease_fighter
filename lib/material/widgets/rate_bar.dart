import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  final rateValue;

  final Color? clr;

  const Rate({this.rateValue, this.clr});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          i < rateValue
              ? Icon(
                  Icons.star,
                  size: 13,
                  color: clr,
                )
              : Icon(
                  Icons.star_border,
                  size: 14,
                  color: clr,
                ),
      ],
    );
  }
}