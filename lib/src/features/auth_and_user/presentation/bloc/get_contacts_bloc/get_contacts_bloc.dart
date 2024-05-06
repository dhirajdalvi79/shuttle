import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/features/auth_and_user/domain/usecases/get_all_contacts.dart';
import '../../../domain/entities/user_entity.dart';

part 'contacts_event.dart';

part 'contacts_state.dart';

class GetContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  GetContactsBloc({required GetAllContacts getAllContacts})
      : _getAllContacts = getAllContacts,
        super(const ContactsInitial()) {
    on<GetContactsEvent>(_getContactsEventHandler);
  }

  final GetAllContacts _getAllContacts;

  void _getContactsEventHandler(
      GetContactsEvent event, Emitter<ContactsState> emit) async {
    emit(const LoadingContacts());

    final contacts = await _getAllContacts();

    contacts.fold((failure) => emit(GetContactsError(message: failure.message)),
        (contacts) => emit(LoadedContacts(contacts: contacts)));
  }
}
