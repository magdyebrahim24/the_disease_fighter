import 'package:flutter/material.dart';
import 'package:the_disease_fighter/localizations/localization/language/languages.dart';
import 'package:the_disease_fighter/material/constants.dart';
import 'package:the_disease_fighter/material/widgets/full_image.dart';

class PreviousAppointmentDetails extends StatefulWidget {
  final data;

  const PreviousAppointmentDetails({Key? key, this.data}) : super(key: key);

  @override
  _PreviousAppointmentDetailsState createState() =>
      _PreviousAppointmentDetailsState();
}

class _PreviousAppointmentDetailsState
    extends State<PreviousAppointmentDetails> {
  Widget _describeCard({label, subText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          label.toString(),
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: darkBlueColor),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: MediaQuery.of(context).size.width,
          // height: 130,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
              color: lightGreyColor, borderRadius: BorderRadius.circular(10)),
          child: Text(
            subText == null ? 'No Data Found' : subText.toString(),
            style: TextStyle(fontSize: 13, color: subTextColor),
          ),
        ),
      ],
    );
  }

  Widget _appointCard() {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: lightGreyColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:
                            NetworkImage(widget.data.doctorAvatar.toString()),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.doctorName.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        color: darkBlueColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.data.docSpecialization.toString()} Specialist',
                    style: TextStyle(
                      color: subTextColor,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.all(13),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffBCBBBB),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                  // size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    '${widget.data.day.toString()}, ${widget.data.date.toString()} , ${widget.data.time.toString()} ${widget.data.amPm.toString()}',
                    style: TextStyle(color: Colors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          Languages.of(context)!.previousAppointmentDetails['tittle'],
          style: TextStyle(color: primaryColor, fontSize: 16),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appointCard(),
              _describeCard(
                  label: Languages.of(context)!
                      .previousAppointmentDetails['diagnosis'],
                  subText: widget.data.diagnosis),
              _describeCard(
                  label: Languages.of(context)!
                      .previousAppointmentDetails['medicines'],
                  subText: widget.data.medicines),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  Languages.of(context)!.previousAppointmentDetails['files'],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkBlueColor),
                ),
              ),
              widget.data.files.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'No Files Found',
                        style: TextStyle(color: subTextColor),
                      ),
                    )
                  : GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:4,
                      // childAspectRatio: 0.99,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 30,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => FullImage(
                                        fullImagePath:
                                            widget.data.files[index],
                                      )));
                        },
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.5),
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget
                                      .data.files[index]
                                      .toString()))),
                        ),
                      );
                    },
                    itemCount: widget.data.files.length,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
