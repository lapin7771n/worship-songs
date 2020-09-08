class User {
  final int uuid;
  final String email;
  final List<String> role;

  final bool enabled;

  final DateTime creationDate;
  final DateTime lastSignIn;

  const User({
    this.uuid,
    this.email,
    this.creationDate,
    this.enabled,
    this.lastSignIn,
    this.role,
  });
}
