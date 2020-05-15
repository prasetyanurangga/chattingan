import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
  @override
  List<Object> get props => [];
}

class FetchAllChat extends MainEvent {
  final String filterText;

  const FetchAllChat({
    @required this.filterText,
  });

  @override
  List<Object> get props => [filterText];

  @override
  String toString() =>
      'LoginButtonPressed { filterText: $filterText}';
}
class FetchChat extends MainEvent {
  final String senderId;

  const FetchChat({
    @required this.senderId,
  });

  @override
  List<Object> get props => [senderId];

  @override
  String toString() =>
      'LoginButtonPressed { senderId: $senderId}';
}
class FetchAllUser extends MainEvent {
  final String filterText;

  const FetchAllUser({
    @required this.filterText,
  });

  @override
  List<Object> get props => [filterText];

  @override
  String toString() =>
      'LoginButtonPressed { filterText: $filterText}';
}

