import 'dart:io';

import 'package:clock_dart/widgets/clock_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);
  static const routeName = '/clock-screen';

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  Widget _bodyPage() {
    return Container(
      alignment: Alignment.center,
      child: ClockPainterScreen(AppBar().preferredSize.height),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _bodyPage(),
            navigationBar: const CupertinoNavigationBar(
              middle: Text(
                'Clock',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
          )
        : Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: const Text(
                'Clock',
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: _bodyPage(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              //backgroundColor: Colors.blue,
              child: const Icon(Icons.language_outlined),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
