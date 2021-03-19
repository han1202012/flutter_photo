import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  /// 需要导入 dart:io 库
  /// import 'dart:io';
  File _image;

  /// 存放获取的图片集合, 初始化时为空
  List<File> _images = [];

  // 图片获取引擎
  final picker = ImagePicker();

  /// 获取摄像头图像的方法
  Future getImageFromCamera() async {
    /// 菜单按钮消失
    Navigator.pop(context);

    /// 需要导入 image_picker.dart 包
    /// import 'package:image_picker/image_picker.dart';
    final pickedFile =
    await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        //_image = File(pickedFile.path);
        /// 添加到图片文件集合中
        _images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  /// 获取相册中的图像
  Future getImageFromGallery() async {
    /// 菜单按钮消失
    Navigator.pop(context);

    /// 需要导入 image_picker.dart 包
    /// import 'package:image_picker/image_picker.dart';
    final pickedFile =
    await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        //_image = File(pickedFile.path);
        /// 添加到图片文件集合中
        _images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children:


          // 遍历 从相册选择的照片 或 相机拍摄的照片
          _images.map((file){
            // 每个照片都生成一个帧布局
            // 照片填充整个布局, 右上角放置一个关闭按钮
            return Stack(
              children: <Widget>[

                // 设置底部的大图片
                ClipRRect(
                  // 设置圆角半径 5 像素
                  borderRadius: BorderRadius.circular(5),
                  // 设置图片
                  child: Image.file(file, width: 120, height: 90, fit: BoxFit.fill,),
                ),

                // 设置右上角的关闭按钮
                Positioned(
                  // 距离右侧 5
                  right: 5,
                  // 距离顶部 5
                  top: 5,

                  // 手势检测器组件
                  child: GestureDetector(
                    // 点击事件
                    onTap: (){
                      setState(() {
                        // 从图片集合中移除该图片
                        _images.remove(file);
                      });
                    },

                    // 右上角的删除按钮
                    child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.all(3),

                        // 背景装饰
                        decoration: BoxDecoration(color: Colors.black),

                        // 图标, 20 像素 , 白色 , 关闭按钮
                        child: Icon(Icons.close, size: 20, color: Colors.white,),
                      ),
                    ),

                  ),
                )

              ],
            );

            /// 注意这里要转为 List 类型 , <Widget>[]
          }).toList()


          ,

        )
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

  _generateImageWidgets() {


  }
}
