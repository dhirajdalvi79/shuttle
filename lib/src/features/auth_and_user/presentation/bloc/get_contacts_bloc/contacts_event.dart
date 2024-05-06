part of 'get_contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

final class GetContactsEvent extends ContactsEvent {
  const GetContactsEvent();
}
