import 'blocks.dart';

enum Biomes{
  desert, birchForest
}

class BiomeData {
  final Blocks primarySoil;
  final Blocks secondarySoil;

  BiomeData({required this.primarySoil, required this.secondarySoil});
}