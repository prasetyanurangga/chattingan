//login_register.dart
import 'dart:convert';

import 'package:chattingan/src/bloc/login_register/login_register_bloc.dart';
import 'package:chattingan/src/bloc/login_register/login_register_event.dart';
import 'package:chattingan/src/bloc/main/main_bloc.dart';
import 'package:chattingan/src/bloc/main/main_event.dart';
import 'package:chattingan/src/bloc/main/main_state.dart';
import 'package:chattingan/src/http/socket_io_provider.dart';
import 'package:chattingan/src/local/model/user_model.dart';
import 'package:chattingan/src/model/chat_model.dart';
import 'package:chattingan/src/model/user_chat_response_model.dart';
import 'package:chattingan/src/repository/authentication/authentication_repository.dart';
import 'package:chattingan/src/route/base_router.dart';
import 'package:chattingan/src/ui/component/molecules/card/card_user_chat.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattingan/src/ui/component/molecules/utils/gridview_image.dart';
import 'package:chattingan/src/ui/component/atoms/label.dart';
import 'package:chattingan/src/ui/component/atoms/search_bar.dart';
import 'dart:async';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {

  TextEditingController searchController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  AuthenticationRepository authenticationRepository = AuthenticationRepository();

  List<Data> dataUserChat;
  String userId = "";

  Socket socket;


  List<String> imagegrid = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQxHU6gm0pIrZMoX0cJlHYP-lVTh0E976jvah6g5LwoEtopI6Cx",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQxHU6gm0pIrZMoX0cJlHYP-lVTh0E976jvah6g5LwoEtopI6Cx",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQxHU6gm0pIrZMoX0cJlHYP-lVTh0E976jvah6g5LwoEtopI6Cx",
  ];

  @override
  void initState() {
    super.initState();
    searchController = new TextEditingController();

    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);



    SocketIoProvider socketIoProvider = new SocketIoProvider();
    socket = socketIoProvider.connectSocketIO();
    searchController.addListener(searchListener);



    dataUserChat = new List<Data>();

    BlocProvider.of<MainBloc>(context).add(
      FetchAllChat(
          filterText: ""
      ),
    );


    socket.on('received', (dataSocket){
      dynamic responseRaw = json.decode(dataSocket);
      print(responseRaw);
      Map<String,dynamic> response_1 = responseRaw[0];
      Map<String,dynamic> response_2 = responseRaw[1];
      Chats chatModel = Chats.fromJson(response_1);
      Data dataModel = Data.fromJson(response_2);
      List<Chats> listChat = new List<Chats>();
      listChat.add(chatModel);
      int indexData = dataUserChat.indexWhere((data) => data.id == dataModel.id);
      if(mounted)
        {
          this.setState(() {
            dataUserChat[indexData].id = chatModel.sender;
            dataUserChat[indexData].chats = listChat;
            dataUserChat[indexData].count = dataModel.count;
          });
        }
      _showNotification(indexData,dataUserChat[indexData].chats[0].data_sender[0].username, dataUserChat[indexData].chats[0].message);
    });









  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }



  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<void> _showNotification(int id, String title, String content) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, icon: "app_icon");
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      content,
      platformChannelSpecifics
    );
  }

  searchListener(){
    if (searchController.text.length > 0) {
      BlocProvider.of<MainBloc>(context).add(
        FetchAllChat(
            filterText: searchController.text
        ),
      );
    }
    else
      {
        BlocProvider.of<MainBloc>(context).add(
          FetchAllChat(
              filterText: ""
          ),
        );
      }
  }




  @override
  Widget build(BuildContext context) {
    socket.on('receive', (dataSocket) {
      print("kirim");
    });
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(Dimens.Level_1),
          child: LabelComponent(label: "Chats", ketebalan: FontWeight.bold, ukuran: Dimens.Level_3, warna: AppColors.redMaincolor),
        ),
        elevation: Dimens.Level_0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: AppColors.redMaincolor),
            onPressed: (){
              BlocProvider.of<LoginRegisterBloc>(context).add(
                LogOutButtonPressed()
              );
            },
          )
        ],
      ),
      floatingActionButton:Container(
          height: Dimens.Level_10,
          width: Dimens.Level_10,
          child: FittedBox(
            child: FloatingActionButton(
              child: Icon(Icons.message, color: AppColors.white, size: Dimens.Level_3),
              backgroundColor: AppColors.redMaincolor,
              onPressed: () {
                Router.navigator.pushNamed(Router.userPage);
                searchController.removeListener(searchListener);
              },
            ),
          ),
      ),
      body: Container(
        color: AppColors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left : Dimens.Level_2, top: Dimens.Level_2, bottom: Dimens.Level_2, right: Dimens.Level_2),
                child: new SearchBarComponent(controller: searchController),
              ),

              Container(
                child: BlocBuilder<MainBloc, MainState>(
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

                    else if(state is MainSuccessUserChat)
                    {
                      if(state.userChatModel.toJson().isEmpty)
                      {
                        return Center(
                          child: Text('No Chat'),
                        );
                      }
                      else
                      {
                        dataUserChat = state.userChatModel.data;
                        return Column(
                          children: List.generate(dataUserChat.length, (index){
                            return GestureDetector(
                              onTap: (){
                                Router.navigator.pushNamed(
                                    Router.chatPage,
                                    arguments: chatPageArguments(
                                        senderId: dataUserChat[index].id,
                                        senderName: dataUserChat[index].chats[0].data_sender[0].username,
                                        senderIsOnline: dataUserChat[index].chats[0].data_sender[0].is_online != null ? dataUserChat[index].chats[0].data_sender[0].is_online : false,
                                        previousPage: "main",
                                    )
                                );
                              },
                              child: Container(
                                child: CardUserChat(
                                  userName: dataUserChat[index].chats[0].data_sender[0].username,
                                  lastChat: dataUserChat[index].chats[0].message,
                                  countChat: dataUserChat[index].count.toString(),
                                  hasRead: dataUserChat[index].count > 0,
                                  lastSeen: formatDate(DateTime.parse(dataUserChat[index].chats[0].updatedAt), [d,' ',M,' ',yyyy]),
                                ),
                              ),
                            );
                          }),
                        );
                      }
                    }

                    else
                    {
                      return Container();
                    }

                  },

                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

}


