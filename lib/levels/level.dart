import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  @override
  FutureOr<void> onLoad() async {
    late TiledComponent level;

    level = await TiledComponent.load('level-01.tmx', Vector2.all(16));
    // This line makes the level and load it of size 16 by 16'
    // flame knows that assets/tiles should exist already, so
    // we just pass level-01.tmx.

    add(level);
    // this line adds the level to the Level class.
    return super.onLoad();
  }
  // As soon as we add our levels to the game it's
  // going to run this code to make sure it's good
  // to go and it only runs once.
}
