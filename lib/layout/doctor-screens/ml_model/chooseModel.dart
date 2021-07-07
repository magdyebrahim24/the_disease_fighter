import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/ml_model/model-screen.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';

class ChooseModel extends StatefulWidget {
  @override
  _ChooseModelState createState() => _ChooseModelState();
}

class _ChooseModelState extends State<ChooseModel> {

  @override
  Widget build(BuildContext context) {
    final modelsDetails = Languages.of(context)!
        .modelsDetails.toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: primaryColor,),onPressed: ()=>Navigator.pop(context),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    color: Color(0x79D5F5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: primaryColor, width: 1)),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              MlModelScreen(data: modelsDetails[0]))),
                  child: Row(
                    children: [

                      Container(
                        width: MediaQuery.of(context).size.width * .32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                             ,
                          color: primaryColor,
                        ),
                        padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/clinics_logo/chest.png",
                              height: 60,
                              width: 60,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                'Covid 19',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                              maxLines: 2,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                              Languages.of(context)!
                              .ml['covidAccuracy'].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: darkBlueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .58,
                                child: Text(
                                  Languages.of(context)!
                                      .ml['covid'].toString(),                                maxLines: 4,
                                  //textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: greyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    color: Color(0x79D5F5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: primaryColor, width: 1)),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => MlModelScreen(
                                data: modelsDetails[1],
                              ))),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .32,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(20),
                          color: primaryColor,
                        ),
                        padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/clinics_logo/Brain.png",
                              height: 60,
                              width: 60,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                Languages.of(context)!
                                    .ml['brainModel'].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                              maxLines: 2,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                              Languages.of(context)!
                              .ml['brainAccuracy'].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: darkBlueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .55,
                                child: Text(
                                  Languages.of(context)!
                                      .ml['brain'].toString(),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: greyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
