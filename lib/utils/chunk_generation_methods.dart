import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';

import '../resources/blocks.dart';

class ChunkGenerationMethods {

  static ChunkGenerationMethods get instance{
    return ChunkGenerationMethods();
  }

  /*List<Null> getNullRow(){
    return List.generate(chunkWidth, (index) => null);
  }*/

  List<List<Blocks?>> generateNullChunk(){
    return List.generate(chunkHeight, (index) =>  List.generate(chunkWidth, (index) => null));
  }

  List<List<Blocks?>> generateChunk(){
    List<List<Blocks?>> chunk = generateNullChunk();
    List<List<double>> rawNoise = noise2(
        chunkWidth,
        1,
        noiseType: NoiseType.Perlin,
        frequency: 0.05,
      seed: 987635
    );

    List<int> yValues = getYValuesFromRawNoise(rawNoise);

    chunk = generatePrimarySoil(chunk, yValues, Blocks.grass);
    chunk = generateSecondarySoil(chunk, yValues, Blocks.dirt);
    chunk = generateStone(chunk);
    return chunk;
  }

  List<List<Blocks?>> generatePrimarySoil(List<List<Blocks?>> chunk, List<int> yValues, Blocks block){
    yValues.asMap().forEach((int index, int value) {
      chunk[value][index] = block;
    });
    return chunk;
  }

  List<List<Blocks?>> generateSecondarySoil(List<List<Blocks?>> chunk, List<int> yValues, Blocks block){
    yValues.asMap().forEach((int index, int value) {
      for(int i = value + 1; i <= GameMethods.instance.maxSecondarySoilExtent; i++){
        chunk[i][index] = block;
      }
    });
    return chunk;
  }

  List<List<Blocks?>> generateStone(List<List<Blocks?>> chunks){
    for(int index = 0; index < chunkWidth; index++){
      for(int i = GameMethods.instance.maxSecondarySoilExtent + 1; i<chunks.length; i++){
        chunks[i][index] = Blocks.stone;
      }
    }
    int x1 = Random().nextInt(chunkWidth~/2);
    int x2 = x1 + Random().nextInt(chunkWidth~/2);
    chunks[GameMethods.instance.maxSecondarySoilExtent].fillRange(x1, x2, Blocks.stone);
    return chunks;
  }

  List<int> getYValuesFromRawNoise(List<List<double>> rawNoise){
    List<int> yValues = [];
    rawNoise.asMap().forEach((int index, List<double> value) { 
      yValues.add((value[0] * 10).toInt().abs()  + GameMethods.instance.freeArea);
    });
    return yValues;
  }
}