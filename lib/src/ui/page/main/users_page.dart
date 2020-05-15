//login_register.dart
import 'package:chattingan/src/bloc/main/main_bloc.dart';
import 'package:chattingan/src/bloc/main/main_event.dart';
import 'package:chattingan/src/bloc/main/main_state.dart';
import 'package:chattingan/src/http/socket_io_provider.dart';
import 'package:chattingan/src/model/sender_model.dart';
import 'package:chattingan/src/model/user_chat_response_model.dart';
import 'package:chattingan/src/model/user_response_model.dart';
import 'package:chattingan/src/route/base_router.dart';
import 'package:chattingan/src/ui/component/molecules/card/card_user.dart';
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

class UsersPage extends StatefulWidget {
  UsersPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  TextEditingController searchController;
  List<Senders> data;
  Socket socket;

  @override
  void initState() {
    super.initState();
    print("dsfdfdfs");
    searchController = new TextEditingController();
    data = new List<Senders>();
    searchController.addListener(searchListener);
    SocketIoProvider socketIoProvider = new SocketIoProvider();
    socket = socketIoProvider.connectSocketIO();

    BlocProvider.of<MainBloc>(context).add(
      FetchAllUser(
          filterText: ""
      ),
    );
    
    socket.on('online', (dataSocket){
      int indexData = data.indexWhere((dataWhere) => dataWhere.id == dataSocket);
      this.setState(() {
        data[indexData].is_online = true;
      });
    });

    socket.on('offline', (dataSocket){
      int indexData = data.indexWhere((dataWhere) => dataWhere.id == dataSocket);
      this.setState(() {
        data[indexData].is_online = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  searchListener() {
    if (searchController.text.length > 0){
      BlocProvider.of<MainBloc>(context).add(
        FetchAllUser(
            filterText: searchController.text
        ),
      );
    }
    else
      {
        BlocProvider.of<MainBloc>(context).add(
          FetchAllUser(
              filterText: ""
          ),
        );
      }
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    searchController.removeListener(searchListener);
    BlocProvider.of<MainBloc>(context).add(
      FetchAllChat(
          filterText: ""
      ),
    );
    return true; // return true if the route to be popped
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(Dimens.Level_1),
          child: LabelComponent(label: "User", ketebalan: FontWeight.bold, ukuran: Dimens.Level_3, warna: AppColors.redMaincolor),
        ),
        elevation: Dimens.Level_0,
      ),
      body: new WillPopScope(
          child: Container(
            color: AppColors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left : Dimens.Level_2, top: Dimens.Level_2, bottom: Dimens.Level_2, right: Dimens.Level_2),
                    child: new SearchBarComponent( ),
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

                        else if(state is MainSuccessUser)
                        {
                          if(state.usersModel.toJson().isEmpty)
                          {
                            return Center(
                              child: Text('No Chat'),
                            );
                          }
                          else
                          {
                            data = state.usersModel.datauser;
                            return Column(
                              children: List.generate(data.length, (index){
                                return GestureDetector(
                                  onTap: (){
                                    Router.navigator.pushNamed(
                                        Router.chatPage,
                                        arguments: chatPageArguments(
                                            senderId: data[index].id,
                                            senderName: data[index].username,
                                          senderIsOnline: data[index].is_online != null ? data[index].is_online : false,
                                          previousPage: "user",
                                        )
                                    );
                                  },
                                  child: Container(
                                    child: CardUser(userName: data[index].username, isOnline: data[index].is_online != null ? data[index].is_online : false),
                                  ),
                                );
                              }),
                            );
                          }
                        }

                        else
                        {
                          return Center(
                            child: Text('No User'),
                          );
                        }

                      },

                    ),
                  ),


                ],
              ),
            ),
          ),
          onWillPop:_willPopCallback
      ),
    );
  }

}


