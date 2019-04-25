import 'dart:typed_data' show Uint8List;
import 'package:hex/hex.dart';

class HadesHelpers {
  static List<String> hexArray = '0123456789ABCDEF'.split('');

  static String byteToHex(Uint8List bytes) {
    return HEX.encode(bytes).toUpperCase();
  }

  static Uint8List hexToBytes(String hex) {
    return Uint8List.fromList(HEX.decode(hex));
  }

  static String hexToBinary(String hex) {
    return BigInt.parse(hex, radix: 16).toRadixString(2);
  }

  static String binaryToHex(String binary) {
    return BigInt.parse(binary, radix: 2).toRadixString(16);
  }

  static Uint8List reverse(Uint8List bytes) {
    Uint8List reversed = Uint8List(bytes.length);
    for (var i = bytes.length; i > 0; i--) {
      reversed[bytes.length - i] = bytes[i - 1];
    }
    return reversed;
  }
}
