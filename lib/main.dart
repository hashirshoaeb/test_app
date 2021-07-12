import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onTap() async {
    final ScreenshotController controller = ScreenshotController();
    final image1 = await controller.captureFromWidget(
      screen,
      delay: const Duration(microseconds: 60),
      pixelRatio: 4,
    );

    final file1Path = '${(await getTemporaryDirectory()).path}/meetup_details1.jpg';
    print('File path is: $file1Path');
    final file1 = await File(file1Path).create(recursive: true);
    await file1.writeAsBytes(image1);
  }

  final Widget screen = Container(
    width: 100,
    height: 100,
    color: Colors.red,
    child: Text('HIII'),
  );

  @override
  Widget build(BuildContext context) {
    print('physical size ${ui.window.physicalSize}');
    print('pixel ratio ${ui.window.devicePixelRatio}');
    Size logicalSize = ui.window.physicalSize / ui.window.devicePixelRatio;
    Size imageSize = ui.window.physicalSize;
    print('wah: ${imageSize.width / logicalSize.width}');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: onTap,
        child: Icon(Icons.plus_one_outlined),
      ),
    );
  }
}
