import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class AddAlarmPainter extends StatefulWidget {
  const AddAlarmPainter(this.screenWidth, {Key? key}) : super(key: key);
  final double screenWidth;

  @override
  _AddAlarmPainterState createState() => _AddAlarmPainterState();
}

class _AddAlarmPainterState extends State<AddAlarmPainter> {
  final hourContoller = TextEditingController();
  final minuteController = TextEditingController();
  List<int> list = [];
  @override
  void dispose() {
    hourContoller.dispose();
    minuteController.dispose();
    super.dispose();
  }

  void timeSetter() {}

  // get timeValue {
  //   List<int> list = [];
  //   list.add(int.parse(hourContoller.text));
  //   list.add(int.parse(minuteController.text));
  //   return list;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Text('Type in time'),
        const SizedBox(
          height: 20,
        ),
        // ignore: prefer_const_constructors
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: widget.screenWidth * 0.3,
              child: TextField(
                controller: hourContoller,
                onChanged: (context) => {
                  hourContoller.text = context,
                  list[0] = int.parse(hourContoller.text),
                },
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '12',
                  enabledBorder: UnderlineInputBorder(),
                  helperText: 'hour',
                ),
              ),
            ),
            const Text(
              ':',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: widget.screenWidth * 0.3,
              child: TextField(
                controller: minuteController,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '00',
                  enabledBorder: UnderlineInputBorder(),
                  helperText: 'minute',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
