import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_disease_fighter/material/inductors/arc_inductor.dart';

import '../constants.dart';

class ModelResult extends StatefulWidget {
  final firstDiseaseValue;
  final secondDiseaseValue;
  final thirdDiseaseValue;

  ModelResult(
      {@required this.firstDiseaseValue,
      @required this.secondDiseaseValue,
      @required this.thirdDiseaseValue});

  @override
  _ModelResultState createState() => _ModelResultState();
}

class _ModelResultState extends State<ModelResult> {
  _diseaseResult() {
    const diseaseResultTime = Duration(milliseconds: 45);
    new Timer.periodic(diseaseResultTime, (Timer t1) {
      setState(() {
        _firstDiseaseValue += 0.01;
      });
      if (_firstDiseaseValue > widget.firstDiseaseValue) {
        t1.cancel();
      }
      return;
    });
    new Timer.periodic(diseaseResultTime, (Timer t) {
      setState(() {
        _secondDiseaseValue += 0.01;
      });

      if (_secondDiseaseValue > widget.secondDiseaseValue) {
        t.cancel();
      }
      return;
    });
    new Timer.periodic(diseaseResultTime, (Timer t) {
      setState(() {
        _thirdDiseaseValue += 0.01;
      });
      if (_thirdDiseaseValue > widget.thirdDiseaseValue) {
        t.cancel();
      }
      return;
    });
  }

  @override
  void initState() {
    super.initState();
    _diseaseResult();
  }

  double _firstDiseaseValue = 0.0;
  double _secondDiseaseValue = 0.0;
  double _thirdDiseaseValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(15),
      height: 170,
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: lightGreyColor.withOpacity(.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ArcIndicator(
            child: Text("${(_firstDiseaseValue * 100).toInt()} %",
                style: progressTextStyle),
            progressValue: _firstDiseaseValue,
            dimensions: MediaQuery.of(context).size.width * .25,
            bgColor: Colors.white,
          ),
          ArcIndicator(
            child: Text("${(_secondDiseaseValue * 100).toInt()} %",
                style: progressTextStyle),
            progressValue: _secondDiseaseValue,
            dimensions: MediaQuery.of(context).size.width * .25,
            bgColor: Colors.white,
          ),
          ArcIndicator(
            child: Text("${(_thirdDiseaseValue * 100).toInt()} %",
                style: progressTextStyle),
            progressValue: _thirdDiseaseValue,
            dimensions: MediaQuery.of(context).size.width * .25,
            bgColor: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _diseaseResult();
  }
}
