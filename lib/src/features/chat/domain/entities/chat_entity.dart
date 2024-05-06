import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String? id;
  final DateTime timeStamp;

  const ChatEntity({
    this.id,
    required this.timeStamp,
  });

  ChatEntity copyWith({
    String? id,
    DateTime? timeStamp,
  }) {
    return ChatEntity(
      id: id ?? this.id,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  @override
  List<Object?> get props => [
        id,
        timeStamp,
      ];
}
