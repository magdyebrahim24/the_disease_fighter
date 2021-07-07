import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/layout/drawer/patient_MainDrawer.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/services/basicData/controllers/logOutController.dart';
import 'package:the_disease_fighter/layout/sign/sign_in/sign_in.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/localizations/localization/locale_constant.dart';
import 'package:the_disease_fighter/localizations/localization_models/language_data.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/patient-logo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'setting_screens/change_password.dart';

class Setting extends StatefulWidget {
  final showSnackBar;

  Setting({this.showSnackBar = false});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _errorMessage;
  bool _showBanner = false;

  LogOutController _logOut = LogOutController();

  Future _userLogOut() async {
    LoaderDialog().onLoading(context);
    setState(() {
      _showBanner = false;
    });
    final data = await _logOut.userLogOut();
    if (await data['success']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token','');

      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>  SignIn(
            showLogOutSnackBar: true,
          ),
        ),
            (route) => false,
      );
    } else {
      setState(() {
        _errorMessage = data['message'].toString();
        _showBanner = true;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    widget.showSnackBar
        ? Future.delayed(Duration.zero, () async {
            snackBarr();
          })
        // ignore: unnecessary_statements
        : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: primaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: !_showBanner
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
              : SizedBox(),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 25),
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 210,
                    child: PatientLogo(
                      imgWidth: 120.0,
                      imgHigh: 120.0,
                      nameSize: 18.0,
                      nameColor: Colors.white,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    decoration: BoxDecoration(
                        color: backGroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Text(
                      Languages.of(context)!.setting['settingLabel'],
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DrawerTile(
                    icon: Icons.lock_open_outlined,
                    fun: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword())),
                    tittle: Languages.of(context)!.setting['password'],
                    leadingIconColor: primaryColor.withOpacity(.7),
                  ),
                  // DrawerTile(
                  //   icon: Icons.notifications_none_rounded,
                  //   fun: () {},
                  //   tittle: Languages.of(context)!.setting['notification'],
                  //   leadingIconColor: primaryColor.withOpacity(.7),
                  // ),
                  _createLanguageDropDown(),
                  Divider(
                    height: 1,
                    color: backGroundColor,
                    thickness: 1,
                  ),
                  DrawerTile(
                    leadingIconColor: primaryColor.withOpacity(.7),
                    fun: _userLogOut,
                    icon: Icons.logout,
                    tittle: Languages.of(context)!.setting['logOut'],
                  ),
                  Container(
                    color: backGroundColor,
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          Languages.of(context)!.setting['shareApp'],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DrawerTile(
                      leadingIconColor: darkBlueColor.withOpacity(.8),
                      icon: FontAwesomeIcons.facebookF,
                      tittle: Languages.of(context)!.setting['faceBook'],
                      fun: () => launch('https://www.facebook.com/')),
                  DrawerTile(
                    leadingIconColor: primaryColor.withOpacity(.8),
                    icon: FontAwesomeIcons.twitter,
                    tittle: Languages.of(context)!.setting['twitter'],
                    fun: () => launch('https://www.twitter.com/'),
                  ),
                  DrawerTile(
                      leadingIconColor: Colors.green,
                      icon: FontAwesomeIcons.whatsapp,
                      tittle: Languages.of(context)!.setting['whatsApp'],
                      fun: () async => await launch(
                          "https://wa.me/01552154105?text=Share The Medical Solution App With Your Friends - link :https://twitter.com/migoo_1_3?s=09&fbclid=IwAR3k92gBqVe_OWHYwn2jsvsdV7hpO_lCB9dqJdS2SSM-7yhlaD_i8S7nsKM")),
                Container(height: MediaQuery.of(context).size.height * .1,color: Colors.white,)
                ],
              ),
              _showBanner
                  ? ErrorMaterialBanner(
                      errorMessage: _errorMessage.toString(),
                      fun: () {
                        setState(() {
                          _showBanner = false;
                        });
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ));
  }

  _createLanguageDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.language,
                color: primaryColor.withOpacity(.7),
              ),
              SizedBox(
                width: 33,
              ),
              Text(
                Languages.of(context)!.setting['language'],
                style: TextStyle(color: darkBlueColor, fontSize: 16),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 55),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<LanguageData>(
                      iconSize: 30,
                      hint: Text(Languages.of(context)!
                          .setting['labelSelectLanguage']),
                      onChanged: (language) {
                        changeLanguage(context, language!.languageCode);
                      },
                      isDense: false,
                      items: LanguageData.languageList()
                          .map<DropdownMenuItem<LanguageData>>(
                            (e) => DropdownMenuItem<LanguageData>(
                          value: e,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  snackBarr() {
    final snackBar = SnackBar(
      content: Text(
        'Password Changed',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: primaryColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}