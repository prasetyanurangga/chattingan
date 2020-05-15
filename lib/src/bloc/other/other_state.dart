import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class OtherState extends Equatable {
  const OtherState();

  @override
  List<Object> get props => [];
}

class OtherInitial extends OtherState {}

class OtherLoading extends OtherState {}

class OtherSuccess extends OtherState {}

class AttachFile extends OtherState {
  final File file;

  AttachFile({@required this.file});

  @override
  List<Object> get props => [file];

  @override
  String toString() => 'OtherFailure { error: $file }';

}

class OtherFailure extends OtherState {
  final String error;

  const OtherFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'OtherFailure { error: $error }';
}