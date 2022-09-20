import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:minecraft/components/player_component.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/global/world_data.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/utils/chunk_generation_methods.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';

import 'components/block_component.dart';

class MainGame extends FlameGame{
  final WorldData worldData;


  MainGame({required this.worldData}){
    globalGameReference.gameReference = this;
  }

  GlobalGameReference globalGameReference = Get.put(GlobalGameReference());

  PlayerComponent playerComponent = PlayerComponent();

  Future<void> onLoad() async{
    super.onLoad();
    camera.followComponent(playerComponent);
    add(playerComponent);
    GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(-1), false);
    GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(0), true);
    GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(1), true);
    renderChunk(-1);
    renderChunk(0);
    renderChunk(1);
    //add(BlockComponent(block: Blocks.grass, blockIndex: Vector2(0, 0)));
  }

  void renderChunk(int chunkIndex){
    List<List<Blocks?>> chunk = GameMethods.instance.getChunk(chunkIndex);
    chunk.asMap().forEach((int yIndex, List<Blocks?> rowOfBlocks) {
      rowOfBlocks.asMap().forEach((int xIndex, Blocks? block) {
        if(block != null){
          add(BlockComponent(block: block,
              blockIndex: Vector2((chunkIndex * chunkWidth) + xIndex.toDouble(),
                  yIndex.toDouble()),
            chunkIndex: chunkIndex
          ));
        }
      });
    });
  }

  @override
  void update(double dt){
    super.update(dt);
    worldData.chunksThatShouldBeRendered.asMap().forEach((int index, int chunkIndex) {
      if(!worldData.currentlyRenderedChunks.contains(chunkIndex)){
        if(chunkIndex >= 0){
          if(worldData.rightWorldChunks[0].length ~/ chunkWidth < chunkIndex +1){
            GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(chunkIndex), true);
          }
        }
        else{
          if(worldData.leftWorldChunks[0].length ~/ chunkWidth < chunkIndex.abs()){
            GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(chunkIndex), false);
          }
        }
        renderChunk(chunkIndex);
        worldData.currentlyRenderedChunks.add(chunkIndex);
      }
    });
  }
}