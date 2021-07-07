import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/doctor_details/doctor_details.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/empty_list_widget.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/services/search/search_controller.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchController _searchController = SearchController();

  String searchText = "";
  Future _searchFun() async {
    final data = await _searchController.loadSearchResult(docName: searchText);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100, 100),
        child: Padding(
          padding: EdgeInsets.only(
            top: 45,
            left: 10,
            right: 10,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: greyColor.withOpacity(.2),
                    ),
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: greyColor.withOpacity(.2),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.name,

                    decoration: InputDecoration(
                      hintText:
                          Languages.of(context)!.search['txt hint'].toString(),
                      hintStyle: TextStyle(
                        color: subTextColor.withOpacity(.6),
                      ),
                      border: InputBorder.none,
                    ),
                    //keyboardType: textInputType,
                    cursorColor: primaryColor,
                    style: TextStyle(color: darkBlueColor.withOpacity(.8)),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 3,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 13, right: 15, left: 15, bottom: 15),
              color: greyColor.withOpacity(.2),
            ),
            searchText != ""
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 28,
                    child: FutureBuilder<dynamic>(
                        future: _searchFun(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (!snapshot.hasData && !snapshot.hasError) {
                            return Center(
                                child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .4),
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(darkBlueColor),
                              ),
                            ));
                          } else {
                            if (snapshot.hasError) {
                              return FailLoadWidget(
                                fun: () {
                                  setState(() {
                                    _searchFun();
                                  });
                                },
                              );
                            } else {
                              return snapshot.data.doctors != null &&
                                      snapshot.data.doctors.length != 0
                                  ? ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      itemBuilder: (ctx, index) => InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DoctorDetails(
                                                        data: snapshot.data
                                                            .doctors[index]))),
                                        child: ListTile(
                                          title: Row(
                                            children: [
                                              Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: greyColor
                                                        .withOpacity(.5),
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot
                                                              .data
                                                              .doctors[index]
                                                              .avatar
                                                              .toString()),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data.doctors[index].name.toString()}',
                                                      style: TextStyle(
                                                          color: darkBlueColor,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      '${snapshot.data.doctors[index].specialization.name.toString()} Specialist',
                                                      style: TextStyle(
                                                          color: subTextColor,
                                                          fontSize: 13.5),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: darkBlueColor,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      itemCount: snapshot.data.doctors.length,
                                      separatorBuilder: (ctx, index) => Divider(
                                        indent: 20,
                                        thickness: 1.2,
                                      ),
                                    )
                                  : EmptyListWidget(
                                      icon: Icons.person_search,
                                      label: searchText == ""
                                          ? Languages.of(context)!
                                              .search['txt hint']
                                              .toString()
                                          : Languages.of(context)!
                                                  .search['no result']
                                                  .toString() +
                                              ' $searchText',
                                      iconSize: 100.0,
                                    );
                            }
                          }
                        }),
                  )
                : emptySearch(
                    text:
                        Languages.of(context)!.search['search for'].toString(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget emptySearch({text}) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 20),
              child: Container(
                child: Image.asset(
                  "assets/icons/search_bg.png",
                  height: 240,
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              Languages.of(context)!.search['what search for'].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: darkBlueColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              Languages.of(context)!.search['search for'].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: subTextColor,
                fontSize: 16,
              ),
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
