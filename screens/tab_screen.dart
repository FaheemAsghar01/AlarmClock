import 'package:clock_dart/screens/alarm_screen.dart';
import 'package:clock_dart/screens/clock_screen.dart';
import 'package:flutter/material.dart';

class TabScreenView extends StatefulWidget {
  const TabScreenView({Key? key}) : super(key: key);

  @override
  State<TabScreenView> createState() => _TabScreenViewState();
}

class _TabScreenViewState extends State<TabScreenView> {
  final List<Widget> _screens = [
    const AlarmScreen(),
    const ClockScreen(),
  ];

  int index = 0;
  void _screenSelect(int ind) {
    setState(() {
      index = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _screenSelect,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.alarm,
              //color: Colors.blue,
            ),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.lock_clock,
              //color: Colors.blue,
            ),
            label: 'Clock',
          ),
        ],
      ),
    );
  }
}
