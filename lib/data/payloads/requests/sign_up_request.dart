class SignUpRequest {
  final String email;
  final String password;
  final List<String> roles;

  const SignUpRequest({
    this.email,
    this.password,
    this.roles,
  });

  Map toMap() {
    return {
      "email": email,
      "password": password,
      "role": roles,
    };
  }
}
