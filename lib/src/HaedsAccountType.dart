class HadesAccountType {
  static const int HADES = 1;
  static const int CHARON = 2;
  static const String HADES_REGEX =
      r"^(hades_)(_)(1|3)[12346789abcdefghijlmnopqrstuwxyz]{59}$";
  static const String CHARON_REGEX =
      r"^(charon_)(_)(1|3)[12346789abcdefghijlmnopqrstuwxyz]{59}$";

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

  static String getRegex(int type) {
    switch (type) {
      case HADES:
        return HADES_REGEX;
      case CHARON:
        return CHARON_REGEX;
      default:
        return HADES_REGEX;
    }
  }
}
