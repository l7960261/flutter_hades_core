import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hades_core/flutter_hades_core.dart';

void main() {
  test('test generate seed length equal as 64', () {
    expect(HadesSeeds.generateSeed().length, 64);
  });
}
