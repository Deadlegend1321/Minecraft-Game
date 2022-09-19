import 'package:flame/components.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/utils/game_methods.dart';

class BlockComponent extends SpriteComponent{
  final Blocks block;
  final Vector2 blockIndex;

  BlockComponent({required this.block, required this.blockIndex});
  @override
  Future<void> onLoad() async{
    super.onLoad();
    sprite = await GameMethods.instance.getSpriteFromBLock(block);
  }

  @override
  void onGameResize(Vector2 newGameSize){
    super.onGameResize(newGameSize);
    size = GameMethods.instance.blockSize;
    position = Vector2(GameMethods.instance.blockSize.x * blockIndex.x,
        GameMethods.instance.blockSize.x * blockIndex.y);
  }
}