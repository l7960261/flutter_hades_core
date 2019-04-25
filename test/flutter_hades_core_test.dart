import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hades_core/flutter_hades_core.dart';

void main() {
  test('test seed to private key', () {
    expect(HadesKeys.seedToPrivate('A663F1C07333F29C5533376B43D175DBF66C63EF075B3433F33E52BFA06D4C04', 0), 'a03df7a01a0af32f6452c9462f2f24e3311482c4b07ec0683ab151c6964ee6e9');
    expect(HadesKeys.seedToPrivate('79534C10BAEE7937F4F6E344C7831E2B166A41CAECEE632E157FAAF0D2FD1247', 1), 'b1f90a68e7857f7aebb7c58cce00009f3f6b8865df1e76d47385bddecb0c3de2');
  });
}
