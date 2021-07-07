import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/drawer/drawer_screens/doctor/ml_model/model-screen.dart';
import 'package:the_disease_fighter/material/constants.dart';

class ChooseModel extends StatefulWidget {
  @override
  _ChooseModelState createState() => _ChooseModelState();
}

class _ChooseModelState extends State<ChooseModel> {
  static TextStyle styleForText = TextStyle(fontSize: 16, color: darkBlueColor);

  List modelsDetails = [
    {
      'name': 'Covid19 Model',
      'modelName': 'covid19',
      'note': [
        'Model accuracy 90%',
        'It illustrates your disease from 3 diseases:'
      ],
      'diseases': ['Covid19', 'Viral Pneumonia', 'Normal']
    },
    {
      'name': 'Brain Tumor Model',
      'modelName': 'brain',
      'note': [
        'Model accuracy 90%',
        'It illustrates your disease from 3 diseases:'
      ],
      'diseases': ['Glioma', 'Meningioma', 'Pituitary']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Using ML')),
      ),
      body:Center(

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              for (int index = 0; index < modelsDetails.length; index++)
                InkWell(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=> MlModelScreen(data: modelsDetails[index],))),
                  child: Card(
                    margin: EdgeInsets.all(15),
                    color: primaryColor.withOpacity(.8),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                            modelsDetails[index]['name'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          for (int i = 0; i < 2; i++)
                            Text(
                              '- ${modelsDetails[index]['note'][i]}',
                              style: styleForText,
                            ),
                          for (int i = 0; i < 3; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 2),
                              child: Text(
                                '▪ ${modelsDetails[index]['diseases'][i]}',
                                style: styleForText,
                              ),
                            ),
                        ],
                      ),
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
