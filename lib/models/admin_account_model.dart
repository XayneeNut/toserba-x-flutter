class AdminAccountModel {
  const AdminAccountModel(
      {required this.accountId,
      required this.email,
      required this.username,
      required this.password});
  final int accountId;
  final String email;
  final String username;
  final String password;
}
