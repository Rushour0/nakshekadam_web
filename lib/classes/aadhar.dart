class Aadhar {
  Aadhar._internal();
  static final Aadhar _aadhar = Aadhar._internal();
  static String _number = '';
  static String _link = '';
  static String _id = '';

  // Link getter
  String get link => _link;

  // Number getter
  String get number => _number;

  // ID getter
  String get id => _id;

  // Number setter
  set setNumber(_aadharNumber) {
    _number = _aadharNumber;
  }

  // Link setter
  set setLink(_aadharLink) {
    _link = _aadharLink;
  }

  // ID setter
  set setId(_requestId) {
    _id = _requestId;
  }

  factory Aadhar() => _aadhar;
}
