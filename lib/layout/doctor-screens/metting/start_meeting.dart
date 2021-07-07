import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/full_image.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/services/doctorScreens/controllers/get_one_session_controller.dart';
import 'package:the_disease_fighter/services/sessions/controllers/upload_session_medicine.dart';
import 'package:the_disease_fighter/services/sessions/controllers/upload_session_photo.dart';

class StartMeeting extends StatefulWidget {
  final data;
  final sessionId;
  final showSnackBar;

  const StartMeeting({Key? key, this.data, this.sessionId, this.showSnackBar})
      : super(key: key);

  @override
  _StartMeetingState createState() => _StartMeetingState();
}

class _StartMeetingState extends State<StartMeeting> {
  bool _showBanner = false;
  String _errorMessage = '';
  String? _uploadSessionPhotoErrorMessage;

  UploadSessionMedicineController _uploadSessionMedicineController =
      UploadSessionMedicineController();
  UploadSessionPhotoController _uploadSessionPhotoController =
      UploadSessionPhotoController();
  GetOneSessionController _getOneSessionController = GetOneSessionController();

  Future _getSessionData() async {
    var data = await _getOneSessionController.getOneSession(
      sessionId: widget.sessionId,
    );
    return data.session![0].files;
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future _uploadSessionMedicine() async {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      LoaderDialog().onLoading(context);
      setState(() {
        _showBanner = false;
      });
      final data = await _uploadSessionMedicineController.uploadSessionMedicine(
        sessionId: widget.sessionId.toString(),
        diagnose: diagnose.toString(),
        medicine: medicine.toString(),
      );
      if (await data['success']) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DoctorHome()));
      } else {
        setState(() {
          _errorMessage = data['message'].toString();
          _showBanner = true;
        });
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }
  }

  bool _uploadSessionPhotoLoader = false;
  Future _uploadSessionPhoto() async {
    if (_pickerImage != null) {
      setState(() {
        _uploadSessionPhotoLoader = true;
      });
      final data = await _uploadSessionPhotoController.uploadSessionPhoto(
        file: _pickerImage,
        sessionId: widget.sessionId.toString(),
      );
      if (data['success']) {
        setState(() {
          _pickerImage = null;
          _uploadSessionPhotoErrorMessage = null;
        });
      } else {
        print('///////////////////////////////////////////////');
        print(data['message']);
        setState(() {
          _uploadSessionPhotoLoader = false;
          _uploadSessionPhotoErrorMessage = data['message'].toString();
        });
      }
      setState(() {
        _uploadSessionPhotoLoader = false;
      });
    }
  }

  File? _pickerImage;
  bool _cancelPressed = false;
  bool _pickedImage = false;
  String? errorMessage;

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

  Future _asyncConfirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          buttonPadding: EdgeInsets.symmetric(horizontal: 20),
          content: Text(
            Languages.of(context)!
                .doctorStartMeeting['endAlertTittle']
                .toString(),
          ),
          contentTextStyle: TextStyle(
              color: darkBlueColor, fontSize: 16, fontWeight: FontWeight.bold),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * .3,
                child: Center(
                  child: Text(
                    Languages.of(context)!
                        .doctorStartMeeting['endAlertCancelBtn']
                        .toString(),
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: lightGreyColor,
                ),
              ),
            ),
            InkWell(
              onTap: _uploadSessionMedicine,
              child: Container(
                width: MediaQuery.of(context).size.width * .3,
                height: 40,
                child: Center(
                  child: Text(
                    Languages.of(context)!
                        .doctorStartMeeting['endAlertOkBtn']
                        .toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool showFullImage = false;
  late String fullImagePath;
  String? diagnose;
  String? medicine;

  _getDiagnose(String val) {
    setState(() {
      diagnose = val;
    });
  }

  _getMedicine(String val) {
    setState(() {
      medicine = val;
    });
  }

  Widget _txt(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: darkBlueColor),
      ),
    );
  }

  Widget _appointCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          color: lightGreyColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: backGroundColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:
                            NetworkImage(widget.data.patientAvatar.toString()),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.name.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: darkBlueColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.data.phone.toString(),
                    style: TextStyle(
                      color: subTextColor,
                    ),
                  )
                ],
              )
            ],
          ),
          InkWell(
            onTap: () {
              _asyncConfirmDialog(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width * .6,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  Languages.of(context)!
                      .doctorStartMeeting['endBtn']
                      .toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context, [true]);
            },
          ),
          centerTitle: true,
          title: Text(
            Languages.of(context)!.doctorStartMeeting['tittle'].toString(),
            style: TextStyle(color: primaryColor, fontSize: 16),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _appointCard(),
                  _txt(
                    Languages.of(context)!
                        .doctorStartMeeting['addDiagnosis']
                        .toString(),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: lightGreyColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      onChanged: _getDiagnose,
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintText: Languages.of(context)!
                              .doctorStartMeeting['enterDiag'],
                          hintStyle: TextStyle(
                              color: subTextColor.withOpacity(.8),
                              fontSize: 16)),
                      validator: (val) {
                        if (val == null || val == '') {
                          return Languages.of(context)!
                              .doctorStartMeeting['diagnoseRequired']
                              .toString();
                        }
                      },
                    ),
                  ),
                  _txt(
                    Languages.of(context)!
                        .doctorStartMeeting['addMedicine']
                        .toString(),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: lightGreyColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      onChanged: _getMedicine,
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintText: Languages.of(context)!
                              .doctorStartMeeting['enterMedicine'],
                          hintStyle: TextStyle(
                              color: subTextColor.withOpacity(.8),
                              fontSize: 16)),
                      validator: (val) {
                        if (val == null || val == '') {
                          return Languages.of(context)!
                              .doctorStartMeeting['medicineRequired']
                              .toString();
                        }
                      },
                    ),
                  ),
                  // ignore: unnecessary_null_comparison
                  _uploadSessionPhotoLoader && _pickerImage != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 55),
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(darkBlueColor),
                                )),
                          ),
                        )
                      : _pickerImage != null &&
                              _uploadSessionPhotoLoader == false
                          ? imagePreview()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _txt(
                                  Languages.of(context)!
                                      .doctorStartMeeting['addFiles']
                                      .toString(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _pickImage(ImageSource.camera);
                                            setState(() {
                                              _cancelPressed = false;
                                              _pickedImage = true;
                                            });
                                          },
                                          child: Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color: lightGreyColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add_a_photo,
                                                  color: primaryColor,
                                                  size: 35,
                                                ),
                                                //onPressed: () {
                                                // _pickImage(ImageSource.camera);
                                              )),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          Languages.of(context)!
                                              .doctorStartMeeting['camera']
                                              .toString(),
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _pickImage(ImageSource.gallery);
                                            setState(() {
                                              _cancelPressed = false;
                                              _pickedImage = true;
                                            });
                                          },
                                          child: Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                color: lightGreyColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/icons/addimage.png",
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          Languages.of(context)!
                                              .doctorStartMeeting['gallery']
                                              .toString(),
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                _uploadSessionPhotoErrorMessage != null
                                    ? Text(
                                        _uploadSessionPhotoErrorMessage
                                            .toString(),
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                  _txt(
                    Languages.of(context)!
                        .doctorStartMeeting['recentFiles']
                        .toString(),
                  ),
                  FutureBuilder<dynamic>(
                      future: _getSessionData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.refresh,
                                      color: primaryColor,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _getSessionData();
                                      });
                                    }),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Failed To Load',
                                  style: TextStyle(
                                      color: subTextColor, fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return snapshot.data.length != 0
                              ? GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    // childAspectRatio: 0.99,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 30,
                                  ),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullImage(
                                                          fullImagePath: snapshot
                                                              .data[index]
                                                              .toString())));
                                        },
                                        child: Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(.5),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(snapshot
                                                    .data[index]
                                                    .toString())),
                                          ),
                                        ));
                                  },
                                  itemCount: snapshot.data.length,
                                )
                              : Text('Please , Add Files To Show',
                                  style: TextStyle(
                                      color: subTextColor.withOpacity(.9)));
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
      _showBanner
          ? SizedBox(
              height: 135,
              child: ErrorMaterialBanner(
                errorMessage: _errorMessage.toString(),
                fun: () {
                  setState(() {
                    _showBanner = false;
                  });
                },
              ),
            )
          : SizedBox(),
    ]);
  }

  Padding imagePreview() {
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 30),
        child: _cancelPressed == false && _pickedImage == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Row(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_pickerImage!.path.split('/').last}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _uploadSessionPhoto();
                                    setState(() {
                                      _getSessionData();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        Languages.of(context)!
                                            .saveButton,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _pickerImage = null;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    decoration: BoxDecoration(
                                      color: lightGreyColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        Languages.of(context)!
                                            .cancelBTN,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _uploadSessionPhotoErrorMessage != null
                        ? Text(
                            _uploadSessionPhotoErrorMessage.toString(),
                            style: TextStyle(color: Colors.redAccent),
                          )
                        : SizedBox(),
                  ])
            : SizedBox());
  }
}
