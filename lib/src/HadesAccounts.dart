import "dart:typed_data" show Uint8List;

import 'package:flutter_hades_core/flutter_hades_core.dart';

class HadesAccounts {
  static HadesAccountEncodes encoder = HadesAccountEncodes();

  static String createAccount(int accountType, String publicKey) {
    assert(accountType == HadesAccountType.HADES ||
        accountType == HadesAccountType.CHARON);
    var binaryPubkey = HadesHelpers.hexToBinary(publicKey).padLeft(260, "0");
    var encodedCheckSum = calculatedEncodedCheckSum(binaryPubkey);
    var encodedPubKey = encoder.encode(binaryPubkey);
    return HadesAccountType.getPerfix(accountType) +
        encodedPubKey +
        encodedCheckSum;
  }

  static isValid(int accountType, String account) {
    assert(accountType == HadesAccountType.HADES ||
        accountType == HadesAccountType.CHARON);
    assert(account != null);

    if (!account.contains(RegExp(HadesAccountType.getRegex(accountType)))) {
      return false;
    }
    String expectedChecksum = account.substring(account.length - 8);
    String encodedChecksum = calculatedEncodedCheckSum(extractPublicKey(account));
    return expectedChecksum == encodedChecksum;
  }

  static String extractEncodedPublicKey(String account) {
    return account.startsWith('hades_') 
    ? account.substring(6, 58)
    : account.substring(7, 59);
  }

  static String extractPublicKey(String account) {
    assert(account != null);
    String encodedPublicKey = extractEncodedPublicKey(account);
    String binaryPublicKey = encoder.decode(encodedPublicKey).substring(4);
    String hexPublicKey = HadesHelpers.binaryToHex(binaryPublicKey).padLeft(64, "0");
    return hexPublicKey;
  }

  static String calculatedEncodedCheckSum(String publicKey) {
    Uint8List checksum = HadesHelpers.reverse(
        Hashes.digest(5, [HadesHelpers.hexToBytes(publicKey)]));
    String binaryChecksum =
        HadesHelpers.hexToBinary(HadesHelpers.byteToHex(checksum))
            .padLeft(40, "0");
    return encoder.encode(binaryChecksum);
  }
}
