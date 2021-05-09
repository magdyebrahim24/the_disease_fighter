import 'package:flutter/material.dart';

import '../constants.dart';
class FullImage extends StatelessWidget {
  final fullImagePath;

  const FullImage({Key? key, this.fullImagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              child: Image.network(
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
                Navigator.pop(context);
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
