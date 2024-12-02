import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/actors/player.dart';

class Level extends World {
  String levelName;
  final Player player;
  Level({required this.levelName, required this.player});

  @override
  FutureOr<void> onLoad() async {
    late TiledComponent level;

    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));
    // This line makes the level and load it of size 16 by 16'
    // flame knows that assets/tiles should exist already, so
    // we just pass level-01.tmx.

    add(level);
    // this line adds the level to the Level class.

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');
    // grabing the layer and saying we want to spawn stuff on it
    // based on where we put stuff

    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
          break;
        default:
      }
    }
    // looping through all of the object in that layer and split
    //them up how we want to
    return super.onLoad();
  }
  // As soon as we add our levels to the game it's
  // going to run this code to make sure it's good
  // to go and it only runs once.
}
