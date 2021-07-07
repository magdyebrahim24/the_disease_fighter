// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:the_disease_fighter/layout/user_profile_picture/edited_profile_image.dart';
// import 'package:the_disease_fighter/material/constants.dart';
//
// class UploadUserAvatar extends StatelessWidget {
// final route;
//
//   const UploadUserAvatar({Key? key, this.route}) : super(key: key);
//   void _pickImage(ImageSource src,context) async {
//     final pickedImageFile = await ImagePicker().getImage(source: src);
//     if (pickedImageFile != null) {
//       Navigator.pop(context);
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (BuildContext context) =>
//                   ManageSelectedImage(image: File(pickedImageFile.path),route: route,)));
//     } else {
//       print('No Image Selected');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading:  false,
//         elevation: 1,
//         title: Text('Profile Picture',style: TextStyle(color: darkBlueColor,)),
//         actions: [
//           MaterialButton(onPressed: (){
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route,));
//           },child: Text('Skip',style: TextStyle(color: darkBlueColor,)),)
//
//         ],
//       ),
//       body: Center(
//         child: InkWell(
//           onTap: ()=> showAlert(context) ,
//           child: Stack(
//             fit: StackFit.loose,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           color: subTextColor,
//                           offset: Offset(-1.0, 2.0),
//                           blurRadius: 3.0,
//                           spreadRadius: .5),
//                     ],
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Color(0xffFDFDFD), width: 2),
//                     color: backGroundColor),
//                 margin: EdgeInsets.all(10),
//                 height: 190,
//                 width: 190,
//                 child: Icon(Icons.person,size: 150,color: subTextColor.withOpacity(.4),),
//               ),
//               Positioned(bottom: 10,right: 10,child: Container(decoration: BoxDecoration(color: primaryColor,shape: BoxShape.circle),padding: EdgeInsets.all(15),child: Icon(Icons.add_a_photo,size: 30,color: Colors.white,))),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void showAlert(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                   onTap: ()=> _pickImage(ImageSource.camera,context),
//                   child: Padding(
//                     padding: EdgeInsets.all(15.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Take New Profile Picture ',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   )),
//               Divider(
//                 height: 1,
//                 thickness: 1,
//                 indent: 10,
//                 endIndent: 10,
//               ),
//               InkWell(
//                   onTap: () => _pickImage(ImageSource.gallery,context),
//
//                   child: Padding(
//                     padding:
//                     EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Select Picture From Gallery',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   )),
//             ],
//           ),
//         ));
//   }
//
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/layout/user_profile_picture/edited_profile_image.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/update_avatar.dart';

class UploadUserAvatar extends StatefulWidget {
  final route;
  UploadUserAvatar({ this.route});

  @override
  _UploadUserAvatarState createState() => _UploadUserAvatarState();
}

class _UploadUserAvatarState extends State<UploadUserAvatar> {
  void _pickImage(ImageSource src) async {
    final pickedImageFile = await ImagePicker().getImage(source: src);
    if (pickedImageFile != null) {
      Navigator.pop(context);
      _cropImage(imagePath: pickedImageFile.path);

    } else {
      print('No Image Selected');
    }
  }

  File? imageFile;

  UpdateAvatarController _updateAvatar = UpdateAvatarController();

  Future _updateAvatarFun({File? image}) async {
    LoaderDialog().onLoading(context);
    final data = await _updateAvatar.updateAvatar(
      file: image,
    );
    if(await data['success'] ?? false){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userAvatar',await data['avatar']);
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute(builder: (context) => widget.route,),
            (route) => false,
      );
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.route,));
    }else{
      Navigator.pop(context);
      errorAlertFun(context,text: data['message']);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xffF4F4F4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // logo
                  Container(
                    margin: EdgeInsets.all(25),
                    width: 200,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/logo.png',
                        ),
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .05,
                          vertical: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50)),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 5),
                            child: Text(
                              Languages.of(context)!
                                  .uploadUserAvatar['welcome'].toString(),
                              style:
                                  TextStyle(fontSize: 25, color: darkBlueColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Disease Fighter',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: darkBlueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            Languages.of(context)!
                                .uploadUserAvatar['subText'].toString(),
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15,
                              color: greyColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .1,bottom: MediaQuery.of(context).size.height * .15),
                            child: Center(
                              child: InkWell(
                                onTap: () => showAlert(context),
                                child: Stack(
                                  fit: StackFit.loose,
                                  children: [
                                    imageFile == null ?
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: primaryColor,
                                                offset: Offset(0.0, 1.0),
                                                blurRadius: 6.0,
                                                spreadRadius: 1),
                                          ],
                                          image:  DecorationImage(
                                              image:AssetImage("assets/icons/person.png"),
                                              fit: BoxFit.scaleDown),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: primaryColor, width: 2),
                                          color: primaryColor),
                                      height: 140,
                                      width: 140,
                                    ) :
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(0.0, 1.0),
                                                blurRadius: 10.0,
                                                spreadRadius: 1),
                                          ],
                                          image:  DecorationImage(
                                              image: FileImage(imageFile!),
                                              fit: BoxFit.scaleDown),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.grey.withOpacity(.5),width: 2),
                                          color: Colors.grey.withOpacity(.6)),
                                      height: 140,
                                      width: 140,
                                    ) ,
                                    Positioned(
                                        bottom: 10,
                                        right: 7,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: backGroundColor,
                                                shape: BoxShape.circle),
                                            padding: EdgeInsets.all(7),
                                            child: Icon(
                                              Icons.add_a_photo,
                                              size: 20,
                                              color: primaryColor,
                                            ))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          imageFile != null ? InkWell(
                            onTap: ()=> _updateAvatarFun(image: imageFile) ,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: backGroundColor,
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 6.0,
                                        spreadRadius: 2),
                                  ],
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              height: 50,
                              child: Center(
                                child: Text(
                                  Languages.of(context)!
                                      .saveButton.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ) : SizedBox(height: MediaQuery.of(context).size.height * .04,),
                          SizedBox(height: 15,),
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => widget.route,
                                ),
                                    (route) => false,
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: backGroundColor,
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 6.0,
                                        spreadRadius: 2),
                                  ],
                                  color: backGroundColor,
                                  borderRadius: BorderRadius.circular(15)),
                              height: 50,
                              child: Center(
                                child: Text(
                                  Languages.of(context)!
                                      .introSkip.toString(),
                                  style: TextStyle(
                                      color: subTextColor, fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _cropImage({imagePath}) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imagePath,
        aspectRatioPresets: Platform.isAndroid
        ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
        ]
        : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Move and Scale',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          backgroundColor: Colors.black,
          hideBottomControls: true,
          showCropGrid: false,
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Move and Scale',
        ));
    if (croppedFile != null) {
      setState(() {
        imageFile = croppedFile ;
      });
    }else{
      imageFile = null ;
    }
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () => _pickImage(ImageSource.camera),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Text(
                              Languages.of(context)!
                                  .uploadUserAvatar['takePhoto'].toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  InkWell(
                      onTap: () => _pickImage(ImageSource.gallery),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              Languages.of(context)!
                                  .uploadUserAvatar['selectGallery'].toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ));
  }
}
