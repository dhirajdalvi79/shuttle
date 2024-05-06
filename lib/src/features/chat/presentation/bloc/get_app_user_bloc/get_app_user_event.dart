part of 'get_app_user_bloc.dart';

abstract class GetAppUserEvent extends Equatable {
  const GetAppUserEvent();

  @override
  List<Object?> get props => [];
}

final class GetUserEvent extends GetAppUserEvent {
  final String? id;

  const GetUserEvent({this.id});

  @override
  List<Object?> get props => [id];
}
