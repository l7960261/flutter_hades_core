class HadesAccountType {
  static const int HADES = 1;
  static const int CHARON = 2;

  static String getPerfix(int type) {
    switch (type) {
      case HADES:
        return 'hades_';
      case CHARON:
        return 'charon_';
      default:
        return 'hades_';
    }
  }
}
