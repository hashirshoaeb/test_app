import 'package:flutter/material.dart';
import 'package:gleap_sdk/gleap_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Gleap.initialize(token: '');
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
      home: AsyncDataExampleHomePage(),
    );
  }
}

// support for asynchronous data events
class AsyncDataExampleHomePage extends StatefulWidget {
  @override
  _AsyncDataExampleHomePageState createState() => _AsyncDataExampleHomePageState();
}

class _AsyncDataExampleHomePageState extends State<AsyncDataExampleHomePage> {
  @override
  initState() {
    super.initState();
  }

  Future<void> _addToStream() async {
    await Gleap.open();
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
}
