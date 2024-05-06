part of 'get_contacts_bloc.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object?> get props => [];
}

final class ContactsInitial extends ContactsState {
  const ContactsInitial();
}

final class LoadingContacts extends ContactsState {
  const LoadingContacts();
}

final class LoadedContacts extends ContactsState {
  final List<UserEntity> contacts;

  const LoadedContacts({required this.contacts});

  @override
  List<Object?> get props => [contacts];
}

final class GetContactsError extends ContactsState {
  final String message;

  const GetContactsError({required this.message});

  @override
  List<Object?> get props => [message];
}
