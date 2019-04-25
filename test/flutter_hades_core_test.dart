import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hades_core/flutter_hades_core.dart';

void main() {
  test('test seed to private key', () {
    expect(
        HadesKeys.seedToPrivate(
            'A155C07BEB14F714E199EEEFD6D124E0404115F27EE66A62FB6551EF93C8A0E7',
            0),
        'F1D04E906C73280F46963D7AF34177F4CDB6F7143AFEA3C7791C017B5A1806A3');
    expect(
        HadesKeys.seedToPrivate(
            'A155C07BEB14F714E199EEEFD6D124E0404115F27EE66A62FB6551EF93C8A0E7',
            1),
        '43BB936DD02F1612A4BBBE8E0823D4EDF1207F1C75DC486BA35663622EA18265');
  });

  test('test address from seed', () {
    var privKey = '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';
    expect(HadesAccounts.createAccount(HadesAccountType.CHARON, 
                                      HadesKeys.createPublicKey(privKey)),
          'charon_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkggc');
    expect(HadesAccounts.createAccount(HadesAccountType.HADES, 
                                      HadesKeys.createPublicKey(privKey)),
          'hades_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkggc');
  });

  test('test hex to byte array and back', () {
    var hex =
        'F1D04E906C73280F46963D7AF34177F4CDB6F7143AFEA3C7791C017B5A1806A3';
    var byteArray = HadesHelpers.hexToBytes(
        'F1D04E906C73280F46963D7AF34177F4CDB6F7143AFEA3C7791C017B5A1806A3');
    expect(HadesHelpers.byteToHex(byteArray), hex);
  });

  test('test hex to binary and back', () {
    var hex =
        'F1D04E906C73280F46963D7AF34177F4CDB6F7143AFEA3C7791C017B5A1806A3';
    var binary = HadesHelpers.hexToBinary(
        'F1D04E906C73280F46963D7AF34177F4CDB6F7143AFEA3C7791C017B5A1806A3');
    expect(HadesHelpers.binaryToHex(binary), hex);
  });

  test('test bigint to byte and back', () {
    var raw = BigInt.parse('1000000000000000000000000000000');
    var byteRaw = HadesHelpers.bigIntToBytes(raw);
    expect(HadesHelpers.byteToBigInt(byteRaw), raw);
  });

  test('test address validation', () {
    expect(
        HadesAccounts.isValid(HadesAccountType.HADES,
            'hades_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkggc'),
        true);
    expect(
        HadesAccounts.isValid(HadesAccountType.CHARON,
            'charon_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkggc'),
        true);
  });

  test('test state block hash computation', () {
    var accountType = HadesAccountType.HADES;
    var account =
        'xrb_1ak9nqn1m5u5ze4yr4rfm7rnwjny1qw96r46ncm88oiophz8yakdggfb6bo4';
    var previous =
        '3DA527883F4C39A1C7C312DEB55766E975B512544595D574347B5F04BF19413E';
    var representative =
        'xrb_3rw4un6ys57hrb39sy1qx8qy5wukst1iiponztrz9qiz6qqa55kxzx4491or';
    var balance = BigInt.parse('30109202700477890000000000000000000');
    var link =
        'xrb_3ok55uirensct6yjq6j5w7k9w38hngubozjgi77cwsgaxuh9m9gkqek1f4yi';
    var calculatedHash = HadesBlocks.computeStateHash(
        accountType, account, previous, representative, balance, link);
    expect(calculatedHash,
        '714DC230267C4E5A6BA0D61E6B90410C67D17F649A2752297E3115F12AEFBD9E');
    // receive state block
    account =
        'xrb_3igf8hd4sjshoibbbkeitmgkp1o6ug4xads43j6e4gqkj5xk5o83j8ja9php';
    previous =
        'FC5A7FB777110A858052468D448B2DF22B648943C097C0608D1E2341007438B0';
    representative =
        'xrb_3p1asma84n8k84joneka776q4egm5wwru3suho9wjsfyuem8j95b3c78nw8j';
    balance = BigInt.parse('5000000000000000000000000000001');
    link = 'B2EC73C1F503F47E051AD72ECB512C63BA8E1A0ACC2CEE4EA9A22FE1CBDB693F';
    calculatedHash = HadesBlocks.computeStateHash(
        accountType, account, previous, representative, balance, link);
    expect(calculatedHash,
        '597395E83BD04DF8EF30AF04234EAAFE0606A883CF4AEAD2DB8196AAF5C4444F');
    // send state block
    account =
        'xrb_3igf8hd4sjshoibbbkeitmgkp1o6ug4xads43j6e4gqkj5xk5o83j8ja9php';
    previous =
        '597395E83BD04DF8EF30AF04234EAAFE0606A883CF4AEAD2DB8196AAF5C4444F';
    representative =
        'xrb_3p1asma84n8k84joneka776q4egm5wwru3suho9wjsfyuem8j95b3c78nw8j';
    balance = BigInt.parse('3000000000000000000000000000001');
    link = 'xrb_1q3hqecaw15cjt7thbtxu3pbzr1eihtzzpzxguoc37bj1wc5ffoh7w74gi6p';
    calculatedHash = HadesBlocks.computeStateHash(
        accountType, account, previous, representative, balance, link);
    expect(calculatedHash,
        '128106287002E595F479ACD615C818117FCB3860EC112670557A2467386249D4');
    // change state block
    account =
        'xrb_3igf8hd4sjshoibbbkeitmgkp1o6ug4xads43j6e4gqkj5xk5o83j8ja9php';
    previous =
        '128106287002E595F479ACD615C818117FCB3860EC112670557A2467386249D4';
    representative =
        'xrb_1anrzcuwe64rwxzcco8dkhpyxpi8kd7zsjc1oeimpc3ppca4mrjtwnqposrs';
    balance = BigInt.parse('3000000000000000000000000000001');
    link = '0000000000000000000000000000000000000000000000000000000000000000';
    calculatedHash = HadesBlocks.computeStateHash(
        accountType, account, previous, representative, balance, link);
    expect(calculatedHash,
        '2A322FD5ACAF50C057A8CF5200A000CF1193494C79C786B579E0B4A7D10E5A1E');
  });

  test('test block signature', () {
    var privKey =
        '9F0E444C69F77A49BD0BE89DB92C38FE713E0963165CCA12FAF5712D7657120F';
    var hash =
        'AEC75F807DCE45AFA787DE7B395BE498A885525569DD614162E0C80FD4F27EE9';

    String signature = HadesSignatures.signBlock(hash, privKey);

    expect(signature,
        '1123C926EF53B0FFA3585D5F6FA17D05B2AAD486D28CBEED88837B83265F264CBAF3FEA78AF80AAB4C59740546B220ADBE207F6B800FFE864E0934E9C1078401');
  });
}
