import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';

class StartMeeting extends StatefulWidget {
  @override
  _StartMeetingState createState() => _StartMeetingState();
}

class _StartMeetingState extends State<StartMeeting> {
  Future _asyncConfirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              Text(Languages.of(context)!.doctorStartMeeting['endAlertTittle']),
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
                        .doctorStartMeeting['endAlertCancelBtn'],
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: lightGreyColor,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DoctorHome())),
              child: Container(
                width: MediaQuery.of(context).size.width * .3,
                height: 40,
                child: Center(
                  child: Text(
                    Languages.of(context)!.doctorStartMeeting['endAlertOkBtn'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
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
  List img = [
    "assets/images/file1.jpg",
    "assets/images/file3.jpg",
    "assets/images/file2.jpg",
    "assets/images/file3.jpg",
    "assets/images/file1.jpg",
    "assets/images/file2.jpg",
  ];
  late String comment;

  _getComment(String val) {
    setState(() {
      comment = val;
    });
  }

  Widget _textField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: lightGreyColor, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        onChanged: _getComment,
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10),
            hintText: "Enter a diagnosis...",
            hintStyle:
                TextStyle(color: subTextColor.withOpacity(.8), fontSize: 16)),
      ),
    );
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
      height: 130,
      decoration: BoxDecoration(
          color: lightGreyColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/img_1.png"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr/Earl E. Hazel",
                      style: TextStyle(
                          fontSize: 14,
                          color: darkBlueColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          "Mansoura, Egypt",
                          style: TextStyle(
                            fontSize: 12,
                            color: subTextColor,
                          ),
                        ),
                        SizedBox(
                          width: 120,
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: subTextColor,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RoundedButton(
            text: "End Meeting",
            minWdthRatio: .8,
            fun: () {
              _asyncConfirmDialog(context);
            },
          )
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
          actions: [
            ImgButton(
              fun: () {},
              // fun: () => Navigator.push(context,
              //MaterialPageRoute(builder: (context) => Notifications())),
              img: 'assets/icons/model.png',
              imgHigh: 35.0,
              imgWidth: 35.0,
            ),
          ],
          centerTitle: true,
          title: Text(
            Languages.of(context)!.doctorStartMeeting['tittle'],
            style: TextStyle(color: primaryColor, fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _appointCard(),
                _txt(
                  Languages.of(context)!.doctorStartMeeting['addDiagnosis'],
                ),
                _textField(),
                _txt(
                  Languages.of(context)!.doctorStartMeeting['addMedicine'],
                ),
                _textField(),
                _txt(
                  Languages.of(context)!.doctorStartMeeting['addFiles'],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImgButton(
                      img: "assets/icons/document.png",
                      imgWidth: 90.0,
                      imgHigh: 90.0,
                      fun: () {},
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ImgButton(
                      img: "assets/icons/img.png",
                      imgWidth: 90.0,
                      imgHigh: 90.0,
                      fun: () {},
                    )
                  ],
                ),
                _txt(
                  Languages.of(context)!.doctorStartMeeting['recentFiles'],
                ),
                SizedBox(
                  height: ((img.length / 4) * 150).toDouble(),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width ~/ 85,
                      childAspectRatio: 0.99,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 30,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            fullImagePath = img[index];
                            showFullImage = true;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(img[index]))),
                        ),
                      );
                    },
                    itemCount: img.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      showFullImage ? fullImage() : SizedBox(),
    ]);
  }

  Widget fullImage() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            child: InteractiveViewer(
              panEnabled: false,
              minScale: 0.5,
              maxScale: 2,
              child: Image.asset(
                fullImagePath,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 25,
            child: MaterialButton(
              minWidth: 30,
              height: 55,
              color: backGroundColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                // side: BorderSide(color: Colors.white, width: 2)
              ),
              onPressed: () {
                setState(() {
                  showFullImage = false;
                });
              },
              child: Icon(
                Icons.close,
                // color: Colors.white,
              ),
              // color: backGroundColor
            ),
          ),
        ],
      ),
    );
  }
}
