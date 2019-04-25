import 'package:flutter_hades_core/flutter_hades_core.dart';

class HadesSignatures {
  static String signBlock(String hash, String privKey) {
    return HadesHelpers.byteToHex(Signature.detached(
            HadesHelpers.hexToBytes(hash), HadesHelpers.hexToBytes(privKey)))
        .toUpperCase();
  }
}
