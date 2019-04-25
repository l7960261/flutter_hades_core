import 'package:flutter_hades_core/flutter_hades_core.dart';

class HadesSignatures {
  static String signBlock(String hash, String privKey) {
    var keyPair = Signature.keyPair_fromSecretKey(HadesHelpers.hexToBytes(privKey));
    var signer = Signature(keyPair.publicKey, keyPair.secretKey);
    return HadesHelpers.byteToHex(signer.detached(HadesHelpers.hexToBytes(hash)));
  }
}