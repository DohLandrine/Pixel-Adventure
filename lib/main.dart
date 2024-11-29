import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // To wait for flutter to
  //be initialized, before calling some other stuffs

  Flame.device.fullScreen();
  // makes your game to occupy the full screen

  Flame.device.setLandscape();
  // makes you game to be landscape only, on your device.

  PixelAdventure game = PixelAdventure();
  runApp(
    GameWidget(game: kDebugMode ? PixelAdventure() : game),
    // during coding, we will always have to hot restart, if
    // we call just game, which is good for the real environment
    // but bad for debuging. PixelAdventure will reload every 
    // time we save.
  );
}
