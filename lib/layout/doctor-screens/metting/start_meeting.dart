
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/doctor_home.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
class StartMeeting extends StatefulWidget {
  final data;

  const StartMeeting({Key? key, this.data}) : super(key: key);
  @override
  _StartMeetingState createState() => _StartMeetingState();
}

class _StartMeetingState extends State<StartMeeting> {
  int _show = 0;
  File? _pickerImage;
  bool _cancelPressed = false;
  bool _pickedImage=false;
  final ImagePicker _picker = ImagePicker();

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

  Future _asyncConfirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          buttonPadding: EdgeInsets.symmetric(horizontal: 20),
          content: const Text("Are you sure to end the meeting?"),
          contentTextStyle: TextStyle(
              color: darkBlueColor, fontSize: 16, fontWeight: FontWeight.bold),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .3,
                child: Center(
                  child: Text(
                    "Cancel",
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
              onTap: () =>
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DoctorHome())),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .3,
                height: 40,
                child: Center(
                  child: Text(
                    "Okay",
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
      margin: EdgeInsets.symmetric(vertical: 5),
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
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
          color: lightGreyColor, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            children: [
              Container(

                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: backGroundColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(widget.data.patientAvatar.toString()),
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
                        fontSize: 14,
                        color: darkBlueColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "specialization is needed",
                    style: TextStyle(
                      fontSize: 12,
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .6,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "End Meeting",
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
          actions: [
            ImgButton(
              img: 'assets/icons/model.png',
              imgHigh: 35.0,
              imgWidth: 35.0,
            ),
          ],
          centerTitle: true,
          title: Text(
            "Meeting",
            style: TextStyle(color: primaryColor, fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _appointCard(),
                _txt("Add a diagnosis"),
                _textField(),
                _txt("Add a Medicine"),
                _textField(),
                _txt("Add Image"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        InkWell(
                      onTap: (){
                        _pickImage(ImageSource.gallery);
                      }
                          ,child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: lightGreyColor,
                                borderRadius: BorderRadius.circular(10)),
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
                          "Camera",
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
                              _cancelPressed=false;
                              _pickedImage=true;
                            });
                          }, child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: lightGreyColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Image.asset(
                              "assets/icons/addimage.png", height: 40,
                              width: 40,
                              fit: BoxFit.contain,),
                          ),
                        ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
               // ignore: unnecessary_null_comparison
               _pickerImage!=null? imagePreview():SizedBox(),
                _txt("Recent Files"),
                SizedBox(
                  height: ((img.length / 4) * 150).toDouble(),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery
                          .of(context)
                          .size
                          .width ~/ 85,
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
            height: MediaQuery
                .of(context)
                .size
                .height,
            alignment: Alignment.center,
            color: Colors.black,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: InteractiveViewer(
              panEnabled: false,
              minScale: 0.5,
              maxScale: 2,
              child: Image.asset(
                fullImagePath,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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

  Padding imagePreview() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 30),
      child:  _cancelPressed==false &&_pickedImage==true?Column(
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
                 width: 80,
                 height: 80,
               ),
             ),
             SizedBox(
               width: 10,
             ),
             Expanded(
                 child: Text(
                   '${_pickerImage!.path
                       .split('/')
                       .last}',
                   maxLines: 3,
                   overflow: TextOverflow.ellipsis,
                 )),
           ],
         ),
         SizedBox(
           height: 20,
         ),
         Row(
           children: [
             InkWell(
               onTap: (){},
               child: Container(
                 height: 40,
                 width: MediaQuery.of(context).size.width*.2,
                 decoration: BoxDecoration(
                   color: primaryColor,
                   borderRadius: BorderRadius.circular(8),


                 ),
                 child:Center(
                   child: Text("Save",style: TextStyle(
                       fontSize: 14,
                       color: Colors.white,
                       fontWeight: FontWeight.bold
                   ),),
                 ) ,
               ),
             ),
             SizedBox(width: 10,),
             InkWell(
               onTap: (){
                 setState(() {
                   _cancelPressed=true;
                   _pickedImage=false;
                 });
               },
               child: Container(
                 height: 40,
                 width: MediaQuery.of(context).size.width*.2,
                 decoration: BoxDecoration(
                   color: lightGreyColor,
                   borderRadius: BorderRadius.circular(8),
                 ),
                 child:Center(
                   child: Text("Cancel",style: TextStyle(
                       fontSize: 14,
                       color: primaryColor,
                       fontWeight: FontWeight.bold
                   ),),
                 ) ,
               ),
             ),
           ],
         )

]):SizedBox());
  }
}