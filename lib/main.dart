import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '拍照示例'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 需要导入 dart:io 库
    /// import 'dart:io';
    File _image;

    final picker = ImagePicker();

    /*Future getImage() async {

      final pickedFile = await picker.getImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }*/

    /// 获取摄像头图像的方法
    Future getImageFromCamera() async {
      /// 菜单按钮消失
      //Navigator.pop(context);

      /// 需要导入 image_picker.dart 包
      /// import 'package:image_picker/image_picker.dart';
      final pickedFile =
          await ImagePicker.pickImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    /// 获取相册中的图像
    Future getImageFromGallery() async {
      /// 菜单按钮消失
      //Navigator.pop(context);

      /// 需要导入 image_picker.dart 包
      /// import 'package:image_picker/image_picker.dart';
      final pickedFile =
      await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    /*Future<void> retrieveLostData() async {
      final LostData response =
      await picker.getLostData();
      if (response.isEmpty) {
        return;
      }
      if (response.file != null) {
        setState(() {
          if (response.type == RetrieveType.video) {
            _handleVideo(response.file);
          } else {
            _handleImage(response.file);
          }
        });
      } else {
        _handleError(response.exception);
      }
    }*/


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// 浮动按钮点击事件
          /// 点击浮动按钮 , 弹出一个菜单
          /// 菜单有两个按钮 , 分别是 拍照 / 选择图片
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  // 设置该弹出的组件高度 200 像素
                  height: 200,
                  child: Column(
                    children: <Widget>[
                      // 拍照按钮
                      GestureDetector(
                        child: ListTile(
                          // 相机图标
                          leading: Icon(Icons.camera_alt),
                          title: Text("拍照"),
                          /// 按钮点击事件
                          onTap: (){
                            // 调用 getImage 方法 , 调出相机拍照
                            getImageFromCamera();
                          },
                        ),
                      ),

                      // 相册按钮
                      GestureDetector(
                        child: ListTile(
                          // 相册图标
                          leading: Icon(Icons.photo_library_outlined),
                          title: Text("相册"),
                          /// 按钮点击事件
                          onTap: (){
                            // 调用 getImageFromGallery 方法 , 调出相册
                            getImageFromGallery();

                          },
                        ),
                      ),

                    ],
                  ),
                );
              });
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
