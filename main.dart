import 'dart:io';

import 'package:clock_dart/screens/add_alarm_screen.dart';
import 'package:clock_dart/screens/clock_screen.dart';
import 'package:clock_dart/screens/tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Providers/add_alarm.dart';
import 'package:provider/provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AddAlarm(),
        ),
      ],
      child: Platform.isAndroid
          ? MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const TabScreenView(),
              routes: {
                AddAlarmScreen.routeName: (ctx) => const AddAlarmScreen(),
                ClockScreen.routeName: (ctx) => const ClockScreen(),
              },
            )
          : CupertinoApp(
              home: const TabScreenView(),
              theme: const CupertinoThemeData(
                primaryColor: Colors.blue,
              ),
              routes: {
                AddAlarmScreen.routeName: (ctx) => const AddAlarmScreen(),
                ClockScreen.routeName: (ctx) => const ClockScreen(),
              },
            ),
    );
  }
}
