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
        leading: const Text(
          "Project Name",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 48,
          ),
        ),
        title: RichText(
          text: const TextSpan(
              text: "Total Risk:",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 48,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: "Green",
                    style: TextStyle(
                      color: Color(0xFF01B100),
                      fontSize: 48,
                    ))
              ]),
        ),
        backgroundColor: const Color(0xFF08006A),
      ),
      body:Container(
        child: RiskCalculator())
    );
  }
}
