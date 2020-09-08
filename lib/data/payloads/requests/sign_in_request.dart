class SignInRequest {
  final String email;
  final String password;

  const SignInRequest({
    this.email,
    this.password,
  });

  Map toMap() {
    return {
      "email": email,
      "password": password,
    };
  }
}
