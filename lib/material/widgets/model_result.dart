import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_disease_fighter/material/inductors/arc_inductor.dart';
import '../constants.dart';

class ModelResult extends StatefulWidget {
  final firstDiseaseValue;
  final secondDiseaseValue;
  final thirdDiseaseValue;

  final result ;
  ModelResult(
      { this.firstDiseaseValue,
       this.secondDiseaseValue,
       this.thirdDiseaseValue, this.result});

  @override
  _ModelResultState createState() => _ModelResultState();
}

class _ModelResultState extends State<ModelResult> {
  _diseaseResult() {
    const diseaseResultTime = Duration(milliseconds: 30);
     Timer.periodic(diseaseResultTime, (Timer t1) {
      if (_firstDiseaseValue < (widget.result['prediction_result'][0]['percentage'].toDouble()) /100) {
        setState(() {
          _firstDiseaseValue += 0.01;
        });
      }else{
        t1.cancel();
      }
    });
     Timer.periodic(diseaseResultTime, (Timer t) {

      if (_secondDiseaseValue <  (widget.result['prediction_result'][1]['percentage'].toDouble()) /100) {
        setState(() {
          _secondDiseaseValue += 0.01;
        });
      }else{
        t.cancel();
      }
    });
     Timer.periodic(diseaseResultTime, (Timer t) {
      if (_thirdDiseaseValue <  (widget.result['prediction_result'][2]['percentage'].toDouble()) /100) {
        setState(() {
          _thirdDiseaseValue += 0.01;
        });
      }else{
        t.cancel();
      }
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
      // height: 170,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
      decoration: BoxDecoration(
        color: lightGreyColor.withOpacity(.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ArcIndicator(
              child: Text("${(_firstDiseaseValue * 100).toInt()} %",
                  style: progressTextStyle),
              progressValue: _firstDiseaseValue,
              dimensions: MediaQuery.of(context).size.width * .24,
              bgColor: Colors.white,
              label: widget.result['prediction_result'][0]['type'] ,
            ),
            ArcIndicator(
              child: Text("${(_secondDiseaseValue * 100).toInt()} %",
                  style: progressTextStyle),
              progressValue: _secondDiseaseValue,
              dimensions: MediaQuery.of(context).size.width * .25,
              bgColor: Colors.white,
              label: widget.result['prediction_result'][1]['type'] ,
            ),
            ArcIndicator(
              child: Text("${(_thirdDiseaseValue * 100).toInt()} %",
                  style: progressTextStyle),
              progressValue: _thirdDiseaseValue,
              dimensions: MediaQuery.of(context).size.width * .25,
              bgColor: Colors.white,
              label: widget.result['prediction_result'][2]['type'] ,

            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _diseaseResult();
  }
}
