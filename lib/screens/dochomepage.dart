import 'package:shopapp/both_widgets/doctor/docprofile.dart';

import '/both_widgets/doctor/appointment.dart';
import 'package:flutter/material.dart';

class DocHomePage extends StatefulWidget {
  const DocHomePage({Key? key}) : super(key: key);
  static const routeName = 'docDochomepage';

  @override
  State<DocHomePage> createState() => _DocHomePageState();
}

/// This is the private State class that goes with DocHomePage.
class _DocHomePageState extends State<DocHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    DoctorAppointmentWidget(),
    DocProfileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('DocHomePage'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Appontments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Update',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
