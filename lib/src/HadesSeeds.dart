import 'dart:math';

class HadesSeeds {
  static String generateSeed() {
    String result = '';
    String chars = 'abcdefg0123456789';
    var rng = Random.secure();
    for (int i = 0; i < 64; i++) {
      result += chars[rng.nextInt(chars.length)];
    }
    return result.toUpperCase();
  }
}
