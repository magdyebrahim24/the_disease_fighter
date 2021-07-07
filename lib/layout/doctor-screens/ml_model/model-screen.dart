import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/bottom_sheet_item.dart';
import 'package:the_disease_fighter/material/widgets/model_result.dart';
import 'package:the_disease_fighter/services/ml_models/ml_controller.dart';

class MlModelScreen extends StatefulWidget {
  final data;
  const MlModelScreen({this.data});
  @override
  _MlModelScreenState createState() => _MlModelScreenState();
}

class _MlModelScreenState extends State<MlModelScreen> {
  int _show = 0;
  File? _pickerImage;
  final ImagePicker _picker = ImagePicker();

  var _modelResult ;
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

  String? _errorMessage;

  MlModelController _mlModelController = MlModelController();
  Future _uploadXRayImage() async {
    if (_pickerImage != null) {
      setState(() {
        _errorMessage = null;
        _show = 2;
      });
      final response = await _mlModelController.mlModel(
          file: _pickerImage, modelName: 'brain');
      if (response['success']) {
        setState(() {
          _modelResult = response ;
          _show = 3;
        });
      } else {
        setState(() {
          _errorMessage = response['message'];
          _show = 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: .5,
          centerTitle: true,
          leading: _show == 0
              ? CircleButton(
                  fun: () => Navigator.pop(context),
                  icn: Icons.arrow_back,
                  color: primaryColor,
                )
              : SizedBox(),
          actions: [
            CircleButton(
              color: primaryColor,
              icn: Icons.info_outline,
              fun: () => _modelDialog(),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  _show == 3
                      ?  Languages.of(context)!
                      .ml['thankyou'].toString()+'\n${widget.data['name']}'
                      : widget.data['name'],
                  style: TextStyle(
                      fontSize: 22,
                      color: darkBlueColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  _show == 1 && _pickerImage != null
                      ? Languages.of(context)!
                      .ml['pleaseClick']
                      : _show == 2 && _pickerImage != null
                          ? Languages.of(context)!
                      .ml['pleaseClick']
                          : _show == 3
                              ? ' '
                              : Languages.of(context)!
                      .ml['pleaseClick'],
                  style: TextStyle(
                      color: subTextColor.withOpacity(.6),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width,
                ),
                 _show == 1 && _pickerImage != null
                      ? Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: PreviewPickedImage(
                   image: _pickerImage,showModelButtonFun: _showModalBottomSheet,
                 ),
                      )
                      : _show == 2 && _pickerImage != null
                          ? AnalysisLoader()
                          : _show == 3
                              ? ModelResult(
                    result: _modelResult ,
                                )
                              : Center(child: takeImg),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                _errorMessage != null
                    ? Text(
                        _errorMessage.toString(),
                        style: TextStyle(color: Colors.red.withOpacity(.8)),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 15,
                ),
                _show == 1 && _pickerImage != null
                    ? Column(
                        children: [
                          RoundedButton(
                            fun: _uploadXRayImage,
                            text:  Languages.of(context)!
                                .ml['analysis'].toString(),
                            borderRadious: 10.0,
                            minWdthRatio: .8,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * .8,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              setState(() {
                                _show = 0;
                                _errorMessage = null ;
                                _pickerImage = null;
                              });
                            },
                            child: Text(
                                Languages.of(context)!
                                    .cancelBTN.toString(),
                              style:
                                  TextStyle(fontSize: 16, color: primaryColor),
                            ),
                          )
                        ],
                      )
                    : _show == 2 && _pickerImage != null
                        ? SizedBox()
                        : _show == 3
                            ? RoundedButton(
                                fun: () {
                                  setState(() {
                                    _show = 0;
                                    _pickerImage = null;
                                  });
                                },
                                text:  Languages.of(context)!
                                    .ml['end'].toString(),
                                borderRadious: 10.0,
                                minWdthRatio: .8,
                              )
                            : SizedBox(),

                 ],
            ),
          ),
        ));
  }

  // Stack analysis() {
  //   return Stack(
  //     clipBehavior: Clip.hardEdge,
  //     alignment: Alignment.center,
  //     fit: StackFit.loose,
  //     children: [
  //       SizedBox(
  //         child: CircularProgressIndicator(
  //           strokeWidth: 5,
  //           valueColor: AlwaysStoppedAnimation(primaryColor),
  //         ),
  //         height: 150.0,
  //         width: 150.0,
  //       ),
  //       Text(
  //         "Analysing ...",
  //         style: TextStyle(
  //             color: primaryColor, fontWeight: FontWeight.bold, fontSize: 15),
  //       )
  //     ],
  //   );
  // }

  Padding imagePreview() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 30),
      child: Row(
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
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            children: [
              Text(
                '${_pickerImage!.path.split('/').last}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.add_photo_alternate_outlined),
                  onPressed: () => _showModalBottomSheet(),
                  color: primaryColor,
                ),
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget get takeImg {
    return InkWell(
      onTap: () => _showModalBottomSheet(),
      child: DottedBorder(
        dashPattern: [20, 11],
        strokeWidth: 2,
        color: primaryColor.withOpacity(.3),
        strokeCap: StrokeCap.round,
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        child: Container(
          color: lightGreyColor.withOpacity(.7),
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_rounded,
                size: 60,
                color: subTextColor.withOpacity(.8),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                Languages.of(context)!
                    .ml['tapToSelect'].toString(),
                style: TextStyle(
                  color: subTextColor,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomSheetItem(
                    label:  Languages.of(context)!
                  .uploadUserAvatar['takePhoto'].toString(),
                    icon: Icons.camera_alt_rounded,
                    fun: () {
                      _pickImage(ImageSource.camera);
                      setState(() {
                        _show = 1;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  BottomSheetItem(
                      label:  Languages.of(context)!
                          .uploadUserAvatar['selectGallery'].toString(),
                      icon: Icons.photo_library_outlined,
                      fun: () {
                        _pickImage(ImageSource.gallery);
                        setState(() {
                          _show = 1;
                        });
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _modelDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '${Languages.of(context)!
                .explainText.toString()} ${widget.data['name']}',
            style: TextStyle(color: darkBlueColor),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(margin: EdgeInsets.only(bottom: 10),height: 2,color: Colors.grey.withOpacity(.5),width: MediaQuery.of(context).size.width,),
                for (int i = 0; i < 2; i++)
                  Text(
                    '- ${widget.data['note'][i]}',
                    // style: styleForText,
                  ),
                for (int i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 2),
                    child: Text(
                      '▪ ${widget.data['diseases'][i]}',
                      // style: styleForText,
                    ),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text( Languages.of(context)!
                  .closeBTN.toString()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class AnalysisLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 5,
            valueColor: AlwaysStoppedAnimation(primaryColor),
          ),
          height: 150.0,
          width: 150.0,
        ),
        Text(
        Languages.of(context)!
            .ml['analysing'],
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.bold, fontSize: 15),
        )
      ],
    );
  }
}

class PreviewPickedImage extends StatelessWidget {

  final image;final showModelButtonFun;

  const PreviewPickedImage({this.image, this.showModelButtonFun});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              image!,
              fit: BoxFit.fill,
              gaplessPlayback: true,
              scale: 1.0,
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
                children: [
                  Text(
                    '${image!.path.split('/').last}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.add_photo_alternate_outlined),
                      onPressed: showModelButtonFun,
                      color: primaryColor,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
