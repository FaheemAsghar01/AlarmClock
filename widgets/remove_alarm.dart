import 'package:clock_dart/Providers/add_alarm.dart';
import 'package:clock_dart/Providers/alarm.dart';
import 'package:clock_dart/screens/add_alarm_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemoveAlarm extends StatefulWidget {
  const RemoveAlarm(this.addAlarm, {Key? key}) : super(key: key);
  final Alarm addAlarm;

  @override
  State<RemoveAlarm> createState() => _RemoveAlarmState();
}

class _RemoveAlarmState extends State<RemoveAlarm> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    final providerAlarm = Provider.of<Alarm>(context);
    final addAlarmProvider = Provider.of<AddAlarm>(context);
    return ListTile(
      //value: addAlarm.isScroll,
      // leading: Checkbox(
      //     value: value,
      //     onChanged: (bool? valu) {
      //       setState(() {
      //         value = valu;
      //       });
      //     }),
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          addAlarmProvider.removeAlarm(widget.addAlarm.id);
        },
      ),
      //onChanged: (value) => providerAlarm.toggleIsScrollOn(),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Text(
              '${widget.addAlarm.hour}:${widget.addAlarm.minute}',
              style: providerAlarm.checkScrollBar() == true
                  ? const TextStyle(fontSize: 30)
                  : const TextStyle(
                      fontSize: 30,
                      color: Colors.black45,
                    ),
            ),
            Text(
              '    ${widget.addAlarm.amPm}',
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
      subtitle: widget.addAlarm.label.isNotEmpty
          ? Text(
              '${widget.addAlarm.label} ${widget.addAlarm.day}',
              style: providerAlarm.checkScrollBar() == true
                  ? const TextStyle(color: Colors.black)
                  : const TextStyle(
                      color: Colors.black45,
                    ),
            )
          : Text(
              widget.addAlarm.day,
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
