import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:minecraft/layout/game_layout.dart';
import 'package:minecraft/screens/world_select_screen.dart';
import 'package:minecraft/widgets/launcher/minecraft_button.dart';
import 'package:panorama/panorama.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Panorama(
            interactive: false,
            animSpeed: 1,
            child: Image.asset("assets/images/launcher/panorama.png"),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Container()),
                  MinecraftButtonWidget(
                    text: "Singleplayer",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WorldSelectScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MinecraftButtonWidget(text: "Multiplayer", onPressed: () {}),
                  Expanded(child: Container()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}