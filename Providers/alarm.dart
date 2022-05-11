import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';

class Alarm with ChangeNotifier {
  final String id;
  final int hour;
  final int minute;
  final String amPm;
  final String day;
  final String label;
  final List<String> dialogBox;
  bool isScroll;
  bool isVibrate;

  Alarm({
    required this.id,
    required this.hour,
    required this.minute,
    required this.amPm,
    required this.day,
    required this.label,
    required this.dialogBox,
    this.isScroll = true,
    this.isVibrate = true,
  });

  void toggleIsScrollOn() {
    isScroll = !isScroll;
    notifyListeners();
  }

  void toggleVibrate() {
    isVibrate = !isVibrate;
    notifyListeners();
  }

  bool checkVibrateScrollbar() {
    return isVibrate == true;
  }

  bool checkScrollBar() {
    return isScroll == true;
  }
}
