import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/layout/doctor-screens/ml_model/model-screen.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_home/home_widgets/doctor_card.dart';
import 'package:the_disease_fighter/layout/patient_screens/search/search.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/bottom_sheet_item.dart';
import 'package:the_disease_fighter/material/widgets/empty_list_widget.dart';
import 'package:the_disease_fighter/material/widgets/model_result.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/services/ml_models/ml_controller.dart';
import 'package:the_disease_fighter/services/specialization/one_specialization_controller.dart';

class MlClinic extends StatefulWidget {
  final clinicTittle;
  final modelName;
  final clinicId;

  MlClinic({this.clinicTittle, this.clinicId, this.modelName});

  @override
  _MlClinicState createState() => _MlClinicState();
}

class _MlClinicState extends State<MlClinic> {
  int _show = 0;
  ScrollController _scrollController = new ScrollController();
  bool showUpButton = false;
  File? _pickerImage;
  final ImagePicker _picker = ImagePicker();

  MlModelController _mlModelController = MlModelController();
  String? _errorMessage;
  var _modelResult;

  Future _uploadXRayImage() async {
    if (_pickerImage != null) {
      setState(() {
        _errorMessage = null;
        _show = 2;
      });
      final response = await _mlModelController.mlModel(
          file: _pickerImage, modelName: widget.modelName.toString());
      if (response['success']) {
        setState(() {
          _modelResult = response;
          _show = 3;
        });
      } else {
        setState(() {
          _errorMessage = response['message'];
          _show = 1;
        });
      }
    }
  }

  OneSpecializationController _oneSpecializationController =
      OneSpecializationController();

  Future _loadOneSpecialization() async {
    var data = await _oneSpecializationController.getOneSpecialization(
        clinicId: widget.clinicId);
    return Future.value(data);
  }

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
        elevation: 0.0,
        floating: true,
        pinned: false,
        snap: true,
        leading: CircleButton(
          fun: () => Navigator.pop(context),
          icn: Icons.arrow_back,
          color: primaryColor,
        ),

      ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Text(
                  Languages.of(context)!.allClinicsScreen['mlHeader'],
                  style: kHeadStyle,
                ),
              ),
              _show == 1 && _pickerImage != null
                  ? Column(
                      children: [
                        PreviewPickedImage(
                          image: _pickerImage,
                          showModelButtonFun: _showModalBottomSheet,
                        ),
                        _errorMessage != null
                            ? Text(
                                _errorMessage.toString(),
                                style: TextStyle(
                                    color: Colors.red.withOpacity(.8)),
                              )
                            : SizedBox(),
                        _rowButtons()
                      ],
                    )
                  : _show == 2 && _pickerImage != null
                      ? Center(child: AnalysisLoader())
                      : _show == 3
                          ? ModelResult(
                              result: _modelResult,
                            )
                          : Center(child: takeImg),
            ],
          ),
        ),
        SliverAppBar(
          collapsedHeight: 45.0,toolbarHeight: 45.0,
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
            future: _loadOneSpecialization(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData && !snapshot.hasError) {
                return SliverToBoxAdapter(
                    child: Container(height: MediaQuery.of(context).size.height *.5,child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(darkBlueColor),))));
              } else {
                if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .1),
                      child:  FailLoadWidget(
                        fun: () {
                  setState(() {
                    _loadOneSpecialization();
                  });
                  },
                  )
                    ),
                  );
                } else {
                  return snapshot.data.success == true
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => DoctorCard(
                              item: snapshot.data.doctors[index],
                            ),
                            childCount: snapshot.data.doctors.length,
                          ),
                        )
                      : SliverToBoxAdapter(child:  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
                    child: EmptyListWidget(icon: Icons.perm_contact_cal_sharp,label: 'No Doctors Found',iconSize: 100.0,),
                  )
                  );
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
                  Languages.of(context)!
                      .ml['tapToSelect'].toString(),
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
                    label: Languages.of(context)!
                  .uploadUserAvatar['takePhoto'].toString(),
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
                      label: Languages.of(context)!
                          .uploadUserAvatar['selectGallery'].toString(),
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

  Widget _rowButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width * .3,
          height: 40,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          color: primaryColor,
          onPressed:_uploadXRayImage,
          child: Text(
    Languages.of(context)!
        .ml['analysis'].toString(),
            style:
            TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        SizedBox(width: 20,),
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width * .3,
          height: 40,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
    setState(() {
    _show = 0;
    _errorMessage = null ;
    _pickerImage = null;
    });
    },
          child: Text(
    Languages.of(context)!
        .cancelBTN.toString(),
            style:
            TextStyle(fontSize: 16, color: primaryColor),
          ),
        ),
        SizedBox(width: 15,),

      ],
    );
  }
}
