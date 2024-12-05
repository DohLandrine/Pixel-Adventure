import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:pixel_adventure/actors/player.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xff211f30);

  late final CameraComponent cam;
  Player player = Player(character: 'Pink Man');
  late JoystickComponent joyStick;
  bool showJoystick = true;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    final worlds = Level(levelName: 'level-02', player: player);

    cam = CameraComponent.withFixedResolution(
        width: 640, height: 360, world: worlds);

    addAll([cam, worlds]);
    // adds the level in the Level class to the game.

    if (showJoystick) {
      addJoystick();
    }

    cam.viewfinder.anchor = Anchor.topLeft;
    //placing the game to start at the top left corner.

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) {
      updateJoyStick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joyStick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );
    add(joyStick);
  }

  void updateJoyStick() {
    switch (joyStick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.playerDirection = PlayerDirection.right;
        break;
      default:
        player.playerDirection = PlayerDirection.idle;
    }
  }
}
