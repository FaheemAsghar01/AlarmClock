import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clock_dart/Providers/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShowAlarm extends StatelessWidget {
  const ShowAlarm(this.addAlarm, this.ctx, {Key? key}) : super(key: key);
  final Alarm addAlarm;
  final BuildContext ctx;

  void calculateTimeTryNew(int hour, int min, String amPm) {
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
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
            'Alarm Set for $remainingHour hour and $remainingMin minute from now.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final providerAlarm = Provider.of<Alarm>(context);
    return ListTile(
      //value: addAlarm.isScroll,
      trailing: Switch.adaptive(
        value: addAlarm.isScroll,
        onChanged: (value) {
          providerAlarm.toggleIsScrollOn();
          String id = providerAlarm.id;
          int? intId;

          id = id.replaceAll(RegExp(r"[:-\s.]"), "");
          id = id.substring(12, 20);
          intId = int.tryParse(id);
          if (providerAlarm.checkScrollBar()) {
            var date = DateFormat('hh:mm a').format(DateTime.now());
            if ((date.substring(6, 8) == providerAlarm.amPm) &&
                (int.tryParse(date.substring(0, 2).trim()) ==
                    providerAlarm.hour) &&
                (int.tryParse(date.substring(3, 5).trim()) ==
                    providerAlarm.minute)) {
              AndroidAlarmManager.periodic(
                  const Duration(seconds: 1), intId as int, fireAlarm);
            }
            calculateTimeTryNew(
                providerAlarm.hour, providerAlarm.minute, providerAlarm.amPm);
          } else {
            AndroidAlarmManager.cancel(intId as int)
                .whenComplete(() => print('Cancel done'));
            FlutterRingtonePlayer.stop();
          }
        },
        activeColor: Colors.blue,
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Text(
              '${addAlarm.hour}:${addAlarm.minute}',
              style: providerAlarm.checkScrollBar() == true
                  ? const TextStyle(fontSize: 30)
                  : const TextStyle(
                      fontSize: 30,
                      color: Colors.black45,
                    ),
            ),
            Text(
              '    ${addAlarm.amPm}',
              style: providerAlarm.checkScrollBar() == true
                  ? const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)
                  : const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
            ),
          ],
        ),
      ),
      subtitle: addAlarm.label.isNotEmpty
          ? Text(
              '${addAlarm.label} ${addAlarm.day}',
              style: providerAlarm.checkScrollBar() == true
                  ? const TextStyle(color: Colors.black)
                  : const TextStyle(
                      color: Colors.black45,
                    ),
            )
          : Text(
              addAlarm.day,
              style: providerAlarm.checkScrollBar() == true
                  ? const TextStyle(color: Colors.black)
                  : const TextStyle(
                      color: Colors.black45,
                    ),
            ),
      isThreeLine: true,
    );
  }
}

void fireAlarm() {
  print('Hello from preodic alarm');

  FlutterRingtonePlayer.play(
    android: AndroidSounds.ringtone,
    ios: IosSounds.glass,
    looping: true, // Android only - API >= 28
    volume: 0.8, // Android only - API >= 28
  );
  // FlutterRingtonePlayer.playNotification();
  // FlutterRingtonePlayer.play(
  //   android: AndroidSounds.ringtone,
  //   ios: IosSounds.glass,
  //   looping: true, // Android only - API >= 28
  //   volume: 0.8, // Android only - API >= 28
  //   asAlarm: false, // Android only - all APIs
  // );
}
