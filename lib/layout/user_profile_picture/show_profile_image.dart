import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart' ;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/layout/user_profile_picture/edited_profile_image.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/deleteUserImg.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/update_avatar.dart';

class ProfilePicture extends StatefulWidget {
final userAvatar ;
final route;
   ProfilePicture({this.userAvatar,@required this.route}) ;
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? imageFile;

  DeleteUserImageController _deleteUserImageController =
  DeleteUserImageController();

  Future _deleteAvatarFun() async {
    Navigator.pop(context);
    LoaderDialog().onLoading(context);
    final data = await _deleteUserImageController.deleteUserAvatar();
    if(await data['success']){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userAvatar',"https://thediseasefighter.herokuapp.com/static/default.png");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.route,));
    }else{
      Navigator.pop(context);
      errorAlertFun(context,text: data['message']);
    }
  }

  UpdateAvatarController _updateAvatar = UpdateAvatarController();
  Future _updateAvatarFun({File? image}) async {
    LoaderDialog().onLoading(context);
    final data = await _updateAvatar.updateAvatar(
      file: image,
    );
    if(await data['success'] ?? false){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userAvatar',await data['avatar']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.route,));
    }else{
      Navigator.pop(context);
      errorAlertFun(context,text: data['message']);
    }

  }

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await ImagePicker().getImage(source: src);
    if (pickedImageFile != null) {
      Navigator.pop(context);
      _cropImage(imagePath: pickedImageFile.path);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //             ManageSelectedImage(image: File(pickedImageFile.path),route: widget.route,)));
    } else {
      print('No Image Selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.close,color: Colors.white,size: 35,),),),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 80),
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 3,
              scaleEnabled: true,
              child: CachedNetworkImage(
                imageUrl: widget.userAvatar,
                placeholder: (context, url) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: LinearProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width * .4,
            child: MaterialButton(
              minWidth: 100,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.white, width: 2),
              ),
              onPressed: () {
                showAlert(context);
              },
              child: Text(
                'Edit',
                style: TextStyle(fontSize: 16, color: Colors.white),
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
      _updateAvatarFun(image: croppedFile);
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
                  onTap: ()=> _pickImage(ImageSource.camera),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          'Take New Profile Picture ',
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
                          'Select Picture From Gallery',
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
                  onTap: _deleteAvatarFun ,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          'Delete Image',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  snackBarr({text, color}) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
