import 'package:flutter/material.dart';
import '../alertDialogHelperClass.dart';

class AlertDialogBox extends StatefulWidget {
  const AlertDialogBox(this.alertInstance, this.helper, this.text1, {Key? key})
      : super(key: key);
  final AlertDialogHelperClass alertInstance;
  final Function helper;
  final String text1;

  @override
  State<AlertDialogBox> createState() => _AlertDialogBoxState();
}

class _AlertDialogBoxState extends State<AlertDialogBox> {
  String text = '';
  List<String> abc = [' '];
  List<bool> check = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Repeat'),
      content: ListView(
        shrinkWrap: true,
        children: [
          CheckboxListTile(
            value: widget.alertInstance.mon,
            title: const Text('Monday'),
            onChanged: (value) {
              setState(
                () {
                  widget.alertInstance.mon = value!;
                },
              );
              check[0] = !check[0];
            },
          ),
          CheckboxListTile(
            value: widget.alertInstance.tue,
            title: const Text('Tuesday'),
            onChanged: (value) {
              setState(
                () {
                  widget.alertInstance.tue = value!;
                },
              );
              check[1] = !check[1];
            },
          ),
          CheckboxListTile(
            value: widget.alertInstance.wed,
            title: const Text('Wednesday'),
            onChanged: (value) {
              setState(
                () {
                  widget.alertInstance.wed = value!;
                },
              );
              check[2] = !check[2];
            },
          ),
          CheckboxListTile(
            value: widget.alertInstance.thur,
            title: const Text('Thursday'),
            onChanged: (value) {
              setState(
                () {
                  widget.alertInstance.thur = value!;
                },
              );
              check[3] = !check[3];
            },
          ),
          CheckboxListTile(
            value: widget.alertInstance.fri,
            title: const Text('Friday'),
            onChanged: (value) {
              setState(
                () {
                  widget.alertInstance.fri = value!;
                },
              );
              check[4] = !check[4];
            },
          ),
          CheckboxListTile(
            value: widget.alertInstance.sat,
            title: const Text('Saturday'),
            onChanged: (value) {
              setState(
                () {
                  widget.alertInstance.sat = value!;
                },
              );
              check[5] = !check[5];
            },
          ),
          CheckboxListTile(
            value: widget.alertInstance.sund,
            title: const Text('Sunday'),
            onChanged: (value) {
              setState(
                () {
                  widget.alertInstance.sund = value!;
                },
              );
              check[6] = !check[6];
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (check[0] == true) {
              widget.alertInstance.mon = !widget.alertInstance.mon;
            }
            if (check[1] == true) {
              widget.alertInstance.tue = !widget.alertInstance.tue;
            }
            if (check[2] == true) {
              widget.alertInstance.wed = !widget.alertInstance.wed;
            }
            if (check[3] == true) {
              widget.alertInstance.thur = !widget.alertInstance.thur;
            }
            if (check[4] == true) {
              widget.alertInstance.fri = !widget.alertInstance.fri;
            }
            if (check[5] == true) {
              widget.alertInstance.sat = !widget.alertInstance.sat;
            }
            if (check[6] == true) {
              widget.alertInstance.sund = !widget.alertInstance.sund;
            }
            Navigator.of(context).pop();
          },
          child: const Text('cancel'),
        ),
        TextButton(
          onPressed: () {
            text = widget.alertInstance.setAlertValues();
            // abc = text.isNotEmpty ? text.split(' ') : [' '];
            // if (abc.length > 1) {
            //   abc.removeAt(0);
            // }
            // print(abc);
            widget.helper(text);
            Navigator.of(context).pop();
          },
          child: const Text('submit'),
        ),
      ],
    );
  }
}
