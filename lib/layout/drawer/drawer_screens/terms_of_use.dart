import 'package:flutter/material.dart';
import 'package:the_disease_fighter/material/constants.dart';

class TermsOfUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _text(String text) {
      return Text(
        text,
        style: TextStyle(
          color: darkBlueColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
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
          "Terms of use",
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
              _text("Terms of use"),
              SizedBox(
                height: 20,
              ),
              _subtext(
                  "These Terms of Usegovern your use of SNOW Inc,and any information, text, graphics, photos or other materials uploaded, downloaded or appearing on the the medical solution,referencing these Terms. You can’t use our the medical solution  unless you agree to them, so please read them carefully. Before using any of the the medical solution , you are required to read, understand and agree to these terms. You may only access the medical solution after reading and accepting these Terms of Use."),
              SizedBox(
                height: 20,
              ),
              _text("Privacy"),
              SizedBox(
                height: 20,
              ),
              _subtext(
                  "The medical solution Privacy Policy is incorporated into these Terms. By accepting these Terms, you agree to the collection, use, and sharing of your information through the Services in accordance with the Privacy Policy,"),
              SizedBox(
                height: 20,
              ),
              _text("User Content"),
              SizedBox(
                height: 20,
              ),
              _subtext(
                  "The Services consist of interactive features and areas that allow users to create, post, transmit, and/or store content, including but not limited to photos, videos, text, graphics, items, or other materials (collectively,) . You understand that you are responsible for all data charges you incur by using the Services. You also understand that your User Content may be viewable by others and that you have the ability to control who can access such content by adjusting your privacy settings. And you agree to abide by our Community Guidelines, which may be updated from time to time."),
              SizedBox(
                height: 20,
              ),
              _text("Feed Back"),
              SizedBox(
                height: 20,
              ),
              _subtext(
                  "You agree that any feedback, suggestions, ideas, or other information or materials regarding SNOW or the Services that you provide, whether by email or otherwise (Feedback), are non-confidential and shall become the sole property of SNOW. We will be entitled to the unrestricted use and dissemination of such Feedback for any purpose, commercial or otherwise, without acknowledging or compensating you. You waive any rights you may have to the Feedback (including any copyrights or moral rights). We like hearing from users, but please do not share your ideas with us if you expect to be paid or want to continue to own or claim rights in them.")
            ],
          ),
        ),
      ),
    );
  }
}
