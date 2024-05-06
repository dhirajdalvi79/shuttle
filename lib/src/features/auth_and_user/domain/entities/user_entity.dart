enum UserStatus {
  online,
  offline,
  typing,
}

class UserEntity {
  final String? id;
  final String userName;
  final String name;
  final String email;
  final String? password;
  final String? profileImageUrl;
  final String bio;
  final DateTime birthDate;
  final UserStatus userStatus;

  UserEntity({
    this.id,
    required this.userName,
    required this.name,
    required this.email,
    this.password,
    this.profileImageUrl,
    required this.bio,
    required this.birthDate,
    this.userStatus = UserStatus.offline,
  });

  UserEntity copyWith(
      {String? id,
      String? userName,
      String? name,
      String? email,
      String? password,
      String? profileImageUrl,
      String? bio,
      DateTime? birthDate,
      UserStatus? userStatus}) {
    return UserEntity(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        name: name ?? this.name,
        email: email ?? this.email,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        bio: bio ?? this.bio,
        birthDate: birthDate ?? this.birthDate,
        userStatus: userStatus ?? this.userStatus);
  }

  factory UserEntity.test() {
    return UserEntity(
      id: 'test.id',
      userName: 'test.username',
      name: 'test.name',
      email: 'test.email',
      password: 'test.password',
      profileImageUrl: 'test.profile_pic',
      bio: 'test.bio',
      birthDate: DateTime(12),
      userStatus: UserStatus.online,
    );
  }
}

class UserLogInCredEntity {
  const UserLogInCredEntity({required this.email, required this.password});

  factory UserLogInCredEntity.test() {
    return const UserLogInCredEntity(
        email: 'test.email', password: 'test.password');
  }

  final String email;
  final String password;
}

class UserUpdate {
  static Map<String, dynamic> update(
      {String? id,
      String? userName,
      String? name,
      String? email,
      String? password,
      String? profileImageUrl,
      String? bio,
      DateTime? birthDate,
      UserStatus? userStatus}) {
    return {
      if (id != null) 'id': id,
      if (userName != null) 'username': userName,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (profileImageUrl != null) 'profile_pic': profileImageUrl,
      if (bio != null) 'bio': bio,
      if (birthDate != null) 'date_of_birth': birthDate,
      if (userStatus != null) 'user_status': userStatus,
    };
  }
}
