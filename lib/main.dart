import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AsyncDataExampleHomePage(),
    );
  }
}

// support for asynchronous data events
class AsyncDataExampleHomePage extends StatefulWidget {
  @override
  _AsyncDataExampleHomePageState createState() => _AsyncDataExampleHomePageState();
}

class _AsyncDataExampleHomePageState extends State<AsyncDataExampleHomePage>
    with TickerProviderStateMixin {
  late StreamController<List<Color>> _streamController;

  List<Color> welcomeImages = [
    Colors.black,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  initState() {
    super.initState();
    _streamController = StreamController<List<Color>>();
  }

  void _addToStream() {
    welcomeImages.add(Colors.pink);
    welcomeImages.removeAt(0);
    _streamController.add(welcomeImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("asynchronous data events test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Added image appears on top:',
            ),
            StreamBuilder<List<Color>>(
              stream: _streamController.stream,
              initialData: welcomeImages,
              builder: (BuildContext context, AsyncSnapshot<List<Color>> snapshot) {
                print('snapshot.data.length: ${snapshot.data?.length}');
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('Add image');
                  case ConnectionState.waiting:
                  //return Text('Awaiting images...');
                  case ConnectionState.active:
                    print("build active");
                    return _AsyncDataExample(context, snapshot.data!);
                  case ConnectionState.done:
                    return Text('\$${snapshot.data} (closed)');
                }
                // unreachable
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToStream,
        tooltip: 'Add image',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _AsyncDataExample(BuildContext context, List<Color> imageList) {
    CardController controller; //Use this to trigger swap.
    print(imageList.length);
    return Center(
      key: UniqueKey(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: TinderSwapCard(
          orientation: AmassOrientation.top,
          totalNum: imageList.length,
          stackNum: 3,
          swipeEdge: 4.0,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.width * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: MediaQuery.of(context).size.width * 0.8,
          cardBuilder: (context, index) {
            print("cardbuilder ${index}");
            print("imageList length ${imageList.length}");
            return Card(
              color: imageList[index],
            );
          },
          cardController: controller = CardController(),
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            /// Get swiping card's alignment
            if (align.x < 0) {
              //Card is LEFT swiping
            } else if (align.x > 0) {
              //Card is RIGHT swiping
            }
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            if (orientation == CardSwipeOrientation.left) _addToStream();

            /// Get orientation & index of swiped card!
          },
        ),
      ),
    );
  }
}
