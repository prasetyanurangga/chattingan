import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class OtherEvent extends Equatable {
  const OtherEvent();
  @override
  List<Object> get props => [];
}

class FetchFile extends OtherEvent {
  final String fileId;

  const FetchFile({
    @required this.fileId,
  });

  @override
  List<Object> get props => [fileId];

  @override
  String toString() =>
      'LoginButtonPressed { filterText: $fileId}';
}