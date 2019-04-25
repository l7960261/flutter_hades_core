import "dart:typed_data" show Uint8List;

import 'package:flutter_hades_core/flutter_hades_core.dart';

class HadesAccounts {
  static HadesAccountEncodes encoder = HadesAccountEncodes();

  static String createAccount(int accountType, String publicKey) {
    var binaryPubkey = HadesHelpers.hexToBinary(publicKey).padLeft(260, "0");
    var encodedCheckSum = calculatedEncodedCheckSum(binaryPubkey);
    var encodedPubKey = encoder.encode(binaryPubkey);
    return HadesAccountType.getPerfix(accountType) +
        encodedPubKey +
        encodedCheckSum;
  }

  static String calculatedEncodedCheckSum(String publicKey) {
    Uint8List checksum = HadesHelpers.reverse(
        Hashes.digest(5, [HadesHelpers.hexToByted(publicKey)]));
    String binaryChecksum =
        HadesHelpers.hexToBinary(HadesHelpers.byteToHex(checksum))
            .padLeft(8, "0");
    return encoder.encode(binaryChecksum);
  }
}
