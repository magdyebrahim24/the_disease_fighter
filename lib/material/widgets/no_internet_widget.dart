import 'package:flutter/material.dart';
import 'package:the_disease_fighter/material/constants.dart';

class FailLoadWidget extends StatelessWidget {
  final fun;

  FailLoadWidget({this.fun});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 120,
            color: primaryColor.withOpacity(.3),
          ),
          Text(
            'Failed To Load , Try Again',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: darkBlueColor.withOpacity(.4)),
          ),
          SizedBox(height: 20,),
          MaterialButton(
            onPressed: fun,
            child: Text(
              'Reload',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            color: primaryColor.withOpacity(.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),

          ),
        ],
      ),
    );
  }
}
