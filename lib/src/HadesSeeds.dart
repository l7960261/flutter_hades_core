import 'dart:math';

class HadesSeeds {
  static bool isValidSeed(String seed) {
    if (seed == null || seed.length != 64) {
      return false;
    }

    var hexChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a',
      'b', 'c', 'd', 'e', 'f', 'A', 'B', 'C', 'D', 'E', 'F'
    ];

    for (var i = 0; i < seed.length; i++) {
      if(!hexChars.contains(seed[i])){
        return false;
      }
    }

    return true;
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
