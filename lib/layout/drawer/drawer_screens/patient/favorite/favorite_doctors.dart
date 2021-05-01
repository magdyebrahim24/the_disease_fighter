import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/services/favorite_doctors/controllers/delete_fromFavorite.dart';
import 'package:the_disease_fighter/services/favorite_doctors/controllers/get_favoritesController.dart';

import 'favorite_card.dart';

class FavoriteDoctors extends StatefulWidget {
  @override
  _FavoriteDoctorsState createState() => _FavoriteDoctorsState();
}

class _FavoriteDoctorsState extends State<FavoriteDoctors> {
  GetFavoriteController _getFavoriteDoctors = GetFavoriteController();
  DeleteFromFavoriteController _deleteFromFavorite =
      DeleteFromFavoriteController();

  bool isFavorite = false;

  Future _loadFavorite() async {
    var x = await _getFavoriteDoctors.loadFavoriteList();
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: CircleButton(
          color: primaryColor,
          fun: () => Navigator.pop(context),
          icn: Icons.arrow_back,
        ),
        title: Text(
          Languages.of(context)!.favoriteDoctors['tittle'],
          style: TextStyle(color: darkBlueColor.withOpacity(.8), fontSize: 17),
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: _loadFavorite(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.doctors.length != 0
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    itemCount: snapshot.data.doctors.length ?? 0,
                    itemBuilder: (ctx, index) {
                      return FavoriteCard(
                        data: snapshot.data.doctors[index],
                        deleteFun: () async {
                          await _deleteFromFavorite
                              .deleteFromFavorite(
                                  index: snapshot.data.doctors[index].id)
                              .whenComplete(() {
                            setState(() {
                              snapshot.data.doctors.removeAt(index);
                              snackBarr(
                                  text: Languages.of(context)!
                                      .doctorDetails['snackBarRemove'],
                                  fun: () {},
                                  label: '');
                            });
                          });
                        },
                      );
                    })
                : EmptyPage();
          } else if (snapshot.hasError) {
            return EmptyPage();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  snackBarr({text, fun, label = ''}) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      content: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: primaryColor,
      action:
          SnackBarAction(label: label, textColor: Colors.white, onPressed: fun),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          FontAwesomeIcons.folderOpen,
          color: darkBlueColor.withOpacity(.2),
          size: 70,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'Empty Favorite List',
            style:
                TextStyle(color: darkBlueColor.withOpacity(.4), fontSize: 20),
          ),
        )
      ]),
    );
  }
}
