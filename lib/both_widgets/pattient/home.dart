import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product.dart';
import 'package:shopapp/screens/product_screen_overview.dart';

class PatientHomeWidget extends StatefulWidget {
  const PatientHomeWidget({Key? key}) : super(key: key);

  @override
  Patient_HomeStateWidget createState() => Patient_HomeStateWidget();
}

class Patient_HomeStateWidget extends State<PatientHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return ProductOverview();
  }
}
