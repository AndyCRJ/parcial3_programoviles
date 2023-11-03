class UserData {
  final String username;
  final String password;

  UserData({required this.username, required this.password});
}

List<UserData> users = [
  UserData(username: 'usuario1', password: 'pass1'),
  UserData(username: 'usuario2', password: 'pass2'),
  // Agrega más usuarios si lo necesitas
];
