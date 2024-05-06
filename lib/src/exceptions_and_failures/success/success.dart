import 'package:equatable/equatable.dart';

/// Defining success messages for accessing remote or internal services.
abstract class Success extends Equatable {
  const Success({this.statusCode, required this.message});

  final int? statusCode;
  final String message;

  @override
  List<Object?> get props => [statusCode, message];
}
