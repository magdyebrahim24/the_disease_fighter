import 'package:flutter/material.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';

class TermsOfUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _text(String text) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          text,
          style: TextStyle(
            color: darkBlueColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget _subtext(String text) {
      return Text(
        text,
        style: TextStyle(
          color: subTextColor,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          Languages.of(context)!.termsOfUse['tittle'],
          style: TextStyle(fontSize: 16, color: darkBlueColor),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: darkBlueColor,
          ),
          onPressed: () {
            Navigator.pop(context, [true]);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _text(Languages.of(context)!.termsOfUse['tittle']),
              _subtext(Languages.of(context)!.termsOfUse['termsSubTxt']),
              Divider(
                thickness: .75,
              ),
              _text(Languages.of(context)!.termsOfUse['privacy']),
              _subtext(Languages.of(context)!.termsOfUse['privacySubTxt']),
              Divider(
                thickness: .75,
              ),
              _text(Languages.of(context)!.termsOfUse['userContent']),
              _subtext(Languages.of(context)!.termsOfUse['userContentSubTxt']),
              Divider(
                thickness: .75,
              ),
              _text(Languages.of(context)!.termsOfUse['feedback']),
              _subtext(Languages.of(context)!.termsOfUse['feedbackSubTxt'])
            ],
          ),
        ),
      ),
    );
  }
}
