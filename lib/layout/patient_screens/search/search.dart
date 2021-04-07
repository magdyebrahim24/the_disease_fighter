import 'package:flutter/material.dart';
import 'package:the_disease_fighter/data/doctor_data.dart';
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
          // elevation: .5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            color: primaryColor,
          ),
          leadingWidth: 30,
          title: Container(
            padding: EdgeInsets.only(right: 0, left: 15),
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor.withOpacity(.2)),
                color: backGroundColor,
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Doctor Search ...',
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
                SizedBox(
                  width: 10,
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
