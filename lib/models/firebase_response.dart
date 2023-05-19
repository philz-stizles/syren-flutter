class FirebaseResponse {
  String? idToken;
  String? email;
  String? refreshToken;
  String? expiresIn;
  String? localId;
  Error? error;

  FirebaseResponse(
      {this.idToken,
      this.email,
      this.refreshToken,
      this.expiresIn,
      this.localId,
      this.error});
}

class FirebaseSignupResponse extends FirebaseResponse {
  FirebaseSignupResponse(
      {idToken, email, refreshToken, expiresIn, localId, error})
      : super(
            idToken: idToken,
            email: email,
            refreshToken: refreshToken,
            expiresIn: expiresIn,
            localId: localId,
            error: error);

  FirebaseSignupResponse.fromJson(Map<String, dynamic> json) {
    idToken = json['idToken'];
    email = json['email'];
    refreshToken = json['refreshToken'];
    expiresIn = json['expiresIn'];
    localId = json['localId'];
    error = Error.fromJson(json['error']);
  }
}

class FirebaseSignInResponse extends FirebaseResponse {
  FirebaseSignInResponse({idToken, email, refreshToken, expiresIn, localId})
      : super(
            idToken: idToken,
            email: email,
            refreshToken: refreshToken,
            expiresIn: expiresIn,
            localId: localId);

  FirebaseSignInResponse.fromJson(Map<String, dynamic> json) {
    idToken = json['idToken'];
    email = json['email'];
    refreshToken = json['refreshToken'];
    expiresIn = json['expiresIn'];
    localId = json['localId'];
  }
}

class Error {
  List<ErrorItem>? errors;
  int? code;
  String? message;

  Error({this.errors, this.code, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    errors = List<ErrorItem>.from(
        json['errors'].map((json) => ErrorItem.fromJson(json)));
    code = json['code'];
    message = json['message'];
  }
}

class ErrorItem {
  String? domain;
  String? reason;
  String? message;

  ErrorItem({this.domain, this.reason, this.message});

  ErrorItem.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    reason = json['reason'];
    message = json['message'];
  }
}
