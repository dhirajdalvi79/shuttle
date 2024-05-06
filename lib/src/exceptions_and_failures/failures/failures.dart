import 'package:equatable/equatable.dart';

/// Defining failure messages for accessing remote or internal services.
abstract class Failure extends Equatable {
  const Failure({this.statusCode, required this.message});

  final int? statusCode;
  final String message;

  @override
  List<Object?> get props => [statusCode, message];
}
