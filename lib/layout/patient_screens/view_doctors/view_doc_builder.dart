import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/doctor_details/doctor_details.dart';
import 'package:the_disease_fighter/layout/patient_screens/the_appointment/book_appointment.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/rate_bar.dart';
import 'package:the_disease_fighter/services/doctors/controllers/get_all_doctors_controller.dart';
import 'package:the_disease_fighter/services/doctors/models/get_all_doctors_model.dart';

class ViewDocBuilder extends StatelessWidget {
  ViewDocBuilder({required this.data});
  GetAllDoctorsController _getAllDoctorsController=GetAllDoctorsController();
  GetAllDoctorsModel _getAllDoctorsModel=GetAllDoctorsModel();
  Future _loadAllDoctors() async {
    var data = await _getAllDoctorsController.allDoctorsData();
    return data;
  }

  final List data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (ctx, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Color(0xffD7E9F5)),
          ),
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DoctorDetails(
                          data: data[index],
                        ))),
            child: Row(
              children: [
                Container(
                  // margin: EdgeInsets.only(right: 15),
                    height: 92,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage('${data[index].doctorImg}'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    )),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dr.${data[index].doctorName}',
                        style: TextStyle(
                          color: darkBlueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${data[index].pecialty}',
                        style: TextStyle(
                          color: Color(0xff8A9EAD),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Text('${data[index].address}',style: TextStyle(color: Color(0xff8A9EAD),fontSize: 14,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Rate(
                            clr: Color(0xff9ADFF7),
                            rateValue: data[index].rate.toInt(),
                          ),
                          MaterialButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookAppointment())),
                            height: 30,
                            minWidth: 65,
                            child: Text(
                              Languages.of(context)!.allDoctors['bookBtn'],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            color: Color(0xff9ADFF7),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
