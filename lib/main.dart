import 'package:flutter/material.dart';
import 'riskCalculator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metrics Calculator',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFF515151)),
      home: const MyHomePage(title: 'Project Name'),
    );
  }
}

//TO DO: SET WINDOW MAX WIDTH TO 1000

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _homePage = true;

  void _sethomePage() {
    setState(() {
      _homePage = !_homePage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;

    double mainWindowWidth = appWidth * 0.85;
    double mainWindowHeight = appHeight * 0.8;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        leadingWidth: 600,
        leading: Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 48,
          ),
        ),
        title: Row(
          children: const <Widget>[
            Text(
              "Total Risk:",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 32,
              ),
            ),
            Text(
              "Green",
              style: TextStyle(
                color: Color(0xFF01B100),
                fontSize: 32,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF08006A),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: mainWindowWidth,
                height: mainWindowHeight,
                margin: const EdgeInsets.only(bottom: 20),
                decoration:
                    const BoxDecoration(color: Color(0xFFD9D9D9), boxShadow: [
                  BoxShadow(
                      color: Color(0xFF222222),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(0, 3))
                ]),
                child: Stack(
                  children: <Widget>[
                    //Index page
                    Visibility(
                      visible: _homePage,
                      child: Row(
                        children: <Widget>[
                          //Left Column
                          Container(
                              width: mainWindowWidth * 0.75,
                              height: mainWindowHeight,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      width: mainWindowWidth * 0.75,
                                      height: appHeight * 0.1,
                                      child: const Center(
                                        child: Text(
                                          "Metric Description",
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 64,
                                          ),
                                        ),
                                      )),
                                  const Divider(
                                    height: 5,
                                    color: Color(0xFF000000),
                                    thickness: 5,
                                  ),
                                  //left column data
                                  Container(
                                    width: mainWindowWidth * 0.75,
                                    height: appHeight * 0.7 - 5,
                                    child: RiskCalculator(),
                                  )
                                ],
                              )),
                          const VerticalDivider(
                            width: 5,
                            color: Color(0xFF000000),
                            thickness: 5,
                          ),
                          //Right Column
                          Container(
                              width: mainWindowWidth * 0.25 - 5,
                              height: mainWindowHeight,
                              child: Column(children: <Widget>[
                                Container(
                                    width: mainWindowWidth * 0.25,
                                    height: appHeight * 0.1,
                                    child: const Center(
                                      child: Text(
                                        "COLOUR",
                                        style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 52,
                                        ),
                                      ),
                                    )),
                                const Divider(
                                  height: 5,
                                  color: Color(0xFF000000),
                                  thickness: 5,
                                ),
                              ])),
                        ],
                      ),
                    ),
                    Visibility(visible: !_homePage, child: Text("Hello"))
                  ],
                )),
            Visibility(
              visible: _homePage,
              child: SizedBox(
                width: appWidth * 0.2,
                height: 50,
                child: TextButton(
                  onPressed: _sethomePage,
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade800),
                  ),
                  child: const Text(
                    "Assess",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
                visible: !_homePage,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: appWidth * 0.2,
                      height: 50,
                      child: TextButton(
                        onPressed: _sethomePage,
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue.shade800),
                        ),
                        child: const Text(
                          "Previous",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: appWidth * 0.2,
                      height: 50,
                      child: TextButton(
                        onPressed: _sethomePage,
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue.shade800),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
