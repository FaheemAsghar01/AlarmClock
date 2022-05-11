import 'package:clock_dart/Providers/alarm.dart';
import 'package:flutter/material.dart';

class AddAlarm with ChangeNotifier {
  var abc = [''];

  // ignore: prefer_final_fields
  List<Alarm> _alarms = [
    Alarm(
      id: DateTime.now().toString(),
      hour: 11,
      minute: 12,
      amPm: 'PM',
      day: 'Tomarrow',
      label: '',
      dialogBox: [''],
    ),
    Alarm(
      id: DateTime.now().toString(),
      hour: 8,
      minute: 35,
      amPm: 'AM',
      day: 'Tomarrow',
      label: '',
      dialogBox: [''],
    ),
  ];

  List<Alarm> get getAlarms {
    return [..._alarms];
  }

  Alarm findById(String id) {
    return _alarms.firstWhere((e) => e.id == id);
  }

  void addAlarm(Alarm alarm) {
    Alarm newAlarm = Alarm(
      id: DateTime.now().toString(),
      hour: alarm.hour,
      minute: alarm.minute,
      amPm: alarm.amPm,
      day: alarm.day,
      label: alarm.label,
      dialogBox: alarm.dialogBox,
      isScroll: alarm.isScroll,
      isVibrate: alarm.isVibrate,
    );
    _alarms.add(newAlarm);
    notifyListeners();
  }

  void updateAlarm(String id, Alarm alarm) {
    final index = _alarms.indexWhere((element) => element.id == id);
    if (index > 0) {
      _alarms[index] = alarm;
      notifyListeners();
    }
  }

  void removeAlarm(String id) {
    _alarms.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void removeAll() {
    _alarms.clear();
    notifyListeners();
  }
}
