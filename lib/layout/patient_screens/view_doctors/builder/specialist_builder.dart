import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/patient_screens/doctor_details/doctor_details.dart';
import 'package:the_disease_fighter/layout/patient_screens/the_appointment/book_appointment.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/empty_list_widget.dart';
import 'package:the_disease_fighter/material/widgets/no_internet_widget.dart';
import 'package:the_disease_fighter/material/widgets/rate_bar.dart';
import 'package:the_disease_fighter/services/specialization/one_specialization_controller.dart';

class ViewDocSpecialistBuilder extends StatefulWidget {
  final clinicId;

  ViewDocSpecialistBuilder({this.clinicId});

  @override
  _ViewDocSpecialistBuilderState createState() =>
      _ViewDocSpecialistBuilderState();
}

class _ViewDocSpecialistBuilderState extends State<ViewDocSpecialistBuilder> {
  OneSpecializationController _oneSpecializationController =
      OneSpecializationController();
  Future _loadOneSpecialization() async {
    var data = await _oneSpecializationController.getOneSpecialization(
        clinicId: widget.clinicId);
    return Future.value(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _loadOneSpecialization(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return FailLoadWidget(
                fun: () {
                  setState(() {
                    _loadOneSpecialization();
                  });
                },
              );
            } else {
              return snapshot.data.success == true
                  ? ListView.builder(
                      itemCount: snapshot.data.doctors.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                                          data: snapshot.data.doctors[index],
                                        ))),
                            child: Row(
                              children: [
                                Container(
                                    // margin: EdgeInsets.only(right: 15),
                                    height: 92,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.4),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            '${snapshot.data.doctors[index].avatar}'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Dr.${snapshot.data.doctors[index].name}',
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
                                        '${snapshot.data.doctors[index].specialization.name.toString()}',
                                        style: TextStyle(
                                          color: Color(0xff8A9EAD),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Rate(
                                            clr: Color(0xff9ADFF7),
                                            rateValue: snapshot.data
                                                .doctors[index].reviews.rates
                                                .toInt(),
                                          ),
                                          MaterialButton(
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookAppointment(
                                                          docName: snapshot
                                                              .data
                                                              .doctors[index]
                                                              .name
                                                              .toString(),
                                                          docId: snapshot
                                                              .data
                                                              .doctors[index]
                                                              .id,
                                                          docImage: snapshot
                                                              .data
                                                              .doctors[index]
                                                              .avatar
                                                              .toString(),
                                                        ))),
                                            height: 30,
                                            minWidth: 65,
                                            child: Text(
                                              Languages.of(context)!
                                                  .allDoctors['bookBtn'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            color: Color(0xff9ADFF7),
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                    )
                  : EmptyListWidget(
                      icon: Icons.perm_contact_cal_sharp,
                      label: 'No Doctors Found',
                      iconSize: 100.0,
                    );
            }
          }
        });
  }
}
