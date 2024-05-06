import 'exceptions.dart';

class EmailAlreadyExistsException extends CustomException {
  const EmailAlreadyExistsException({required super.message});
}

class InvalidEmailException extends CustomException {
  const InvalidEmailException({required super.message});
}

class WeakPasswordException extends CustomException {
  const WeakPasswordException({required super.message});
}

class WrongPasswordException extends CustomException {
  const WrongPasswordException({required super.message});
}

class UserNotFoundException extends CustomException {
  const UserNotFoundException({required super.message});
}

class LogOutException extends CustomException {
  const LogOutException({required super.message});
}

class UnknownException extends CustomException {
  const UnknownException({required super.message});
}

class ProfileImageUploadException extends CustomException {
  const ProfileImageUploadException({required super.message});
}

class ContactsException extends CustomException {
  const ContactsException({required super.message});
}

class AddContactException extends CustomException {
  const AddContactException({required super.message});
}
