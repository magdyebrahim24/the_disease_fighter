import 'package:flutter/material.dart';
import 'package:the_disease_fighter/data/doctor_data.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText = '';

  _getEmail(String searchText) {
    setState(() {
      this.searchText = searchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            color: primaryColor,
          ),
          leadingWidth: 40,
          title: Container(
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor.withOpacity(.2)),
                color: backGroundColor,
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: Languages.of(context)!.search,
                        hintStyle: TextStyle(
                          color: subTextColor.withOpacity(.6),
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                      cursorColor: primaryColor,
                      style: TextStyle(
                          color: subTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w800),
                      onChanged: (value) {
                        _getEmail(value);
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: lightGreyColor,
                  ),
                  child: ImgButton(
                    fun: () {},
                    img: 'assets/icons/search2.png',
                    imgWidth: 20.0,
                    imgHigh: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 30),
          itemBuilder: (ctx, index) => ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    '${doctorsData[index].doctorName}',
                    style: TextStyle(color: darkBlueColor),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: darkBlueColor,
                  size: 15,
                )
              ],
            ),
          ),
          itemCount: doctorsData.length,
          separatorBuilder: (ctx, index) => Divider(
            indent: 15,
          ),
        ));
  }
}
