import '/provider/cart.dart';

import '/screens/order_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);
  static const routeName = 'appointment';

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
