import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xff211f30);

  late final CameraComponent cam;

  final worlds = Level();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    cam = CameraComponent.withFixedResolution(
        width: 640, height: 360, world: worlds);

    addAll([cam, worlds]);
    // adds the level in the Level class to the game.

    cam.viewfinder.anchor = Anchor.topLeft;
    //placing the game to start at the top left corner.

    return super.onLoad();
  }
}
