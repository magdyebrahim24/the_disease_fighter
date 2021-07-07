import 'package:flutter/services.dart' ;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/inductors/loader_dialog.dart';
import 'package:the_disease_fighter/services/logged_user/controllers/update_avatar.dart';

class ManageSelectedImage extends StatefulWidget {
  final image;
  final route ;
  ManageSelectedImage({this.image,@required this.route});

  @override
  _ManageSelectedImageState createState() => _ManageSelectedImageState();
}

class _ManageSelectedImageState extends State<ManageSelectedImage> {
  UpdateAvatarController _updateAvatar = UpdateAvatarController();
  Future _updateAvatarFun() async {
    LoaderDialog().onLoading(context);
    final data = await _updateAvatar.updateAvatar(
      file: widget.image,
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
            onPressed: _updateAvatarFun,
            child: Text(Languages.of(context)!
                .saveButton.toString(),style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold),),
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

}

void errorAlertFun(BuildContext context,{text}) {
  showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          Positioned(
            bottom: 25,
            left: 10,
            right: 10,
            child: AlertDialog(
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                backgroundColor: Colors.redAccent,
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                content: Row(
                  children: [
                    Expanded(child: Text(text ?? 'Some Thing Went wrong , Try Again',style: TextStyle(color: Colors.white),)),
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
