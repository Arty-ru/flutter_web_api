class User{
  final int userId;
  final String name;
  final String password;

  const User({
    required this.userId, 
    required this.name, 
    required this.password});

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json['userId'], 
    name: json['name'], 
    password: json['password']);

  Map<String, dynamic> toJson() => {  
    'userId': userId, 
    'name': name, 
    'password': password}; 
}