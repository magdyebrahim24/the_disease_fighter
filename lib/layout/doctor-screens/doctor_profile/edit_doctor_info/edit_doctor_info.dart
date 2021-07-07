import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/updateDoctorProfile.dart';
import '../doctor_profile.dart';

// ignore: must_be_immutable
class EditDoctorProfile extends StatefulWidget {
  final data;
  EditDoctorProfile({this.data});

  @override
  _EditDoctorProfileState createState() => _EditDoctorProfileState();
}

class _EditDoctorProfileState extends State<EditDoctorProfile> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UpdateDoctorProfileController _updateDoctorProfileController =
      UpdateDoctorProfileController();

  String? phone;
  String? email;
  String? clinicLocation;
  String? day;
  String? name;
  String? errorMessage;
  DateTime? fromTime;
  DateTime? toTime;
  String? about;
  String? _bannerMessage;
  bool _showBanner = false;

  Map clinicDates = {
    1: {'day': 'sunday', 'from': '05:30 PM', 'to': '05:30 PM'}
  };
  int x = 2;

  _getPhone(String phone) {
    setState(() {
      this.phone = phone;
    });
  }

  _getName(String name) {
    setState(() {
      this.name = name;
    });
  }

  _getAbout(String about) {
    setState(() {
      this.about = about;
    });
  }

  _getAddress(String clinicLocation) {
    setState(() {
      this.clinicLocation = clinicLocation;
    });
  }


  Future _updatePatientProfile() async {
    _showBanner = false;
    _formKey.currentState!.validate();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      LoaderDialog().onLoading(context);
      final data = await _updateDoctorProfileController.updateDoctorProfile(
          name: name.toString(),
          about: about.toString(),
          clinicLocation: clinicLocation.toString(),
          phone: phone.toString(),
          email: email.toString(),
          gender: widget.data.gender.toString(),
          dob: widget.data.dob.toString(),
          specId: widget.data.specId.toString());

      if (await data['success']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', name.toString());
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DoctorProfile()));
      } else {
        setState(() {
          _bannerMessage = data['message'].toString();
          _showBanner = true;
          errorMessage = data['message'].toString();
        });

        Navigator.of(context).pop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    phone = widget.data.phone.toString();
    clinicLocation = widget.data.clinicLocation.toString();
    name = widget.data.name.toString();
    about = widget.data.about.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text(Languages.of(context)!
        .doctorProfile['editProfile']['editTittle'],style: TextStyle(color: darkBlueColor),),automaticallyImplyLeading: false,elevation: 0.0,centerTitle: true,),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                    item(
                        validateFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Name Required';
                          }
                        },
                        label:Languages.of(context)!
                            .doctorProfile['editProfile']['name'],
                        initialValue: widget.data.name.toString(),
                        hintText: Languages.of(context)!
                            .doctorProfile['editProfile']['nameHint'],
                        fun: _getName,
                        textInputType: TextInputType.name),
                    item(
                        validateFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Phone Required';
                          }
                        },
                        fun: _getPhone,
                        label: Languages.of(context)!
                            .doctorProfile['editProfile']['phoneLabel'],
                        initialValue: widget.data.phone.toString(),
                        hintText: Languages.of(context)!
                            .doctorProfile['editProfile']['phoneHint'],
                        textInputType: TextInputType.phone),
                    item(
                        validateFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'About Required';
                          }
                        },
                        fun: _getAbout,
                        label: Languages.of(context)!
                            .doctorProfile['editProfile']['about'],
                        initialValue: widget.data.about.toString(),
                        hintText: Languages.of(context)!
                            .doctorProfile['editProfile']['aboutHint'],
                        textInputType: TextInputType.text),

                    item(
                        validateFun: (value) {
                          if (value.toString().isEmpty) {
                            return 'Clinic Location is Required';
                          }
                        },
                        label: Languages.of(context)!
                            .doctorProfile['editProfile']['clinicAddressLabel'],
                        initialValue: widget.data.clinicLocation.toString(),
                        hintText: Languages.of(context)!
                            .doctorProfile['editProfile']['clinicAddressHint'],
                        fun: _getAddress,
                        textInputType: TextInputType.streetAddress),
                  ]),
            ),
          ),
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
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorProfile())),
                    child: Text(
                      Languages.of(context)!.doctorProfile['editProfile']
                          ['cancelBtn'],
                      style: TextStyle(fontSize: 16, color: subTextColor),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RoundedButton(
                    minWdthRatio: .5,
                    fun: _updatePatientProfile,
                    text: Languages.of(context)!.doctorProfile['editProfile']
                        ['saveBtn'],
                    borderRadious: 50,
                  ),
                ],
              ),
            ),
            elevation: 0.0,
          ),
        ),
        _showBanner
            ? SizedBox(
                height: 150,
                child: ErrorMaterialBanner(
                  fun: () {
                    setState(() {
                      _showBanner = false;
                    });
                  },
                  errorMessage: _bannerMessage,
                ),
              )
            : SizedBox()
      ],
    );
  }

  Widget item({
    required label,
    hintText,
    fun,
    initialValue,
    textInputType,
    validateFun,
  }) {
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
          Text(label.toString()),
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
                    style: TextStyle(color: darkBlueColor.withOpacity(.8)),
                    onChanged: fun,
                    validator: validateFun,
                  ),
                ),
                Icon(
                  Icons.edit_outlined,
                  size: 17,
                  color: darkBlueColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}

