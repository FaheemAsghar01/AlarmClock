//import 'package:clock_dart/screens/add_alarm_screen.dart';

import 'dart:io';

import 'package:clock_dart/Providers/add_alarm.dart';
import 'package:clock_dart/screens/add_alarm_screen.dart';
import 'package:clock_dart/widgets/remove_alarm.dart';
import 'package:clock_dart/widgets/show_alarm.dart';
import 'package:flutter/cupertino.dart';
//import 'package:clock_dart/screens/clock_screen.dart';
//import 'package:clock_dart/screens/clock_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);
  static const routeName = '/alarm-screen';

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool change = false;
  bool selectAll = false;
  final iconData = const Icon(Icons.clear);

  Widget _bodyPage(AddAlarm alarmList) {
    return alarmList.getAlarms.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.alarm_off_sharp,
                  size: 120,
                  color: Color.fromARGB(255, 156, 150, 150),
                ),
                Text(
                  'No Alarms',
                  style: TextStyle(
                    color: Color.fromARGB(255, 156, 150, 150),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                value: alarmList.getAlarms[i],
                child: GestureDetector(
                  onTap: change == false
                      ? () {
                          Navigator.of(context).pushNamed(
                              AddAlarmScreen.routeName,
                              arguments: alarmList.getAlarms[i].id);
                        }
                      : () {},
                  onLongPress: () {
                    appBarData();
                    print('not working');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: change == false
                        ? ShowAlarm(
                            alarmList.getAlarms[i],
                            context,
                          )
                        : RemoveAlarm(
                            alarmList.getAlarms[i],
                          ),
                  ),
                ),
              ),
              itemCount: alarmList.getAlarms.length,
            ),
          );
  }

  Widget _title(AddAlarm alarmList) {
    return change == false || alarmList.getAlarms.isEmpty
        ? const Text(
            '  Alarm',
            style: TextStyle(color: Colors.black),
          )
        : Container();
  }

  void appBarData() {
    setState(() {
      change = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final alarmList = Provider.of<AddAlarm>(context);
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _bodyPage(alarmList),
            navigationBar: CupertinoNavigationBar(
              middle: _title(alarmList),
              leading: change == false || alarmList.getAlarms.isEmpty
                  ? null
                  : GestureDetector(
                      child: const Icon(CupertinoIcons.clear),
                      onTap: () {
                        setState(() {
                          change = false;
                        });
                      },
                    ),
              trailing: CupertinoContextMenu(
                actions: [
                  change == false || alarmList.getAlarms.isEmpty
                      ? CupertinoContextMenuAction(
                          trailingIcon: CupertinoIcons.settings,
                          onPressed: () {},
                          child: const Text('Settings'),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              selectAll = !selectAll;
                            });
                          },
                          child: const Icon(Icons.select_all)),
                ],
                child: const Icon(
                  CupertinoIcons.settings,
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: _title(alarmList),
              leading: change == false || alarmList.getAlarms.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          change = false;
                          selectAll = false;
                        });
                      },
                    ),
              actions: [
                change == false || alarmList.getAlarms.isEmpty
                    ? PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (_) => [
                          const PopupMenuItem(
                            child: Text('Settings'),
                          ),
                        ],
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            selectAll = !selectAll;
                          });
                        },
                        icon: const Icon(Icons.select_all)),
              ],
            ),
            body: _bodyPage(alarmList),
            floatingActionButton: FloatingActionButton(
              onPressed: selectAll == false || alarmList.getAlarms.isEmpty
                  ? () {
                      Navigator.of(context).pushNamed(AddAlarmScreen.routeName);
                      setState(() {
                        change = false;
                        selectAll = false;
                      });
                    }
                  : () {
                      alarmList.removeAll();
                      setState(() {
                        change = false;
                        selectAll = false;
                      });
                    },

              //backgroundColor: Colors.blue,
              child: selectAll == false || alarmList.getAlarms.isEmpty
                  ? const Icon(
                      Icons.add,
                    )
                  : const Icon(
                      Icons.delete,
                    ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
