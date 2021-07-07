import 'dart:io';
import 'package:flutter/services.dart' ;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'layout/user_profile_picture/src/simpleCrop.dart';

class ProfilePicture extends StatefulWidget {

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {



  void _pickImage(ImageSource src) async {
    final pickedImageFile = await ImagePicker().getImage(source: src);
    if (pickedImageFile != null) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  SimpleCropRoute(image: File(pickedImageFile.path),)));
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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 3,
              scaleEnabled: true,
              child: Image.network(
                "https://picsum.photos/250?image=9",
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                fit: BoxFit.contain,
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

          // CachedNetworkImage(
          //   imageUrl: "https://picsum.photos/250?image=9",
          //   imageBuilder: (context, imageProvider) => Container(
          //     height:300,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: imageProvider,
          //           fit: BoxFit.fitWidth,
          //           colorFilter:
          //           ColorFilter.mode(Colors.red, BlendMode.colorBurn)
          // ),
          // ),
          // ),
          // placeholder: (context, url) => CircularProgressIndicator(),
          // errorWidget: (context, url, error) => Icon(Icons.error),
          // ),
          // SizedBox(height: 100,),
          // CachedNetworkImage(
          //   width: MediaQuery.of(context).size.width,
          //   imageUrl: "https://picsum.photos/250?image=9",
          //   placeholder: (context, url) => CircularProgressIndicator(),
          //   errorWidget: (context, url, error) => Icon(Icons.error),
          // ),
        ],
      ),
    );
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
                        // if (_pickerImage != null) {
                        //   Navigator.pop(context);
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (BuildContext context) =>
                        //               ManageSelectedImage(image: _pickerImage,)));
                        // }
                      // },
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

class ManageSelectedImage extends StatefulWidget {
  final image;
  ManageSelectedImage({this.image});

  @override
  _ManageSelectedImageState createState() => _ManageSelectedImageState();
}

class _ManageSelectedImageState extends State<ManageSelectedImage> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // title: Text("Move and Scale"),
        leading: IconButton(
          icon: Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: (){},
            child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold),),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: Image.file(
          widget.image,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
  void showAlert(BuildContext context,{text}) {
    showDialog(
        context: context,
        builder: (context) => Stack(
          children: [
            Positioned(
              bottom: 25,
              left: 45,
              child: AlertDialog(
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                backgroundColor: Colors.redAccent,
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                content: Row(
                  children: [
                    Expanded(child: Text(text.toString(),style: TextStyle(color: Colors.white),)),
                    MaterialButton(onPressed: (){Navigator.pop(context);},child: Icon(Icons.close,color: Colors.white,size: 20,),height: 25,minWidth: 25,padding: EdgeInsets.all(3),materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),)
                  ],
                )
              ),
            ),
          ],
        ));
  }

}



class SimpleCropRoute extends StatefulWidget {
  final image;

  SimpleCropRoute({Key? key, this.image}) : super(key: key);
  @override
  _SimpleCropRouteState createState() => _SimpleCropRouteState();
}

class _SimpleCropRouteState extends State<SimpleCropRoute> {
  final cropKey = GlobalKey<ImgCropState>();

  Future<Null> showImage(BuildContext context, File file) async {
    new FileImage(file)
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      print('-------------------------------------------$info');
    }));
    return showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                'Current screenshot：',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1.1),
              ),
              content: Image.file(file));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Zoom and Crop',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon:
            new Icon(Icons.navigate_before, color: Colors.black, size: 40),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: ImgCrop(
            key: cropKey,
            chipRadius: 100,
            chipShape: ChipShape.circle,
            chipRatio: 2 / 1,
            maximumScale: 3,
            image: FileImage(widget.image),
            // handleSize: 0.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final crop = cropKey.currentState;
            final croppedFile =
            await crop!.cropCompleted(widget.image, preferredSize: 1000);
            showImage(context, croppedFile);
          },
          tooltip: 'Increment',
          child: Text('Crop'),
        ));
  }
}
