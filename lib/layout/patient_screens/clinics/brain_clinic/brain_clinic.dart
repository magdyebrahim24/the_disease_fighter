import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/doctor_profile/edit_doctor_info/edit_doctor_info.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/favorite/favorite_doctors.dart';
import 'package:the_disease_fighter/layout/notification/notification.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home_widgets/doctor_card.dart';
import 'package:the_disease_fighter/layout/patient_screens/search/search.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/arc_inductor.dart';
import 'package:the_disease_fighter/material/widgets/model_result.dart';
import 'package:the_disease_fighter/services/specialization/one_specialization_controller.dart';

class BrainClinic extends StatefulWidget {
  final clinicTittle;
  final clinicId;

  const BrainClinic({Key? key, this.clinicTittle, this.clinicId}) : super(key: key);

  @override
  _BrainClinicState createState() => _BrainClinicState();
}

class _BrainClinicState extends State<BrainClinic> {
  double _progressAnalysisValue = 0.0;

  int _dotsValue = 0;
  int _show = 0;
  ScrollController _scrollController = new ScrollController();
  bool showUpButton = false;
  PickedFile? _pickerImage;
  final ImagePicker _picker = ImagePicker();


  OneSpecializationController _oneSpecializationController=OneSpecializationController();

  Future _loadOneSpecialization() async {
    var data = await _oneSpecializationController.getOneSpecialization(clinicId: widget.clinicId);
    return Future.value(data);
  }

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.getImage(source: src);
    if (pickedImageFile != null) {
      setState(() {
        _pickerImage = pickedImageFile;
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
    const dotTime = const Duration(milliseconds: 500); //850 second
    Timer.periodic(analysisTime, (Timer t) {
      setState(() {
        _progressAnalysisValue += 0.01;
        if (_progressAnalysisValue > 1) {
          t.cancel();
          _show = 3;
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
            fun: () => Navigator.pop(context),
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
          child: FutureBuilder<void>(
              future: retrieveLostData(),
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Text(
                        Languages.of(context)!.allClinicsScreen['mlHeader'],
                        style: kHeadStyle,
                      ),
                    ),
                    _show == 3
                        ? Padding(
                            padding: EdgeInsets.all(15),
                            child: ModelResult(
                              firstDiseaseValue: 0.81,
                              secondDiseaseValue: .48,
                              thirdDiseaseValue: .22,
                            ),
                          )
                        : _show == 1 && _pickerImage != null
                            ? imagePreview()
                            : _show == 2 && _pickerImage != null
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
                                : takeImg,
                  ],
                );
              }),
        ),
        SliverAppBar(
          pinned: true,
          title: Text(
            '${widget.clinicTittle}',
            style: kHeadStyle,
          ),
          automaticallyImplyLeading: false,
          actions: [
            ImgButton(
              fun: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search())),
              img: 'assets/icons/search1.png',
              imgWidth: 34.0,
              imgHigh: 20.0,
            ),
          ],
        ),
        FutureBuilder<dynamic>(
            future:_loadOneSpecialization(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              } else {
                if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .15),
                      child: Column(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.refresh,
                                color: primaryColor,
                                size: 40,
                              ),
                              onPressed: () {
                                setState(() {
                                  _loadOneSpecialization();
                                });
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Failed To Load',
                            style:
                            TextStyle(color: subTextColor, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return  snapshot.data.success==true
                      ?  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => DoctorCard(
                        item: snapshot.data.doctors[index],
                      ),
                      childCount: snapshot.data.doctors.length,
                    ),
                  ) : SliverToBoxAdapter(child: EmptyPage());
                }
              }
            }),
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

  Padding imagePreview() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(_pickerImage!.path),
                  fit: BoxFit.fill,
                  gaplessPlayback: true,
                  scale: 1.0,
                  width: 60,
                  height: 60,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                '${_pickerImage!.path.split('/').last}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )),
              CircleButton(
                icn: FontAwesomeIcons.edit,
                color: darkBlueColor,
                fun: () => _showModalBottomSheet(),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            minWidth: 200,
            height: 45,
            color: primaryColor,
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: subTextColor),
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              _updateAnalysisProgress();
              setState(() {
                _show = 2;
              });
            },
            child: Text(
              'Analysis',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget get takeImg {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        onTap: () => _showModalBottomSheet(),
        child: DottedBorder(
          dashPattern: [20, 11],
          strokeWidth: 2,
          color: primaryColor.withOpacity(.3),
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
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

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _pickerImage = response.file;
        });
      } else {
        print('errorrrrrrrrrrrrrrrrrrrr');
      }
      // _retrieveDataError = response.exception!.code;
    }
  }
}