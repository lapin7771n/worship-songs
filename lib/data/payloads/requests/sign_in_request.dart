class SignInRequest {
  final String email;
  final String password;
  final String idToken;

  const SignInRequest({
    this.email,
    this.password,
    this.idToken,
  });

  Map toMap() {
    return {
      "email": email,
      if (password != null) "password": password,
      if (idToken != null) "idToken": idToken,
    };
  }
}
