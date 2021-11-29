import '/screens/user_product_screen.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentWidget extends StatefulWidget {
  const DoctorAppointmentWidget({Key? key}) : super(key: key);

  @override
  Doctor_AppointmentStateWidget createState() =>
      Doctor_AppointmentStateWidget();
}

class Doctor_AppointmentStateWidget extends State<DoctorAppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    return UserProduct();
  }
}
