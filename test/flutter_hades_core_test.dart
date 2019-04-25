import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hades_core/flutter_hades_core.dart';

void main() {
  test('test seed to private key', () {
    print(HadesSeeds.generateSeed());
    expect(
        HadesKeys.seedToPrivate(
            'A3EE78A8220B62CEF0C174557320663B90CDF55E72262648169DFCCBA86F80D6',
            0),
        'B4D713926EA8C12DE86621A0EBCFE3E231BFC19ECB460A2B8BE9AE41B23F9221');
    expect(
        HadesKeys.seedToPrivate(
            '15D59C099F64110166DC7E7B070C9E02AB5AD2E733413C3469A97EAAF3B91B02',
            1),
        '2518DD9056E70009DBCAB6300F643D67931ECBD7AFD1FFB30A80C88E62C53F5B');
  });

  test('test address from seed', () {
    var privKey =
        'B4D713926EA8C12DE86621A0EBCFE3E231BFC19ECB460A2B8BE9AE41B23F9221';
    expect(
        HadesAccounts.createAccount(
            HadesAccountType.HADES, HadesKeys.createPublicKey(privKey)),
        'hades_2zx9q3j82n1oh6wlnj1e1s6r7e11ptaenp8aea61oyxf8a24pghtuua3iodi');
    expect(
        HadesAccounts.createAccount(
            HadesAccountType.CHARON, HadesKeys.createPublicKey(privKey)),
        'charon_2zx9q3j82n1oh6wlnj1e1s6r7e11ptaenp8aea61oyxf8a24pghtuua3iodi');
  });

  test('test hex to byte array and back', () {
    var hex = 'A663F1C07333F29C5533376B43D175DBF66C63EF075B3433F33E52BFA06D4C04';
    var byteArray = HadesHelpers.hexToBytes('A663F1C07333F29C5533376B43D175DBF66C63EF075B3433F33E52BFA06D4C04');
    expect(HadesHelpers.byteToHex(byteArray), hex);
  });

  test('test hex to binary and back', () {
    var hex = '79534C10BAEE7937F4F6E344C7831E2B166A41CAECEE632E157FAAF0D2FD1247';
    var binary = HadesHelpers.hexToBinary('79534C10BAEE7937F4F6E344C7831E2B166A41CAECEE632E157FAAF0D2FD1247');
    expect(HadesHelpers.binaryToHex(binary), hex);
  });

  test('test address validation', () {
    expect(HadesAccounts.isValid(HadesAccountType.HADES, 'hades_2zx9q3j82n1oh6wlnj1e1s6r7e11ptaenp8aea61oyxf8a24pghtuua3iodi'), true);
  });
}
