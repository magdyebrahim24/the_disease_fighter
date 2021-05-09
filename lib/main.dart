import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/patient/patient_profile/patient_profile.dart';
import 'package:the_disease_fighter/layout/patient_screens/clinics/all_clinics.dart';
import 'package:the_disease_fighter/layout/sign/sign-up/sign_up.dart';
import 'package:the_disease_fighter/layout/sign/sign_in/sign_in.dart';
import 'layout/patient_screens/patient_home/home.dart';
import 'localizations/localization/locale_constant.dart';
import 'localizations/localization/localizations_delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en', '');

  void setLocale(locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      title: 'The Disease Fighter',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      home: Home(),
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Rubik',
      ),
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
