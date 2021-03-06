import 'dart:typed_data';
import 'package:flutter_hades_core/flutter_hades_core.dart';

class HadesBlocks {
  static String computeStateHash(int accountType, String account,
      String previous, String representative, BigInt balance, String link) {
    assert(accountType == HadesAccountType.HADES ||
        accountType == HadesAccountType.CHARON);
    Uint8List statePreamble = HadesHelpers.hexToBytes(
        "0000000000000000000000000000000000000000000000000000000000000006");
    Uint8List accountBytes =
        HadesHelpers.hexToBytes(HadesAccounts.extractPublicKey(account));
    Uint8List previousBytes =
        HadesHelpers.hexToBytes(previous.padLeft(64, "0"));
    Uint8List representativeBytes =
        HadesHelpers.hexToBytes(HadesAccounts.extractPublicKey(representative));
    Uint8List balanceBytes = HadesHelpers.bigIntToBytes(balance);
    Uint8List linkBytes = HadesAccounts.isValid(accountType, link)
        ? HadesHelpers.hexToBytes(HadesAccounts.extractPublicKey(link))
        : HadesHelpers.hexToBytes(link);
    return HadesHelpers.byteToHex(Hashes.digest256([
      statePreamble,
      accountBytes,
      previousBytes,
      representativeBytes,
      balanceBytes,
      linkBytes
    ])).toUpperCase();
  }
}
