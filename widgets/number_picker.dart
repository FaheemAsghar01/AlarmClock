import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

// ignore: must_be_immutable
class NumberPickerClock extends StatefulWidget {
  const NumberPickerClock(this.addAlarm, {Key? key}) : super(key: key);
  final ValueSetter<List<int>> addAlarm;
  // int _currentHour;
  // int _currentMin;
  // int _amPm;

  @override
  _NumberPickerClockState createState() => _NumberPickerClockState();
}

class _NumberPickerClockState extends State<NumberPickerClock> {
  int _currentHour = 01;
  int _currentMin = 01;
  int _amPm = 0;
  List<int> lst = [];
  int count = 0;
  //get alarm => null;
  void setTime() {
    lst.add(_amPm);
    lst.add(_currentHour);
    lst.add(_currentMin);
  }

  // @override
  // void didUpdateWidget(covariant NumberPickerClock oldWidget) {
  //   oldWidget.addAlarm;
  //   setTime();
  //   super.didUpdateWidget(oldWidget);
  // }

  void checkList(int value, int n) {
    if (n == 0) {
      if (lst[n] != value) {
        lst[n] = value;
      }
      count++;
    } else if (n == 1) {
      if (lst[n] != value) {
        lst[n] = value;
      }
      count++;
    } else {
      if (lst[n] != value) {
        lst[n] = value;
      }
      count++;
    }

    if (count == 3) {
      widget.addAlarm(lst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: NumberPicker(
            value: _currentHour,
            zeroPad: true,
            minValue: 1,
            maxValue: 12,
            onChanged: (value) => {
              setState(() => _currentHour = value),
              //checkList(value, 0),
            },
            infiniteLoop: true,
          ),
        ),
        Expanded(
          child: NumberPicker(
            value: _currentMin,
            zeroPad: true,
            minValue: 1,
            maxValue: 60,
            infiniteLoop: true,
            onChanged: (value) => {
              setState(() => _currentMin = value),
              //lst.add(value),
            },
          ),
        ),
        Expanded(
          child: NumberPicker(
            value: _amPm,
            textMapper: (numberText) {
              if (_amPm == 0) {
                return numberText = 'AM';
              } else {
                return numberText = 'PM';
              }
            },
            minValue: 0,
            maxValue: 1,
            onChanged: (value) => {
              setState(() => _amPm = value),
              //lst.add(value),
              //widget.addAlarm(lst),
            },
          ),
        ),
      ],
    );
  }
}
