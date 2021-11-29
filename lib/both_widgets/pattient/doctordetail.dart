import '/both_widgets/pattient/appointment.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({Key? key}) : super(key: key);
  static const routeName = 'doctordetailscreen';

  @override
  _DoctorDetailScreenState createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Widget _appbar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BackButton(
            color: Theme.of(context).primaryColor,
          ),
        ],
      );
    }

    return Scaffold();
  }
}
