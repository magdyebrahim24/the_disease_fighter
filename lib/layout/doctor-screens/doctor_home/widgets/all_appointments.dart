import 'package:flutter/material.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/widgets/filter_dates.dart';
import 'package:the_disease_fighter/layout/doctor-screens/doctor_home/widgets/metting_card.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/bottons/circleBtn.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/empty_list_widget.dart';
class AllAppointments extends StatefulWidget {
  final data;

  const AllAppointments({Key? key, this.data}) : super(key: key);

  @override
  _AllAppointmentsState createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {
  Future _filterByDate() async {
    final time = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.utc(DateTime.now().year + 1),
    );
    print(time.toString().split(" ")[0]);
    if (time != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FilteredDates(pickedTime: time)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 10, 5),
            child: Row(
              children: [
                Expanded(
                    child: Text(
            Languages.of(context)!.doctorHome['allAppointments'],
                  style: kHeadStyle,
                )),
                ImgButton(
                  fun: _filterByDate,
                  img: 'assets/icons/filter.png',
                  imgWidth: 16.0,
                  imgHigh: 21.0,
                ),
              ],
            ),
          ),
          widget.data.length != 0 && widget.data.length != null
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.data.length,
                  itemBuilder: (ctx, index) {
                    return MeetingCard(
                      data: widget.data[index],
                    );
                  })
        : Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .25),
          child: EmptyListWidget(icon: Icons.date_range_outlined,label:   Languages.of(context)!.doctorProfile['editProfile']['no appointments'].toString(),iconSize: 100.0,),
        )

        ],
      ),
    );
  }
}
