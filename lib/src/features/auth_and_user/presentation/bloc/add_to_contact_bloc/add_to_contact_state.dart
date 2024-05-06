part of 'add_to_contact_bloc.dart';

sealed class AddToContactState extends Equatable {
  const AddToContactState();

  @override
  List<Object?> get props => [];
}

final class AddToContactInitial extends AddToContactState {
  const AddToContactInitial();
}

final class AddToContactLoadingState extends AddToContactState {
  const AddToContactLoadingState();
}

final class AddToContactSuccessState extends AddToContactState {
  final String message;

  const AddToContactSuccessState({required this.message});
}

final class AddToContactFailureState extends AddToContactState {
  final String message;

  const AddToContactFailureState({required this.message});
}
