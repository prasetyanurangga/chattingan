import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:chattingan/src/bloc/other/other_event.dart';
import 'package:chattingan/src/bloc/other/other_state.dart';
import 'package:chattingan/src/http/response_data.dart';
import 'package:chattingan/src/model/file_response_model.dart';
import 'package:chattingan/src/repository/main/main_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {

  final MainRepository mainRepository;

  OtherBloc({
    @required this.mainRepository
  });

  @override
  OtherState get initialState => OtherInitial();

  @override
  Stream<OtherState> mapEventToState(OtherEvent event) async* {
    if (event is FetchFile) {
      print("Test");
      yield OtherLoading();
      try {
        final ResponseData<FileResponseModel> response =
        await mainRepository.getFiles(fileId: event.fileId);
        print("status nya");
        print(response.status);

        if (response.status == Status.ConnectivityError) {
          //Internet problem
          yield const OtherFailure(error: "");
        }
        if (response.status == Status.Success) {
          String fileRaw =  response.data.data_file[0].data_binary;
          String extension = response.data.data_file[0].extension;
          String nameFile = response.data.data_file[0].name;
          Uint8List base64Decode(String source) => base64.decode(source);
          Uint8List fileByte = base64Decode(fileRaw);
          final directory = await getApplicationDocumentsDirectory();
          String pathFile = '${directory.path}/$nameFile';
          final file = File(pathFile);
          file.writeAsBytesSync(fileByte);
          OpenFile.open(pathFile);
          //yield MainSuccessUser(usersModel: response.data);
        } else {
          yield OtherFailure(error: response.message);
        }
      } catch (error) {
        yield OtherFailure(error: error.toString());
      }
    }
  }
}