import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/bottom_sheet_item.dart';
import 'package:the_disease_fighter/material/widgets/model_result.dart';

class ModelScreen extends StatefulWidget {
  @override
  _ModelScreenState createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen> {
  int _show = 0;
  File? _pickerImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.getImage(source: src);
    if (pickedImageFile != null) {
      if (!mounted) return;
      setState(() {
        _pickerImage = File(pickedImageFile.path);
      });
    } else {
      print('No Image Selected');
    }
  }

  int _dotsValue = 0;

  void _updateDots() {
    const dotTime = const Duration(milliseconds: 500); //850 second
    Timer.periodic(dotTime, (Timer t) {
      if (_show != 3) {
        setState(() {
          if (!mounted) return;
          _dotsValue += 1;
        });
        if (_dotsValue == 3) {
          if (!mounted) return;
          setState(() {
            _dotsValue = 0;
          });
          return;
        }
      } else {
        t.cancel();
      }
      return;
    });
  }

  void _updateAnalysis() {
    const dotTime = const Duration(seconds: 3); //850 second
    Timer.periodic(dotTime, (Timer t) {
      if (!mounted) return;
      setState(() {
        _show = 3;
      });
      t.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: .5,
          centerTitle: true,
          leading: _show == 0
              ? CircleButton(
                  fun: () => Navigator.pop(context),
                  icn: Icons.arrow_back,
                  color: primaryColor,
                )
              : SizedBox(),
          actions: [
            CircleButton(
              color: primaryColor,
              icn: Icons.info_outline,
              fun: () => _showMyDialog(),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  _show == 3
                      ? 'Thank You For Using Brain Tumor Model'
                      : 'Brain Tumor Model',
                  style: TextStyle(
                      fontSize: 22,
                      color: darkBlueColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  _show == 1 && _pickerImage != null
                      ? 'Please Analysis X-ray image OR choose other image'
                      : _show == 2 && _pickerImage != null
                          ? 'Please Wait Until Analysis X-Ray Image '
                          : _show == 3
                              ? ' '
                              : 'Please click on the file and choose the X-ray image',
                  style: TextStyle(
                      color: subTextColor.withOpacity(.6),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width < 380
                      ? MediaQuery.of(context).size.width
                      : 380,
                  child: _show == 1 && _pickerImage != null
                      ? imagePreview()
                      : _show == 2 && _pickerImage != null
                          ? analysis()
                          : _show == 3
                              ? ModelResult(
                                  firstDiseaseValue: 0.81,
                                  secondDiseaseValue: .48,
                                  thirdDiseaseValue: .22,
                                )
                              : Center(child: takeImg),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                _show == 1 && _pickerImage != null
                    ? Column(
                        children: [
                          RoundedButton(
                            fun: () {
                              setState(() {
                                _updateDots();
                                _updateAnalysis();
                                _show = 2;
                              });
                            },
                            text: 'Analysis',
                            borderRadious: 10.0,
                            minWdthRatio: .8,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * .8,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              setState(() {
                                _show = 0;
                              });
                            },
                            child: Text(
                              'Cancel',
                              style:
                                  TextStyle(fontSize: 16, color: primaryColor),
                            ),
                          )
                        ],
                      )
                    : _show == 2 && _pickerImage != null
                        ? MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * .5,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            onPressed: () {
                              setState(() {
                                _show = 0;
                              });
                            },
                            child: Text(
                              'Cancel',
                              style:
                                  TextStyle(fontSize: 16, color: primaryColor),
                            ),
                          )
                        : _show == 3
                            ? RoundedButton(
                                fun: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DoctorHome())),
                                text: 'End',
                                borderRadious: 10.0,
                                minWdthRatio: .8,
                              )
                            : SizedBox(),
              ],
            ),
          ),
        ));
  }

  Stack analysis() {
    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 5,
            valueColor: AlwaysStoppedAnimation(primaryColor),
          ),
          height: 150.0,
          width: 150.0,
        ),
        Text(
          "Analysing ${_dotsValue == 0 ? '.  ' : _dotsValue == 1 ? '.. ' : '...'}",
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
        )
      ],
    );
  }

  Padding imagePreview() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              _pickerImage!,
              fit: BoxFit.fill,
              gaplessPlayback: true,
              scale: 1.0,
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            children: [
              Text(
                '${_pickerImage!.path.split('/').last}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.add_photo_alternate_outlined),
                  onPressed: () => _showModalBottomSheet(),
                  color: primaryColor,
                ),
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget get takeImg {
    return InkWell(
      onTap: () => _showModalBottomSheet(),
      child: DottedBorder(
        dashPattern: [20, 11],
        strokeWidth: 2,
        color: primaryColor.withOpacity(.3),
        strokeCap: StrokeCap.round,
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        child: Container(
          color: lightGreyColor.withOpacity(.7),
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_rounded,
                size: 60,
                color: subTextColor.withOpacity(.8),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Tap To Select Image',
                style: TextStyle(
                  color: subTextColor,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomSheetItem(
                    label: 'Take New Picture',
                    icon: Icons.camera_alt_rounded,
                    fun: () {
                      _pickImage(ImageSource.camera);
                      setState(() {
                        _show = 1;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  BottomSheetItem(
                      label: 'Select Picture From Gallery',
                      icon: Icons.photo_library_outlined,
                      fun: () {
                        _pickImage(ImageSource.gallery);
                        setState(() {
                          _show = 1;
                        });
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Explain Brain Tumor Model',
            style: TextStyle(color: darkBlueColor),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _updateAnalysis();
    _updateDots();
  }
}