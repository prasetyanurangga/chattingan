class UserModel {
  String id;
  String email;
  String username;

  UserModel({this.id, this.email, this.username});
  factory UserModel.fromDatabaseJson(Map<String, dynamic> data) => UserModel(
    id: data['id'],
    email: data['email'],
    username: data['username'],
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "email": this.email,
    "username": this.username,
  };
}