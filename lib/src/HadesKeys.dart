import "package:ed25519_hd_key/ed25519_hd_key.dart";
import 'package:flutter_hades_core/flutter_hades_core.dart';

class HadesKeys {
  static String seedToPrivate(String seed, int index) {
    assert(HadesSeeds.isValidSeed(seed));
    assert(index >= 0);
    return HadesHelpers.byteToHex(Hashes.digest256(
        [HadesHelpers.hexToByted(seed), Hashes.intToUint8List(index, 4)])).toUpperCase();
  }

  static String createPublicKey(String privateKey) {
    assert(HadesSeeds.isValidSeed(privateKey));
    return HadesHelpers.byteToHex(ED25519_HD_KEY.getBublickKey(HadesHelpers.hexToByted(privateKey)));
  }
}
