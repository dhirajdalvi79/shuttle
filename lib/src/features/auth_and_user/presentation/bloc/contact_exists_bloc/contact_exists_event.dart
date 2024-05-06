part of 'contact_exists_bloc.dart';

sealed class ContactExistsEvent extends Equatable {
  const ContactExistsEvent();

  @override
  List<Object?> get props => [];
}

final class CheckContactExistsEvent extends ContactExistsEvent {
  final String id;

  const CheckContactExistsEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
