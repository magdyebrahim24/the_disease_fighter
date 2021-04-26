import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/sign/sign_in/sign_in.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/bottons/roundedBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  PageController _pageController = PageController();
  double currentPage = 0;
  List intro = [
    'assets/intro/illustraion.png',
    'assets/intro/illustraion2.png',
    'assets/intro/illustraion3.png',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: currentPage != 0
            ? CircleButton(
                fun: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 250), curve: Curves.ease),
                icn: Icons.arrow_back,
                color: darkBlueColor,
              )
            : SizedBox(),
        actions: [
          currentPage != 2
              ? MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                  ),
                  child: Text(
                    Languages.of(context)!.introSkip,
                    style: TextStyle(
                      fontSize: 16,
                      color: subTextColor.withOpacity(.7),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
      body: PageView.builder(
        physics: PageScrollPhysics(),
        controller: _pageController,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // image
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(intro[index].toString()),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(
                  Languages.of(context)!.introInformation[index]['headTxt'],
                  // intro[index]['headTxt'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: darkBlueColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 39),
                  child: Text(
                    Languages.of(context)!.introInformation[index]['subTxt'],
                    // intro[index]['subTxt'],
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
        onPageChanged: (index) {
          setState(() {
            currentPage = index.toDouble();
          });
        },
      ),
      bottomNavigationBar: currentPage != 2
          ? BottomAppBar(
              elevation: 0.0,
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        for (var i = 0; i < 3; i++)
                          Container(
                            width: currentPage == i ? 20 : 10,
                            height: 10,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: currentPage == i
                                  ? primaryColor
                                  : Colors.transparent,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      '${currentPage.toInt() + 1}/3',
                      style: TextStyle(color: greyColor),
                    ),
                    MaterialButton(
                      onPressed: () => _pageController.nextPage(
                          duration: Duration(milliseconds: 250),
                          curve: Curves.easeIn),
                      color: primaryColor,
                      elevation: 3.0,
                      hoverElevation: 5.0,
                      padding: EdgeInsets.all(0),
                      splashColor: primaryColor.withOpacity(.65),
                      minWidth: 50,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    )
                  ],
                ),
              ),
            )
          : BottomAppBar(
              elevation: 0.0,
              color: Colors.white,
              child: Padding(
                padding:
                    EdgeInsets.only(right: 40, left: 40, bottom: 20, top: 10),
                child: RoundedButton(
                  fun: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                  ),
                  text: 'Get Started',
                  borderRadious: 10,
                  minWdthRatio: .8,
                ),
              ),
            ),
    );
  }
}
