import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/gestures.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerStatus { idle, running }

enum PlayerDirection { left, right, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure> {
  String character;
  Player({position, required this.character}) : super(position: position);

  // animation variables
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runningAnimation;
  double animationDuration = 0.05;

  // movement variables
  PlayerDirection playerDirection = PlayerDirection.none;
  double movementSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
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

  void _updatePlayerMovement(double dt) {
    double dirX = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dirX = dirX - movementSpeed;
        current = PlayerStatus.running;
        break;
      case PlayerDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dirX = dirX + movementSpeed;
        break;
      case PlayerDirection.none:
        current = PlayerStatus.idle;
        break;
      default:
    }
    velocity = Vector2(dirX, 0.0);
    position = position + velocity * dt;
  }
}
