import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:minecraft/global/global_game_reference.dart';
import 'package:minecraft/resources/biomes.dart';
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

  List<List<Blocks?>> generateChunk(int chunkIndex){
    Biomes biome = Random().nextBool() ? Biomes.desert : Biomes.birchForest;
    List<List<Blocks?>> chunk = generateNullChunk();
    List<List<double>> rawNoise = noise2(chunkIndex >= 0 ?
        chunkWidth * (chunkIndex + 1) : chunkWidth * (chunkIndex.abs()),
        1,
        noiseType: NoiseType.Perlin,
        frequency: 0.05,
      seed: chunkIndex >= 0 ?
      GlobalGameReference.instance.gameReference.worldData.seed :
      GlobalGameReference.instance.gameReference.worldData.seed + 1
    );

    List<int> yValues = getYValuesFromRawNoise(rawNoise);
    yValues.removeRange(0, chunkIndex >= 0 ?  chunkWidth * chunkIndex : chunkWidth * (chunkIndex.abs() - 1));

    chunk = generatePrimarySoil(chunk, yValues, biome);
    chunk = generateSecondarySoil(chunk, yValues, biome);
    chunk = generateStone(chunk);
    return chunk;
  }

  List<List<Blocks?>> generatePrimarySoil(List<List<Blocks?>> chunk, List<int> yValues, Biomes biome){
    yValues.asMap().forEach((int index, int value) {
      chunk[value][index] = BiomeData.getBiomeDataFor(biome).primarySoil;
    });
    return chunk;
  }

  List<List<Blocks?>> generateSecondarySoil(List<List<Blocks?>> chunk, List<int> yValues, Biomes biome){
    yValues.asMap().forEach((int index, int value) {
      for(int i = value + 1; i <= GameMethods.instance.maxSecondarySoilExtent; i++){
        chunk[i][index] = BiomeData.getBiomeDataFor(biome).secondarySoil;
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