//login_register.dart
import 'package:chattingan/src/model/file_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:chattingan/src/model/user_chat_response_model.dart';
import 'package:chattingan/src/route/base_router.dart';
import 'package:chattingan/src/ui/component/atoms/label.dart';

class GridViewImage extends StatefulWidget {

  List<Files> data_images;
  String judul;

  GridViewImage({@required this.data_images, @required this.judul});


  @override
  _GridViewImageState createState() => _GridViewImageState();
}

class _GridViewImageState extends State<GridViewImage> {



  @override
  void initState() {
    super.initState();
  }

//  Widget ImageGridView()
//  {
//    if(widget.data_images.length > 1 && widget.data_images.length < 5)
//      {
//        return Container(
//            child:  Row(
//              children: <Widget>[
//                Expanded(
//                  child: Container(
//                    margin: EdgeInsets.only(right: Dimens.Level_half),
//                    height: Dimens.Level_20,
//                    child: Image.network(widget.data_images[0].url, fit: BoxFit.fitHeight),
//                  ),
//                ),
//                Expanded(
//                    child: Container(
//
//                      height: Dimens.Level_20,
//                      child: Stack(
//                        children: <Widget>[
//                          Container(
//                            height: Dimens.Level_20,
//                            child: Image.network(widget.data_images[1].url, fit: BoxFit.fitHeight),
//                          ),
//                          Align(
//                            alignment: Alignment.center,
//                            child: widget.data_images.length == 2 ? Container() : GestureDetector(
//                              onTap: (){
//                                Router.navigator.pushNamed(
//                                    Router.detailGridImagePage,
//                                    arguments: DetailGridImagePageArguments(
//                                        title: widget.judul,
//                                        data: widget.data_images,
//                                        count: widget.data_images.length
//                                    )
//                                );
//                              },
//                              child: LabelComponent(
//                                  label: (widget.data_images.length - 2).toString()+'+',
//                                  ukuran: Dimens.Level_4,
//                                  warna: AppColors.Putih
//                              ),
//                            ),
//                          )
//                        ],
//                      ),
//                    )
//                ),
//              ],
//            ),
//        );
//
//      }
//    else if(widget.data_images.length == 1)
//      {
//        return Image.network(widget.data_images[0].url);
//      }
//    else
//      {
//        List<Files> mini_images = widget.data_images.sublist(1,5);
//        print(mini_images);
//        return Row(
//          children: [
//            Expanded(
//              child: Container(
//                height: Dimens.Level_20,
//                child: Image.network(widget.data_images[0].url, fit: BoxFit.fitHeight),
//              ),
//            ),
//            Expanded(
//              child: Container(),
////              child: Container(
////                alignment: Alignment.center,
////                child: Column(
////                  children: [
////                    Row(
////                      children: <Widget>[
////                        Expanded(
////                          child: Container(
////                            height: Dimens.Level_10,
////                            child: Image.network(mini_images[0].url, fit: BoxFit.fitHeight),
////                          ),
////                        ),
////                        Expanded(
////                          child: Container(
////                            height: Dimens.Level_10,
////                            child: Image.network(mini_images[1].url, fit: BoxFit.fitHeight),
////                          ),
////                        ),
////                      ],
////                    ),
////                    Row(
////                      children: <Widget>[
////                        Expanded(
////                          child: Container(
////                            height: Dimens.Level_10,
////                            child: Image.network(mini_images[2].url, fit: BoxFit.fitHeight),
////                          ),
////                        ),
////                        Expanded(
////                          child: Container(
////
////                            height: Dimens.Level_10,
////                            child: Stack(
////                              children: <Widget>[
////                                Container(
////                                  height: Dimens.Level_10,
////                                  child: Image.network(mini_images[3].url, fit: BoxFit.fitHeight),
////                                ),
////                                Align(
////                                  alignment: Alignment.center,
////                                  child: GestureDetector(
////                                    onTap: (){
////                                      Router.navigator.pushNamed(
////                                          Router.detailGridImagePage,
////                                          arguments: DetailGridImagePageArguments(
////                                            title: widget.judul,
////                                            data: widget.data_images,
////                                            count: widget.data_images.length
////                                          )
////                                      );
////                                    },
////                                    child: LabelComponent(
////                                        label: (widget.data_images.length - 5).toString()+'+',
////                                        ukuran: Dimens.Level_4,
////                                        warna: AppColors.Putih
////                                    ),
////                                  ),
////                                )
////                              ],
////                            ),
////                          )
////                        ),
////                      ],
////                    ),
////                  ],
////                ),
////              ),
//            )
//          ],
//        );
//      }
//  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
