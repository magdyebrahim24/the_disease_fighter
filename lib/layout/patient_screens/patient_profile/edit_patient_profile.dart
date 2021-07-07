import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/layout/patient_screens/patient_profile/patient_profile.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/update_patient_profile.dart';

// ignore: must_be_immutable
class EditPatientProfile extends StatefulWidget {
  final data;

  const EditPatientProfile({this.data});

  @override
  _EditPatientProfileState createState() => _EditPatientProfileState();
}

class _EditPatientProfileState extends State<EditPatientProfile> {
  UpdatePatientProfileController _updatePatientProfileController =
      UpdatePatientProfileController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phone;
  String? address;
  String? name;
  String? about;
  String? errorMessage;
  String? _bannerMessage;
  bool _showBanner = false;

  Future _updatePatientProfile() async {
    _formKey.currentState!.validate();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      LoaderDialog().onLoading(context);
      final data = await _updatePatientProfileController.updatePatientProfile(
        location: address,
        about: about,
        phone: phone,
        name: name,
        dob: widget.data.dob.toString(),
        gender: widget.data.gender.toString(),
      );
      if (await data['success']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', name.toString());

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PatientProfile()));
      } else {
        Navigator.of(context).pop();
        setState(() {
          _bannerMessage = data['message'].toString();
          _showBanner = true;
          errorMessage = data['message'].toString();
        });
      }
    }
  }

  _getPhone(String value) {
    setState(() {
      this.phone = value;
    });
  }

  _getAddress(String value) {
    setState(() {
      this.address = value;
    });
  }

  @override
  void initState() {
    super.initState();
    phone = widget.data.phone.toString();
    address = widget.data.location.toString();
    name = widget.data.name.toString();
    about = widget.data.about.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                elevation: 0.0,
                title: Text('Update Profile',style: TextStyle(color: darkBlueColor),),
                centerTitle: true,
                leading: CircleButton(
                  color: darkBlueColor,
                  fun: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientProfile())),
                  icn: Icons.arrow_back,
                )),
            body: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),

                    item(
                      validateFun: (value) {
                        if (value.toString().isEmpty) {
                          return 'Name Required';
                        }
                      },
                      label: Languages.of(context)!
                          .patientProfile['name'].toString(),
                      initialValue: widget.data.name.toString(),
                      hintText: "Enter your Name",
                      fun: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      textInputType: TextInputType.name,
                      readOnly: false,
                    ),
                    item(
                      validateFun: (value) {
                        if (value.toString().isEmpty) {
                          return 'Phone Required';
                        }
                      },
                      label:
                          Languages.of(context)!.patientProfile['phoneLabel'],
                      initialValue: widget.data.phone.toString(),
                      hintText:
                          Languages.of(context)!.patientProfile['phoneHint'],
                      fun: _getPhone,
                      textInputType: TextInputType.phone,
                      readOnly: false,
                    ),
                    item(
                        validateFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Address Required';
                          }
                        },
                        label: Languages.of(context)!
                            .patientProfile['addressLabel'],
                        initialValue: widget.data.location.toString(),
                        hintText: Languages.of(context)!
                            .patientProfile['addressHint'],
                        fun: _getAddress,
                        readOnly: false,
                        textInputType: TextInputType.streetAddress),
                    item(

                      validateFun: (value) {
                        if (value.toString().isEmpty) {
                          return 'About Required';
                        }
                      },
                      label: Languages.of(context)!
                          .patientProfile['about'].toString(),
                      initialValue: widget.data.about.toString(),
                      hintText: "add a new information about you",
                      fun: (value) {
                        setState(() {
                          about = value;
                        });
                      },
                      textInputType: TextInputType.text,
                      readOnly: false,
                    ),
                  ]),
            )),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width * .3,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: subTextColor),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatientProfile()));
                      },
                      child: Text(
                        Languages.of(context)!.patientProfile['cancelBtn'],
                        style: TextStyle(fontSize: 16, color: subTextColor),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RoundedButton(
                      minWdthRatio: .5,
                      fun: _updatePatientProfile,
                      text: Languages.of(context)!.patientProfile['saveBtn'],
                      borderRadious: 50,
                    ),
                  ],
                ),
              ),
              elevation: 0.0,
            )),
        _showBanner
            ? SizedBox(
                height: 135,
                child: ErrorMaterialBanner(
                  fun: () {
                    setState(() {
                      _showBanner = false;
                    });
                  },
                  errorMessage: _bannerMessage,
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Widget item(
      {required label,
      validateFun,
      hintText,
      fun,
      initialValue,
      textInputType,
      required readOnly}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: subTextColor.withOpacity(.5),
              offset: Offset(1.0, 2.0),
              blurRadius: 4.0,
              spreadRadius: .4),
        ],
        borderRadius: BorderRadius.circular(10),
        color: backGroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: initialValue,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: subTextColor.withOpacity(.6),
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: textInputType,
                    cursorColor: primaryColor,
                    readOnly: readOnly,
                    style: TextStyle(color: darkBlueColor.withOpacity(.8)),
                    onChanged: fun,
                    validator: validateFun,
                  ),
                ),
                !readOnly
                    ? Icon(
                        Icons.edit_outlined,
                        size: 17,
                        color: darkBlueColor,
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
