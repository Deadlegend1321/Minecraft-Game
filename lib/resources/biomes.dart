import 'package:minecraft/resources/structures.dart';
import 'package:minecraft/structures/plants.dart';
import 'package:minecraft/structures/trees.dart';
import 'blocks.dart';

enum Biomes{
  desert, birchForest
}

class BiomeData {
  final Blocks primarySoil;
  final Blocks secondarySoil;
  final List<Structure> generatingStructure;

  BiomeData({required this.primarySoil, required this.secondarySoil, required this.generatingStructure});

  factory BiomeData.getBiomeDataFor(Biomes biome){
    switch(biome){
      case Biomes.desert: 
        return BiomeData(
            primarySoil: Blocks.sand,
            secondarySoil: Blocks.sand,
            generatingStructure: [cactus, deadBush]
        );
      case Biomes.birchForest:
        return BiomeData(
            primarySoil: Blocks.grass,
            secondarySoil: Blocks.dirt,
            generatingStructure: [birchTree, redFlower, whiteFlower, purpleFlower, drippingWhiteFlower]);
    }
  }
}