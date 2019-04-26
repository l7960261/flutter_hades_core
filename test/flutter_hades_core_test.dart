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
    var privKey =
        '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';
    expect(
        HadesAccounts.createAccount(
            HadesAccountType.CHARON, HadesKeys.createPublicKey(privKey)),
        'charon_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44929oouoturlggc');
    expect(
        HadesAccounts.createAccount(
            HadesAccountType.HADES, HadesKeys.createPublicKey(privKey)),
        'hades_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44929oouoturlggc');
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
            'hades_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44929oouoturlggc'),
        true);
    expect(
        HadesAccounts.isValid(HadesAccountType.CHARON,
            'charon_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44929oouoturlggc'),
        true);
  });

  test('test state block hash computation', () {
    // open state block
    var accountType = HadesAccountType.HADES;
    var account =
        'hades_2wgibta8rwsa2x5behdtyf1qhx8fpuujagqynh5ql912hff2i2o5gwmyp8hf';
    var previous = '0';
    var representative =
        'hades_1ixulfpx1drp4cldqhng21jxbuhj62zjrxgwb2ot8om5eaqc51m7htf67j56';
    var balance = BigInt.parse('1');
    var link =
        '1EF0AD02257987B48030CC8D38511D3B2511672F33AF115AD09E18A86A8355A8';
    var calculatedHash = HadesBlocks.computeStateHash(
        accountType, account, previous, representative, balance, link);
    expect(calculatedHash,
        'B04C55917E454C23FCC32F304C36F4ABF162D940903DCDC5018A98CF918906D3');
    // receive state block
    account =
        'hades_2wgibta8rwsa2x5behdtyf1qhx8fpuujagqynh5ql912hff2i2o5gwmyp8hf';
    previous =
        'FC5A7FB777110A858052468D448B2DF22B648943C097C0608D1E2341007438B0';
    representative =
        'hades_1ixulfpx1drp4cldqhng21jxbuhj62zjrxgwb2ot8om5eaqc51m7htf67j56';
    balance = BigInt.parse('5000000000000000000000000000001');
    link = 'B2EC73C1F503F47E051AD72ECB512C63BA8E1A0ACC2CEE4EA9A22FE1CBDB693F';
    calculatedHash = HadesBlocks.computeStateHash(
        accountType, account, previous, representative, balance, link);
    expect(calculatedHash,
        '5E0E522F0F26937ECD1CF8EFD784C2B602E81509889B4D28E70B7AA457FCE6AE');
    // send state block
    account =
        'hades_2wgibta8rwsa2x5behdtyf1qhx8fpuujagqynh5ql912hff2i2o5gwmyp8hf';
    previous =
        '597395E83BD04DF8EF30AF04234EAAFE0606A883CF4AEAD2DB8196AAF5C4444F';
    representative =
        'hades_1ixulfpx1drp4cldqhng21jxbuhj62zjrxgwb2ot8om5eaqc51m7htf67j56';
    balance = BigInt.parse('3000000000000000000000000000001');
    link = 'hades_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44929oouoturlggc';
    calculatedHash = HadesBlocks.computeStateHash(
        accountType, account, previous, representative, balance, link);
    expect(calculatedHash,
        'A4D596897B36679289B27E995B1179232DFEA5972333BB0672906C800FD778FE');
    // change state block
    account =
        'hades_2wgibta8rwsa2x5behdtyf1qhx8fpuujagqynh5ql912hff2i2o5gwmyp8hf';
    previous =
        '128106287002E595F479ACD615C818117FCB3860EC112670557A2467386249D4';
    representative =
        'hades_171mzu1h7n6s8dxazhdb7ohsqtg8dz9n9tt8hba9jag5t85s9lm71mnzg8q2';
    balance = BigInt.parse('3000000000000000000000000000001');
    link = '0000000000000000000000000000000000000000000000000000000000000000';
    calculatedHash = HadesBlocks.computeStateHash(
        accountType, account, previous, representative, balance, link);
    expect(calculatedHash,
        '6B458D76C30C820674A193E8C69762A302A3664D37B749B0EF680B06CC3F45BB');
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
