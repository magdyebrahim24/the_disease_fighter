import 'package:flutter/material.dart';
import 'package:the_disease_fighter/material/constants.dart';

class PreviousAppointmentDetails extends StatefulWidget {
  @override
  _PreviousAppointmentDetailsState createState() =>
      _PreviousAppointmentDetailsState();
}

class _PreviousAppointmentDetailsState
    extends State<PreviousAppointmentDetails> {
  bool showFullImage = false;
  String fullImagePath;
  List img = [
    "assets/images/file1.jpg",
    "assets/images/file3.jpg",
    "assets/images/file2.jpg",
    "assets/images/file3.jpg",
    "assets/images/file1.jpg",
    "assets/images/file2.jpg",
  ];

  Widget _discribCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: lightGreyColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        "Lorem Ipsum is simply dummy text the printing typesetting and  industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
        style: TextStyle(fontSize: 13, color: subTextColor),
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
                    Text(
                      "Mansoura, Egypt",
                      style: TextStyle(
                        fontSize: 12,
                        color: subTextColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            height: 45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffBCBBBB),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 13,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Monday, 08.00am - 10.00am",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Meeting",
              style: TextStyle(color: primaryColor, fontSize: 16),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: primaryColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _appointCard(),
                  _txt("Diagnosis"),
                  _discribCard(),
                  _txt("Medicines"),
                  _discribCard(),
                  _txt("Files"),
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
      ],
    );
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
