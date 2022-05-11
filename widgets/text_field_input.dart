import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  final textController;
  final String? helper;
  final String text;
  const TextFieldInput({
    required this.textController,
    required this.helper,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: widget.textController,
        onChanged: (val) {
          setState(() {});
        },
        maxLength: 2,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 30,
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: '00',
          enabledBorder: const UnderlineInputBorder(),
          helperText: widget.text,
          errorText: widget.helper,
          counterText: '',
        ),
      ),
    );
  }
}
