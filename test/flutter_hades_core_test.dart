import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hades_core/flutter_hades_core.dart';

void main() {
  test('test seed to private key', () {
    expect(
        HadesKeys.seedToPrivate(
            'A663F1C07333F29C5533376B43D175DBF66C63EF075B3433F33E52BFA06D4C04',
            0),
        'A03DF7A01A0AF32F6452C9462F2F24E3311482C4B07EC0683AB151C6964EE6E9');
    expect(
        HadesKeys.seedToPrivate(
            '79534C10BAEE7937F4F6E344C7831E2B166A41CAECEE632E157FAAF0D2FD1247',
            1),
        '6FC7BB83BD8EE10313C3F2DB41DF57496B80045206E0088E834CC1E0A4755AFD');
  });

  test('test address from seed', () {
    var privKey =
        '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';

    expect(
        HadesAccounts.createAccount(
            HadesAccountType.HADES, HadesKeys.createPublicKey(privKey)),
        'hades_1zflngs3cxdislhrs9824n4da6f621gaidhpqahyu2oxniz1gzxasjticcl9');
    expect(
        HadesAccounts.createAccount(
            HadesAccountType.CHARON, HadesKeys.createPublicKey(privKey)),
        'charon_1zflngs3cxdislhrs9824n4da6f621gaidhpqahyu2oxniz1gzxasjticcl9');
  });

  test('test hex to byte array and back', () {
    var initialPrivkey = '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';
    var byteKey = HadesHelpers.hexToByted('67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6');
    expect(HadesHelpers.byteToHex(byteKey), initialPrivkey);
  });
}
