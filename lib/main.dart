import 'package:flutter/material.dart';

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
      home: MyHomePage(title: 'mht_com_task2(A画面)'),
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
  String displayATextA = "Everything is a Widget";
  String displayATextB = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayATextA,
              style: TextStyle(fontSize: 30),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 30.0),
            ),
            Text("上記の文字は画面Bに引き継がれます"),
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 100.0),
            ),
            Text(
              displayATextB,
              style: TextStyle(fontSize: 25),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 30.0),
            ),
            Text("上記の文字は画面B=>画面Aに引き継がれたワードです")
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NextPage(displayATextA),
            )
          );
          displayATextB = result;
          print(result);
          showDialog(
            context: context,
            builder: (context){
              return SimpleDialog(
                children: <Widget>[
                  SimpleDialogOption(
                    onPressed: () => Navigator.pop(context),
                    child: Text(displayATextB),
                  )
                ],
              );
            }
          );
        },
        tooltip: 'Increment',
        child: Text('次へ'),
      )
    );
  }
}

class NextPage extends StatelessWidget {
  NextPage(this.displayTextA);
  final String displayTextA;
  // TextEditingControllerは文章をバインドするDartAPI
  final myController = TextEditingController();
  String displayATextB = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("mht_com_task2(B画面)"),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              displayTextA,
              style: TextStyle(fontSize: 30),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 30.0),
            ),
            Text("上記の文字は画面Aから引き継がれた文字です"),
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 100.0),
            ),
            // Text(
            //   displayATextB,
            //   style: TextStyle(fontSize: 25),
            // ),
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 30.0),
            ),
            Container(
              width: 350.0,
              child:TextField(
                cursorWidth: 60.0,
                style: new TextStyle(
                  fontSize: 20.0,
                ),
                controller: myController,
                decoration: InputDecoration(
                  hintText: 'ここに文字を入力',
                ),
                onChanged: (text) {
                  displayATextB = text;
                },
              ) ,
            ),
            Text("上記の入力されたテキストフィールドは"),
            Text("画面B=>画面Aに引き継がれるテキストです")
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop(displayATextB);
          },
          child: Text('戻る'),
        ));
  }
}