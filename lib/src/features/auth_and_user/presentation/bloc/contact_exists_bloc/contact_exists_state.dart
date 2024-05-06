part of 'contact_exists_bloc.dart';

sealed class ContactExistsState extends Equatable {
  const ContactExistsState();

  @override
  List<Object?> get props => [];
}

final class ContactExistsInitial extends ContactExistsState {
  const ContactExistsInitial();
}

final class LoadingContactExistsState extends ContactExistsState {
  const LoadingContactExistsState();
}

final class LoadedContactExistsState extends ContactExistsState {
  final bool contactExists;

  const LoadedContactExistsState({required this.contactExists});

  @override
  List<Object?> get props => [contactExists];
}

final class ContactExistsErrorState extends ContactExistsState {
  final String message;

  const ContactExistsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
