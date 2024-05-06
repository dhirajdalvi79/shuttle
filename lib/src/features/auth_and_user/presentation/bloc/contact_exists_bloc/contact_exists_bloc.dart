import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/contact_exists.dart';

part 'contact_exists_event.dart';

part 'contact_exists_state.dart';

class ContactExistsBloc extends Bloc<ContactExistsEvent, ContactExistsState> {
  ContactExistsBloc({required ContactExists contactExists})
      : _contactExists = contactExists,
        super(const ContactExistsInitial()) {
    on<CheckContactExistsEvent>(_checkContactExistsEventHandler);
  }

  final ContactExists _contactExists;

  void _checkContactExistsEventHandler(
      CheckContactExistsEvent event, Emitter<ContactExistsState> emit) async {
    emit(const LoadingContactExistsState());
    final contactExists = await _contactExists(parameter: event.id);
    contactExists.fold(
        (failure) => emit(ContactExistsErrorState(message: failure.message)),
        (contactExists) =>
            emit(LoadedContactExistsState(contactExists: contactExists)));
  }
}
