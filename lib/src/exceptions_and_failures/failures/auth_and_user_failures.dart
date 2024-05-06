import 'failures.dart';

/// Sign Up failure
class SignUpFailure extends Failure {
  const SignUpFailure({super.statusCode, required super.message});
}

class LogInFailure extends Failure {
  const LogInFailure({required super.message});
}

class LogOutFailure extends Failure {
  const LogOutFailure({required super.message});
}

class ContactsFailure extends Failure {
  const ContactsFailure({required super.message});
}

class AddContactFailure extends Failure {
  const AddContactFailure({required super.message});
}
