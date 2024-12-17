import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerStatus { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  String character;
  Player({
    position,
    this.character = 'Ninja Frog',
  }) : super(position: position);

  // animation variables
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runningAnimation;
  double animationDuration = 0.05;

  // movement variables
  double movementSpeed = 100;
  Vector2 velocity = Vector2.zero();

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

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    double horizontalMovement = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    horizontalMovement += isRightKeyPressed ? 1 : 0;
    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    return super.onKeyEvent(event, keysPressed);
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
    velocity = Vector2(horizontalMovement, 0.0);
    position.x = position.x + velocity.x * dt;
  }
}
