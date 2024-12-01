import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerStatus { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure> {
  String character;
  Player({position, required this.character}) :super(position: position);
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runningAnimation;
  double animationDuration = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
  }

  void _loadAllAnimation() {
    runningAnimation = _spriteAnimation(state: 'Run', amount: 12);
    idleAnimation = _spriteAnimation(state: 'Idle', amount: 11);
    animations = {
      PlayerStatus.idle: idleAnimation,
      PlayerStatus.running: runningAnimation
    };
    current = PlayerStatus.running;
  }

  SpriteAnimation _spriteAnimation(
      {required String state, required int amount}) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: animationDuration,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
