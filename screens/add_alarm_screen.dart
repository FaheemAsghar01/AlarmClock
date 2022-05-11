import 'dart:io';

import 'package:clock_dart/Providers/add_alarm.dart';
import 'package:clock_dart/Providers/alarm.dart';
import 'package:clock_dart/alertDialogHelperClass.dart';
import 'package:clock_dart/widgets/alertDialogBox.dart';
import 'package:clock_dart/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddAlarmScreen extends StatefulWidget {
  const AddAlarmScreen({Key? key}) : super(key: key);
  static const routeName = '/add-alarm-screen';

  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  String _amPm = 'AM';
  int check1 = 0;
  int check2 = 0;
  String alertValue = '';
  String label = '';
  String tempLabel = '';
  final _hourController = TextEditingController();
  final _minuteController = TextEditingController();
  bool vibrate = true;
  bool inIt = true;
  String _id = '';
  List<String> box = [];
  AlertDialogHelperClass alertInstance = AlertDialogHelperClass();
  var _editedProduct = Alarm(
    id: '',
    hour: 00,
    minute: 00,
    amPm: '',
    day: '',
    label: '',
    dialogBox: [],
  );
  String _setAlertValue(String text) {
    alertValue = text;
    if (alertValue.length > 1) {
      return alertValue;
    }
    return 'Once';
  }

  List<String> _setDialogValues(String text) {
    List<String> abc = [];
    if (text.length > 1) {
      abc = text.isNotEmpty ? text.split(' ') : [];
      if (abc.length > 1) {
        abc.removeAt(0);
        print(abc);
      }
    }
    return abc;
  }

  String? _errorTextHour(String text) {
    if (text.isNotEmpty) {
      int? num = int.tryParse(text);
      if (num != null) {
        if (num < 1 || num > 12) {
          return 'Invalid hour';
        }
      }
    }
    return null;
  }

  String? _errorTextMinute(String text) {
    if (text.isNotEmpty) {
      int? num = int.tryParse(text);
      if (num != null) {
        if (num < 0 || num > 59) {
          return 'Invalid Min';
        }
      }
    }
    return null;
  }

  bool checkHourValid(int val) {
    if (val > 0 && val < 13) {
      return true;
    }
    return false;
  }

  bool checkMinuteValid(int val) {
    if (val >= 0 && val < 60) {
      return true;
    }
    return false;
  }

  Future openLabelDialop() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Label'),
            content: TextField(
              onChanged: (value) {
                tempLabel = value;
              },
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  tempLabel = '';
                  Navigator.of(context).pop();
                },
                child: const Text('cancel'),
              ),
              TextButton(
                onPressed: () {
                  label = tempLabel;
                  Navigator.of(context).pop();
                },
                child: const Text('ok'),
              ),
            ],
          ),
        ),
      );

  Future openDialop() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) =>
              AlertDialogBox(alertInstance, _setAlertValue, alertValue),
        ),
      );

  @override
  void initState() {
    print('Init State called from Add Alarm Screen');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print(
        'Did Change Dependencies called from Add Alarm Screen outside if condition');
    if (inIt) {
      print(
          'Did Change Dependencies called from Add Alarm Screen insideside if condition');
      final updateProductId = ModalRoute.of(context)?.settings.arguments != null
          ? ModalRoute.of(context)?.settings.arguments as String
          : null;
      if (updateProductId != null) {
        print(updateProductId);
        _editedProduct = Provider.of<AddAlarm>(context, listen: false)
            .findById(updateProductId);
        _id = _editedProduct.id;
        _hourController.text = _editedProduct.hour.toString();
        _minuteController.text = _editedProduct.minute.toString();
        label = _editedProduct.label;
        _amPm = _editedProduct.amPm;
        vibrate = _editedProduct.isVibrate;
        box = _editedProduct.dialogBox;
        alertInstance.mon = box.contains('Mon') ? true : false;
        alertInstance.tue = box.contains('Tue') ? true : false;
        alertInstance.wed = box.contains('Wed') ? true : false;
        alertInstance.thur = box.contains('Thur') ? true : false;
        alertInstance.fri = box.contains('Fri') ? true : false;
        alertInstance.sat = box.contains('Sat') ? true : false;
        alertInstance.sund = box.contains('Sun') ? true : false;
      }
    }
    inIt = false;
    super.didChangeDependencies();
  }

  bool addAlarmOnPressed(String min, String hour, String amPm, String lab,
      bool vibrate, List<String> dialogVal) {
    int? min1 = int.tryParse(min);
    int? hour1 = int.tryParse(hour);
    //bool isValid = true;
    if (min1 != null && hour1 != null) {
      if (checkHourValid(hour1) == false || checkMinuteValid(min1) == false) {
        //isValid = false;
        return false;
      } else {
        Alarm alarm = Alarm(
            id: _id.length > 1 ? _id : DateTime.now().toString(),
            hour: hour1,
            minute: min1,
            amPm: amPm,
            day: 'Today',
            label: lab,
            dialogBox: dialogVal,
            isVibrate: vibrate);
        if (_editedProduct.id.isNotEmpty) {
          Provider.of<AddAlarm>(context, listen: false)
              .updateAlarm(_editedProduct.id, alarm);
        } else {
          Provider.of<AddAlarm>(context, listen: false).addAlarm(alarm);
        }
      }
      return true;
    } else {
      return false;
    }
  }

  void calculateTimeTryNew(String h, String m, String amPm) {
    int hour = int.tryParse(h) as int;
    int min = int.tryParse(m) as int;
    var date = DateFormat('hh mm a').format(DateTime.now());
    int cHour = int.parse(date.substring(0, 2));
    int cMint = int.parse(date.substring(3, 5));
    var cAmPM = date.substring(6, 8);
    var remainingHour = 0;
    var remainingMin = 0;
    if (cHour != hour && (cHour == 12 || hour == 12)) {
      remainingHour += 12;
    }
    if (amPm == cAmPM) {
      if (hour == cHour && min == cMint) {
        remainingHour = 24;
        remainingMin = 0;
      } else if (hour == cHour) {
        if (cMint > min) {
          remainingHour = 23;
          remainingMin = 60 - (cMint - min);
        } else {
          remainingMin = (min - cMint);
        }
      } else if (hour > cHour && (cHour != 12 && hour != 12)) {
        remainingHour = hour - cHour;
        if (cMint > min) {
          remainingHour -= 1;
          remainingMin = 60 - (cMint - min);
        } else if (min > cMint) {
          remainingMin = min - cMint;
        }
      } else {
        remainingHour = 24 - (cHour - hour).abs();
        if (min < cMint) {
          remainingMin = 60 - (cMint - min);
          remainingHour -= 1;
        } else {
          remainingMin = min - cMint;
        }
      }
    } else {
      if (cAmPM == 'PM' && amPm == 'AM') {
        if ((cHour < hour) && (cHour != 12 && hour != 12)) {
          remainingHour = 12 + (cHour - hour).abs();
          if (cMint > min) {
            remainingHour -= 1;
            remainingMin = 60 - (cMint - min).abs();
          } else {
            remainingMin = min - cMint;
          }
        } else {
          remainingHour = (hour - cHour).abs();
          if (cMint > min) {
            remainingHour = 11 - remainingHour;
            remainingMin = 60 - (cMint - min);
          } else {
            remainingHour = 12 - remainingHour;
            remainingMin = min - cMint;
          }
        }
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Alarm Set for $remainingHour hour and $remainingMin minute from now.'),
      ),
    );
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Set an alarm',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => {
              if (addAlarmOnPressed(
                  _minuteController.value.text,
                  _hourController.value.text,
                  _amPm,
                  label,
                  vibrate,
                  _setDialogValues(alertValue)))
                {
                  calculateTimeTryNew(
                      _hourController.text, _minuteController.text, _amPm),
                  Navigator.of(context).pop(true),
                }
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please Enter valid hour and minute'),
                    ),
                  ),
                }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    fit: FlexFit.loose,
                    child: Text('Type in Time'),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFieldInput(
                              textController: _hourController,
                              helper:
                                  _errorTextHour(_hourController.value.text),
                              text: 'hour',
                            ),
                          ),
                        ),
                        const Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            ':',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFieldInput(
                              textController: _minuteController,
                              helper: _errorTextMinute(
                                  _minuteController.value.text),
                              text: 'minute',
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _amPm = 'AM';
                                      check1 = 1;
                                      check2 = 0;
                                    });
                                  },
                                  child: Text(
                                    'AM',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: check1 == 1
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _amPm = 'PM';
                                      check2 = 1;
                                      check1 = 0;
                                    });
                                  },
                                  child: Text(
                                    'PM',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: check2 == 1
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
              child: Divider(),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: [
                      Flexible(
                        child: ListTile(
                          title: const Text(
                            'Repeat',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            box.isEmpty
                                ? _setAlertValue(alertValue)
                                : box.join(' '),
                            style: const TextStyle(fontSize: 14),
                          ),
                          leading: const Icon(Icons.copy),
                          onTap: () async {
                            await openDialop();
                            setState(() {});
                          },
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: const Text(
                            'Alarm Sound',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text(
                            'Default',
                            style: TextStyle(fontSize: 14),
                          ),
                          leading:
                              const Icon(Icons.notifications_none_outlined),
                          onTap: () {},
                        ),
                      ),
                      Flexible(
                        child: SwitchListTile.adaptive(
                          value: vibrate,
                          onChanged: (v) {
                            setState(() {
                              vibrate = v;
                            });
                          },
                          title: const Text(
                            'Vibrate',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          secondary: const Icon(Icons.vibration),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: const Text(
                            'Label',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            label == '' ? 'Label' : label,
                            style: const TextStyle(fontSize: 14),
                          ),
                          //language outlined
                          leading: const Icon(Icons.label_outline_rounded),
                          onTap: () async {
                            await openLabelDialop();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
