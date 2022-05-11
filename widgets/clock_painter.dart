import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockPainterScreen extends StatefulWidget {
  const ClockPainterScreen(this.appbarHeight, {Key? key}) : super(key: key);
  final double appbarHeight;
  @override
  _ClockPainterScreenState createState() => _ClockPainterScreenState();
}

class _ClockPainterScreenState extends State<ClockPainterScreen> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        print('mounted');
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height:
              MediaQuery.of(context).size.height * 0.5 - widget.appbarHeight,
          child: Transform.rotate(
            angle: -pi / 2, //-pi/2
            child: CustomPaint(
              painter: ClockPainter(),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          DateFormat('EEEE,  d MMM, yyyy').format(
            DateTime.now(),
          ),
        ),
      ],
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  void paintText(String str, Size size, Canvas canvas, int numH, int numW) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );
    var textSpan = TextSpan(
      text: str,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (size.width - textPainter.width) / 2 + numW / 1.2;
    final yCenter = (size.height - textPainter.height) / 2 + numH / 1.2;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    //debugPrint('canvas width ${size.width}');
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var fillBrush = Paint()..color = const Color(0xFFFFFFFF);

    var dashBrush = Paint()
      ..color = const Color(0xFF2A2D46)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5;
    var dashBrush1 = Paint()
      ..color = const Color(0xFF2A2D46)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    var secondLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    var minLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var hourLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    var secondX = centerX + 90 * cos(dateTime.second * 6 * pi / 180);

    //debugPrint('Second X value $secondX');

    var secondY = centerY + 90 * sin(dateTime.second * 6 * pi / 180);

    var minX = centerX + 75 * cos(dateTime.minute * 6 * (pi / 180)); //275
    var minY = centerY + 75 * sin(dateTime.minute * 6 * (pi / 180)); //275

    var hourX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180); //210
    var hourY = centerY +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180); //210

    for (double i = 0; i < 360; i += 6) {
      var x1 = centerX + radius * cos(i * pi / 180);
      var y1 = centerY + radius * sin(i * pi / 180);

      var x2 = centerX + (radius - 14) * cos(i * pi / 180);
      var y2 = centerY + (radius - 14) * sin(i * pi / 180);

      if ((i) % 5 == 0) {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush1);
        //debugPrint('width ${Offset(x1, y1)} ${Offset(x2, y2)}');
      } else {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
      }
    }

    // paintText('12', size, canvas, -120, 0);
    // paintText('3', size, canvas, 0, 120);
    // paintText('6', size, canvas, 120, 0);
    // paintText('9', size, canvas, 0, -120);

    paintText('12', size, canvas, 0, 120);
    paintText('3', size, canvas, 120, 0);
    paintText('6', size, canvas, 0, -120);
    paintText('9', size, canvas, -120, 0);

    canvas.drawLine(center, Offset(secondX, secondY), secondLine);
    canvas.drawLine(center, Offset(minX, minY), minLine);
    canvas.drawLine(center, Offset(hourX, hourY), hourLine);

    canvas.drawCircle(center, 16, fillBrush);

    //paintText(DateFormat('dd-MM-yyyy').format(dateTime), size, canvas, 0, -180);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ClockPainter oldDelegate) => true;
}
