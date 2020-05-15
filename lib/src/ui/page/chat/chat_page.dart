//login_register.dart
import 'dart:convert';
import 'dart:io';

import 'package:chattingan/src/bloc/main/main_bloc.dart';
import 'package:chattingan/src/bloc/main/main_event.dart';
import 'package:chattingan/src/bloc/main/main_state.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:chattingan/src/constant/string.dart';
import 'package:chattingan/src/http/socket_io_provider.dart';
import 'package:chattingan/src/local/model/user_model.dart';
import 'package:chattingan/src/model/chat_model.dart';
import 'package:chattingan/src/model/chat_response_model.dart';
import 'package:chattingan/src/model/file_model.dart';
import 'package:chattingan/src/model/sender_model.dart';
import 'package:chattingan/src/model/user_chat_response_model.dart';
import 'package:chattingan/src/repository/authentication/authentication_repository.dart';
import 'package:chattingan/src/ui/component/atoms/label.dart';
import 'package:chattingan/src/ui/component/atoms/textfield.dart';
import 'package:chattingan/src/ui/component/molecules/card/card_chat.dart';
import 'package:chattingan/src/ui/component/molecules/dialog/dialog_file.dart';
import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'dart:async';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key,
    this.title,
    this.senderId,
    this.senderName : "",
    this.senderIsOnline : false,
    this.previousPage,
    this.avatarUser : Strings.dummy_image_avatar,
    this.heightPhoto : Dimens.Level_8,
    this.widthPhoto : Dimens.Level_8,
    this.maxRadiusPhoto : Dimens.Level_3,
  }) : super(key: key);
  final String
      title,
      senderId,
  senderName,
  previousPage,
      avatarUser;
  final double
  heightPhoto,
      widthPhoto,
      maxRadiusPhoto;
  final bool
  senderIsOnline;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  ScrollController scrollController;
  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  List<Chats> dataChat;
  IO.Socket socket;
  String statusUser = "Offline";
  bool isTyping = true;
  bool hasAddFile = false;
  String fileName = "";
  String fileExt = "";
  int fileSize = 0;
  File dataFile;




  final _pesanController = TextEditingController();

  Future<void> _onSendButtonPressed() async {
    List<UserModel> userAll = await authenticationRepository.fetchAllUser();
    String userid = userAll[0].id;
    Chats chats = new Chats();
    if(hasAddFile)
      {
        Files files = new Files();
        List<Files> tempFile = new List<Files>();
        files.name = fileName;
        files.extension = fileExt;
        files.size = fileSize;
        tempFile.add(files);
        chats.data_file = tempFile;
      }
    chats.message = _pesanController.text;
    chats.updatedAt = DateTime.now().toString();
    chats.sender = userid;

    var dataFiles = dataFile != null ? dataFile.readAsBytesSync() : null;
    socket.emitWithAck("chat message", {
      'message' :  _pesanController.text,
      'sender' : userid,
      'reciver' : widget.senderId,
      'data_file' : dataFiles,
      'name_file' : fileName,
      'size_file' : fileSize,
      'ext_file' : fileExt,
    }, ack : (data) {
      print(data);
      Map<String, dynamic> dataResponse = jsonDecode(data);
      print(dataResponse);
      chats.message_id = dataResponse['chatsid'];
      if(chats.data_file != null )
        {
          chats.data_file[0].id = dataResponse['filesid'];
        }

      setState(() {
        dataChat.add(chats);
      });

      socket.on('notifyRead', (dataSocket) {
        int indexData = dataChat.indexWhere((dataWhere) => dataWhere.message_id == dataSocket);
        print(indexData);
        if(mounted)
        {
          setState(() {
            dataChat[indexData].is_read = true;
          });
        }
      });
    });
    scrollController.animateTo(
      scrollController.position.maxScrollExtent+Dimens.Level_10,
      duration: Duration(milliseconds: 600),
      curve: Curves.ease,
    );
    _pesanController.text = "";
    setState(() {
      hasAddFile = false;
      dataFile = null;
      fileName = "";
      fileSize = 0;
      fileExt = "";
    });
  }

  Future<void> _attachButtonPressed() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'gif']
    );

    if(await file.exists())
      {
        setState(() {
          hasAddFile = !hasAddFile;
          fileName = path.basename(file.path);
          fileExt = path.extension(file.path);
          fileSize = file.lengthSync();
          dataFile = file;
        });
      }




  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    dataChat = new List<Chats>();
    isTyping = !widget.senderIsOnline;
    statusUser = !isTyping ? "Online" : "Offline";
    _pesanController.addListener(messageOnChange);
    BlocProvider.of<MainBloc>(context).add(
      FetchChat(
          senderId: widget.senderId
      ),
    );

    SocketIoProvider socketIoProvider = new SocketIoProvider();
    socket = socketIoProvider.connectSocketIO();

    socket.on('notifyRead', (dataSocket) {
      int indexData = dataChat.indexWhere((dataWhere) => dataWhere.message_id == dataSocket);
      print(indexData);
      if(mounted)
        {
          setState(() {
            dataChat[indexData].is_read = true;
          });
        }
    });

    socket.on('online', (dataSocket){
      if(mounted)
      {
        setState(() {
          statusUser = "Online";
          isTyping = false;
        });
      }
    });

    socket.on('offline', (dataSocket){
      if(mounted)
      {
        setState(() {
          statusUser = "Offline";
          isTyping = true;
        });
      }
    });



    socket.on("notifyTyping", (_) {
      if(mounted)
        {
          setState(() {
            statusUser = "Typing.....";
            isTyping = true;
          });
        }
    });
    socket.on("notifyStopTyping", (_) {
      if(mounted)
        {
          setState(() {
            statusUser = "Online";
            isTyping = false;
          });
        }
    });

    socket.on('received', (dataSocket) {
      print(json.decode(dataSocket));
      dynamic responseRaw = json.decode(dataSocket);
      Map<String,dynamic> response = responseRaw[0];

      Chats chatModel = Chats.fromJson(response);
      print(chatModel);

      this.setState(() => dataChat.add(chatModel));

      socket.emit('hasRead', { 'message_id': chatModel.message_id});

      Timer(Duration(milliseconds: 500),
              () => scrollController.animateTo(scrollController.position.maxScrollExtent + Dimens.Level_11, duration: Duration(milliseconds: 500), curve: Curves.easeIn));



    });



  }

  messageOnChange()
  {
    if(_pesanController.text.length > 0)
      {
        socket.emit('typing', { 'id':widget.senderId });
      }
    else
      {
        socket.emit('stopTyping', { 'id':widget.senderId });
      }
  }


  void showDialogFile(File file)
  {
    Dialog simpleDialog =  Dialog(
      backgroundColor: AppColors.white,
      child: DialogFile(contexts : context, nama: path.basename(file.path), keterangan: filesize(file.lengthSync())),
    );
    showDialog(context: context, builder: (BuildContext context) => simpleDialog);
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then

    if(widget.previousPage == "user")
      {
        BlocProvider.of<MainBloc>(context).add(
          FetchAllUser(
            filterText: ""
          ),
        );
      }

    if(widget.previousPage == "main")
    {
      BlocProvider.of<MainBloc>(context).add(
        FetchAllChat(
            filterText: ""
        ),
      );
    }

    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;


    return  new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new WillPopScope(
          child: KeyboardAvoider(
            autoScroll: true,
            child: Container(
              child: Container(
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          children: [
                            BlocBuilder<MainBloc, MainState>(
                              builder: (context, state)
                              {
                                if(state is MainLoading)
                                {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: Dimens.Level_40,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                else if(state is MainSuccessChat)
                                {
                                  if(state.chatModel.toJson().isEmpty)
                                  {
                                    return Center(
                                      child: Text('No Chat'),
                                    );
                                  }
                                  else
                                  {
                                    Timer(Duration(milliseconds: 500),
                                            () => scrollController.animateTo(scrollController.position.maxScrollExtent + Dimens.Level_11, duration: Duration(milliseconds: 500), curve: Curves.easeIn));

                                    dataChat = state.chatModel.data;
                                    return Container(
                                      height: MediaQuery.of(context).size.height,
                                      color: AppColors.veryLigthBlue,
                                      padding: EdgeInsets.only(bottom : Dimens.Level_12, top : Dimens.Level_12 + statusBarHeight),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        itemCount: dataChat.length,
                                        itemBuilder: (context, i)
                                        {
                                          if(i == dataChat.length)
                                          {
                                            scrollController.animateTo(
                                              scrollController.position.maxScrollExtent+Dimens.Level_10,
                                              duration: Duration(milliseconds: 600),
                                              curve: Curves.ease,
                                            );
                                          }
                                          print(dataChat[i].message_id);
                                          print(dataChat[i]);
                                          List<Files> dataFile = dataChat[i].data_file;
                                          int countFile = dataFile != null ? dataFile.length : 0;
                                          return Align(
                                            alignment: widget.senderId == dataChat[i].sender ? Alignment.centerLeft : Alignment.centerRight,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.8,
                                              child: CardChat(
                                                  hasFile: countFile > 0 ? true : false,
                                                  namaFile: countFile > 0 ? dataFile[0].name : "",
                                                  IdFile: countFile > 0 ? dataFile[0].id : "",
                                                  hasRead: dataChat[i].is_read == null ? false : dataChat[i].is_read,
                                                  message: dataChat[i].message,
                                                  timesend: formatDate(DateTime.parse(dataChat[i].updatedAt), [d,' ',M,' ',yyyy]),
                                                  isSender: widget.senderId == dataChat[i].sender ? false : true
                                              ),
                                            ),
                                          );

                                        },
                                      ),
                                    );
                                  }
                                }

                                else
                                {
                                  return Container();
                                }

                              },

                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: Dimens.Level_11,
                                color: AppColors.white,
                                margin: EdgeInsets.only(top : statusBarHeight),
                                padding: EdgeInsets.all(Dimens.Level_2),
                                child: Row(
                                  children: [
                                    Wrap(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.keyboard_backspace),
                                          onPressed: (){
                                            Navigator.pop(context);
                                            if(widget.previousPage == "user")
                                            {
                                              BlocProvider.of<MainBloc>(context).add(
                                                FetchAllUser(
                                                    filterText: ""
                                                ),
                                              );
                                            }

                                            if(widget.previousPage == "main")
                                            {
                                              BlocProvider.of<MainBloc>(context).add(
                                                FetchAllChat(
                                                    filterText: ""
                                                ),
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                    Wrap(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: Dimens.Level_2),
                                          child: CircleAvatar(
                                            maxRadius: widget.maxRadiusPhoto,
                                            child: Image.network(
                                                widget.avatarUser,
                                                width: widget.widthPhoto,
                                                height: widget.heightPhoto
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[

                                          Container(
                                            alignment : Alignment.centerLeft,
                                            child: LabelComponent(
                                              label: widget.senderName,
                                            ),
                                          ),
                                          Visibility(
                                            visible: !isTyping,
                                            child: Container(
                                              alignment : Alignment.centerLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: Dimens.Level_1,
                                                    height: Dimens.Level_1,
                                                    decoration: new BoxDecoration(
                                                      color: AppColors.green,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: Dimens.Level_1),
                                                    child: LabelComponent(
                                                      label: statusUser,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isTyping,
                                            child: Container(
                                              alignment : Alignment.centerLeft,
                                              child: LabelComponent(
                                                label: statusUser,
                                                warna: AppColors.redMaincolor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          AnimatedPositioned(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            bottom: !hasAddFile ? Dimens.Level_0 : Dimens.Level_11,
                            child: Container(
                              height: Dimens.Level_11,
                              color: AppColors.white,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(Dimens.Level_2),
                              child: Container(
                                padding: EdgeInsets.all(Dimens.Level_2),
                                decoration: BoxDecoration(
                                  color: AppColors.blueGrey,
                                  borderRadius: new BorderRadius.all(const Radius.circular(Dimens.Level_2)),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: <Widget>[
                                    Wrap(
                                      children: <Widget>[
                                        Container(
                                          child: Icon(Icons.insert_drive_file),
                                          margin: EdgeInsets.only(right: Dimens.Level_half),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: LabelComponent(label: fileName, ukuran: Dimens.Level_2),
                                    ),
                                    Wrap(
                                      children: <Widget>[
                                        Container(
                                          child: IconButton(
                                            icon: Icon(Icons.clear),
                                            onPressed: (){
                                              setState(() {
                                                hasAddFile = false;
                                                dataFile = null;
                                                fileName = "";
                                                fileSize = 0;
                                                fileExt = "";
                                              });
                                            },
                                          ),
                                          margin: EdgeInsets.only(left: Dimens.Level_half),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: Dimens.Level_11,
                                color: AppColors.white,
                                padding: EdgeInsets.all(Dimens.Level_2),
                                child: Row(
                                  children: [
                                    Wrap(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.add), onPressed: _attachButtonPressed,
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: TextFieldComponent(
                                        hint: "Type a message",
                                        maxLine: 3,
                                        warna: AppColors.black,
                                        controller: _pesanController,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),

                            Positioned(
                                bottom: Dimens.Level_6,
                                right: Dimens.Level_2,
                                child: Container(
                                  height: Dimens.Level_10,
                                  width: Dimens.Level_10,
                                  child: FittedBox(
                                    child: FloatingActionButton(
                                      child: Icon(Icons.send, color: AppColors.white, size: Dimens.Level_3),
                                      backgroundColor: AppColors.redMaincolor,
                                      onPressed: () {
                                        if(_pesanController.text != "")
                                          {
                                            _onSendButtonPressed();
                                          }
                                      },
                                    ),
                                  ),
                                )
                            ),


                          ],
                        )

                    )
                  ],
                ),
              ),
            ),
          ),
          onWillPop: _willPopCallback)
    );
  }

}


