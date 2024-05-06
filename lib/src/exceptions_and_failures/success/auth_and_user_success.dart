import 'package:shuttle/src/exceptions_and_failures/success/success.dart';

/// Sign Up success
class SignUpSuccess extends Success {
  const SignUpSuccess({super.statusCode, required super.message});
}

class LogInSuccess extends Success {
  const LogInSuccess({required super.message});
}

class LogOutSuccess extends Success {
  const LogOutSuccess({required super.message});
}

class AddContactSuccess extends Success {
  const AddContactSuccess({required super.message});
}
