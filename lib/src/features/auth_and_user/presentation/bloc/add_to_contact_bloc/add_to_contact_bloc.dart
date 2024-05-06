import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_to_contact.dart';

part 'add_to_contact_event.dart';

part 'add_to_contact_state.dart';

class AddToContactBloc extends Bloc<AddToContactEvent, AddToContactState> {
  AddToContactBloc({required AddToContact addToContact})
      : _addToContact = addToContact,
        super(const AddToContactInitial()) {
    on<AddToContactEvent>(_addToContactEvent);
  }

  final AddToContact _addToContact;

  void _addToContactEvent(
      AddToContactEvent event, Emitter<AddToContactState> emit) async {
    emit(const AddToContactLoadingState());
    final result = await _addToContact(parameter: event.id);
    result.fold(
        (failure) => emit(AddToContactFailureState(message: failure.message)),
        (success) => emit(AddToContactSuccessState(message: success.message)));
  }
}
