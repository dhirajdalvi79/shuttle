part of 'add_to_contact_bloc.dart';

final class AddToContactEvent extends Equatable {
  final String id;

  const AddToContactEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
