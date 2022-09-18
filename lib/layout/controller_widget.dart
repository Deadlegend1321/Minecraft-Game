import 'package:flutter/material.dart';
import 'package:minecraft/widgets/controller_button_widget.dart';

class ControllerWidget extends StatelessWidget {
  const ControllerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        ControllerButtonWidget(path: "assets/controller/left_button.png"),
        ControllerButtonWidget(path: "assets/controller/center_button.png"),
        ControllerButtonWidget(path: "assets/controller/right_button.png"),
      ],
    );
  }
}
