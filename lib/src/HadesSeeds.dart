import 'dart:math';

import 'package:flutter_hades_core/flutter_hades_core.dart';

class HadesSeeds {
  static bool isValidSeed(String seed) {
    if (seed == null || seed.length != 64) {
      return false;
    }

    return HadesHelpers.isHexString(seed);
  }

  static String generateSeed() {
    String result = '';
    String chars = 'abcdef0123456789';
    var rng = Random.secure();
    for (int i = 0; i < 64; i++) {
      result += chars[rng.nextInt(chars.length)];
    }
    return result.toUpperCase();
  }
}
