import 'package:flutter/material.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/empty_list_widget.dart';
import 'package:the_disease_fighter/material/widgets/materialBanner.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
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

  String? _errorMessage;
  bool _showBanner = false;
  Future _loadFavorite() async {
    var data = await _getFavoriteDoctors.loadFavoriteList();
    return data;
  }

  int? _deleteDocDateLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 1,
            leading: CircleButton(
              color: darkBlueColor,
              fun: () => Navigator.pop(context),
              icn: Icons.arrow_back,
            ),
            title: Text(
              Languages.of(context)!.favoriteDoctors['tittle'],
              style:
                  TextStyle(color: darkBlueColor.withOpacity(.8), fontSize: 17),
            ),
          ),
          body: FutureBuilder<dynamic>(
            future: _loadFavorite(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData && !snapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return FailLoadWidget(
                    fun: () {
                      setState(() {
                        _loadFavorite();
                      });
                    },
                  );
                } else {
                  return snapshot.data.doctors.length != 0
                      ? ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          itemCount: snapshot.data.doctors.length ?? 0,
                          itemBuilder: (ctx, index) {
                            return FavoriteCard(
                              data: snapshot.data.doctors[index],
                              iconWidget: _deleteDocDateLoading != index
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: primaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          _deleteDocDateLoading = index;
                                          _showBanner = false;
                                        });
                                        final response =
                                            await _deleteFromFavorite
                                                .deleteFromFavorite(
                                                    docId: snapshot.data
                                                        .doctors[index].id);
                                        if (response['success'] == true) {
                                          setState(() {
                                            snapshot.data.doctors
                                                .removeAt(index);
                                            _deleteDocDateLoading = null ;
                                          });
                                          snackBarr(
                                              text: Languages.of(context)!
                                                  .doctorDetails[
                                              'snackBarRemove'],
                                              fun: () {},
                                              label: '');
                                        } else {
                                          setState(() {
                                            _deleteDocDateLoading = null ;
                                            _errorMessage = response['message'];
                                            _showBanner = true;
                                          });
                                        }
                                      },
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator
                                              .adaptive(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          primaryColor))),
                                    ),
                            );
                          })
                      : EmptyListWidget(icon: Icons.library_add,label: Languages.of(context)!
                      .favoriteDoctors['noFav'].toString(),iconSize: 100.0,);
                }
              }
            },
          ),
        ),
        _showBanner
            ? SizedBox(
                height: 130,
                child: ErrorMaterialBanner(
                  errorMessage: _errorMessage,
                  fun: () {
                    setState(() {
                      _showBanner = false;
                    });
                  },
                ),
              )
            : SizedBox()
      ],
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
