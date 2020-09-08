class SignInResponse {
  final String accessToken;
  final int id;
  final String email;
  final List<String> roles;
  final String type;
  final DateTime creationDate;
  final DateTime lastSignInDate;
  final bool enabled;

  const SignInResponse({
    this.accessToken,
    this.id,
    this.email,
    this.roles,
    this.type,
    this.creationDate,
    this.lastSignInDate,
    this.enabled,
  });

  SignInResponse.fromMap(Map<String, dynamic> data)
      : accessToken = data["token"],
        id = data["id"],
        email = data["email"],
        roles = data["roles"].cast<String>(),
        type = data["type"],
        creationDate = DateTime.parse(data["creationDate"]),
        lastSignInDate = DateTime.parse(data["lastSignInDate"]),
        enabled = data["enabled"];
}
