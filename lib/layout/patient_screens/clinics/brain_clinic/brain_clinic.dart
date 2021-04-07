import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/data/doctor_data.dart';
import 'package:the_disease_fighter/layout/doctor-screens/patient-card.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient_profile/patient_profile.dart';
import 'package:the_disease_fighter/layout/notification/notification.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home.dart';
import 'package:the_disease_fighter/layout/patient_screens/search/search.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/arc_inductor.dart';

class BrainClinic extends StatefulWidget {
  final clinicTittle;

  const BrainClinic({Key key, this.clinicTittle}) : super(key: key);

  @override
  _BrainClinicState createState() => _BrainClinicState();
}

class _BrainClinicState extends State<BrainClinic> {
  double _progressAnalysisValue = 0.0;
  double _firstDiseaseValue = 0.0;
  double _secondDiseaseValue = 0.0;
  double _thirdDiseaseValue = 0.0;

  int _dotsValue = 0;
  int _show = 0;
  ScrollController _scrollController = new ScrollController();
  bool showUpButton = false;

  File _pickerImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.getImage(source: src);
    if (pickedImageFile != null) {
      setState(() {
        _pickerImage = File(pickedImageFile.path);
      });
    } else {
      print('No Image Selected');
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 300) {
        setState(() {
          showUpButton = true;
        });
      } else {
        setState(() {
          showUpButton = false;
        });
      }
    });
    super.initState();
  }

  void _updateAnalysisProgress() {
    const analysisTime = const Duration(milliseconds: 50);
    const dotTime = const Duration(milliseconds: 8500); //850 second
    Timer.periodic(analysisTime, (Timer t) {
      setState(() {
        _progressAnalysisValue += 0.01;
        if (_progressAnalysisValue > 1) {
          t.cancel();
          _show = 2;
          _diseaseResult();
          return;
        }
      });
    });
    Timer.periodic(dotTime, (Timer t) {
      setState(() {
        _dotsValue += 1;
        if (_dotsValue == 3) {
          setState(() {
            _dotsValue = 0;
          });
          return;
        } else if (_progressAnalysisValue > 1) {
          t.cancel();
          setState(() {
            _dotsValue = 3;
          });
        }
      });
    });
  }

  _diseaseResult() {
    const diseaseResultTime = Duration(milliseconds: 60);
    new Timer.periodic(diseaseResultTime, (Timer t1) {
      setState(() {
        _firstDiseaseValue += 0.01;
        if (_firstDiseaseValue > 0.81) {
          t1.cancel();
        }
        return;
      });
    });
    new Timer.periodic(diseaseResultTime, (Timer t) {
      setState(() {
        _secondDiseaseValue += 0.01;
        if (_secondDiseaseValue > .48) {
          t.cancel();
        }
        return;
      });
    });
    new Timer.periodic(diseaseResultTime, (Timer t) {
      setState(() {
        _thirdDiseaseValue += 0.01;
        if (_thirdDiseaseValue > .22) {
          t.cancel();
        }
        return;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(controller: _scrollController, slivers: <Widget>[
        SliverAppBar(
          floating: true,
          pinned: false,
          snap: true,
          leading: CircleButton(
            fun: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home())),
            icn: Icons.arrow_back,
            color: primaryColor,
          ),
          actions: [
            ImgButton(
              fun: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notifications())),
              img: 'assets/icons/notification.png',
              imgHigh: 35.0,
              imgWidth: 35.0,
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Text(
                  'Diagnosis disease with ML',
                  style: kHeadStyle,
                ),
              ),
              _show == 0
                  ? takeImg
                  : _show == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ArcIndicator(
                              child: Text(
                                _progressAnalysisValue < 1
                                    ? "Analysing ${_dotsValue == 0 ? '.  ' : _dotsValue == 1 ? '.. ' : '...'}"
                                    : 'Done',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: primaryColor.withOpacity(.6),
                                ),
                              ),
                              progressValue: _progressAnalysisValue,
                              bgColor: lightGreyColor,
                              dimensions: 160.0,
                            ),
                          ],
                        )
                      : resultInductors,
            ],
          ),
        ),
        SliverAppBar(
          pinned: true,
          leading: Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            child: Text(
              '${widget.clinicTittle} Doctors',
              style: kHeadStyle,
            ),
          ),
          leadingWidth: 135,
          actions: [
            ImgButton(
              fun: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Search())),
              img: 'assets/icons/search1.png',
              imgWidth: 34.0,
              imgHigh: 20.0,
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => DoctorCard(
              item: doctorsData[index],
            ),
            childCount: doctorsData.length,
          ),
        ),
      ]),
      floatingActionButton: AnimatedOpacity(
        opacity: showUpButton ? 1 : 0.0,
        duration: Duration(milliseconds: 500),
        child: MaterialButton(
            elevation: 0.5,
            hoverElevation: 5.0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minWidth: 50,
            height: 50,
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: FaIcon(
              FontAwesomeIcons.angleDoubleUp,
              color: Colors.white,
              size: 17,
            ),
            onPressed: () {
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              );
            }),
      ),
    );
  }

  Widget get takeImg {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        onTap: () => _showModalBottomSheet(),
        child: DottedBorder(
          // dashPattern: [20, 11],
          strokeWidth: 2,
          color: primaryColor.withOpacity(.3),
          // strokeCap: StrokeCap.round,
          // borderType: BorderType.RRect,
          // radius: Radius.circular(10),
          child: Container(
            height: 170,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_rounded,
                  size: 60,
                  color: subTextColor,
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
      ),
    );
  }

  Widget get resultInductors {
    return Container(
      margin: EdgeInsets.all(15),
      height: 170,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
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
            dimensions: 100.0,
            bgColor: Colors.white,
          ),
          ArcIndicator(
            child: Text("${(_secondDiseaseValue * 100).toInt()} %",
                style: progressTextStyle),
            progressValue: _secondDiseaseValue,
            dimensions: 100.0,
            bgColor: Colors.white,
          ),
          ArcIndicator(
            child: Text("${(_thirdDiseaseValue * 100).toInt()} %",
                style: progressTextStyle),
            progressValue: _thirdDiseaseValue,
            dimensions: 100.0,
            bgColor: Colors.white,
          ),
        ],
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
                    label: 'Take New Profile Picture',
                    icon: Icons.camera_alt_rounded,
                    fun: () {
                      // _pickImage(ImageSource.camera);
                      _updateAnalysisProgress();

                      setState(() {
                        _show = 1;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  BottomSheetItem(
                    label: 'Select Picture From Gallery',
                    icon: Icons.photo_library_outlined,
                    fun: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
