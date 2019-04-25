import 'package:flutter_hades_core/flutter_hades_core.dart';

class HadesKeys {
  static String seedToPrivate(String seed, int index) {
    assert(HadesSeeds.isValidSeed(seed));
    assert(index >= 0);
    return HadesHelpers.byteToHex(Hashes.digest256(
        [HadesHelpers.hexToBytes(seed), Hashes.intToUint8List(index, 4)])).toUpperCase();
  }

  static String createPublicKey(String privateKey) {
    assert(HadesSeeds.isValidSeed(privateKey));
    return HadesHelpers.byteToHex(RaiBlocks.pkFromSecret(HadesHelpers.hexToBytes(privateKey)));
  }
}
