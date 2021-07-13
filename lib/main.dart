import 'package:flutter/material.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';

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
  List<Color> colors = [
    Color(0xff124533),
    Color(0xffff4533),
    Color(0xff12ff33),
    Color(0xff120ff3),
    Color(0xff12ffff),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: TinderSwapCard(
          maxWidth: MediaQuery.of(context).size.width - 25 - 23,
          maxHeight: MediaQuery.of(context).size.height - 16 - 28,
          minWidth: MediaQuery.of(context).size.width - 25 - 25,
          minHeight: MediaQuery.of(context).size.height - 16 - 30,
          cardController: CardController(),
          allowVerticalMovement: false,
          animDuration: 600,
          stackNum: 2,
          totalNum: colors.length,
          orientation: AmassOrientation.bottom,
          swipeEdgeVertical: 4,
          swipeEdge: 4,
          cardBuilder: (context, index) {
            return Container(
              color: colors[index],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.plus_one_outlined),
      ),
    );
  }
}
