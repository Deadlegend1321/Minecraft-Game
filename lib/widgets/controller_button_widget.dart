import 'package:flutter/material.dart';

class ControllerButtonWidget extends StatefulWidget {
  final String path;
  const ControllerButtonWidget({Key? key, required this.path}) : super(key: key);

  @override
  State<ControllerButtonWidget> createState() => _ControllerButtonWidgetState();
}

class _ControllerButtonWidgetState extends State<ControllerButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: SizedBox(
        height: screenSize.width/17,
          width: screenSize.width/17,
          child: Image.asset(widget.path)
      ),
    );
  }
}
