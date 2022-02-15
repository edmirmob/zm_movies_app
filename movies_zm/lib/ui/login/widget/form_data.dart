class FormData {
  final String username;
  final String password;
  final bool isRemember;

  FormData({this.username, this.password, this.isRemember = false});

  FormData copyWith({
    String username,
    String password,
    bool isRemember,
  }) {
    return FormData(
        username: username ?? this.username,
        password: password ?? this.password,
        isRemember: isRemember ?? this.isRemember);
  }
}
