import 'package:equatable/equatable.dart';

abstract class CustomException extends Equatable implements Exception {
  const CustomException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
