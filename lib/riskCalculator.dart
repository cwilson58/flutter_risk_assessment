import 'package:flutter/material.dart';

class RiskCalculator extends StatefulWidget {
  @override
  _RiskState createState() => _RiskState();
}

class _RiskState extends State<RiskCalculator> {
  //The state of the risk as a colour
  static Color red = const Color.fromARGB(255, 255, 0, 0);
  static Color green = const Color.fromARGB(255, 0, 255, 0);
  static Color yellow = Color.fromARGB(255, 238, 255, 0);

  Color _colourState = red;
  //need a list of metric risks
  List<Metric> metricRisks = [];
  _RiskState() {
    metricRisks.add(Metric());
  }
  void calculateState() {
    double totalRisk = 0.0;
    int votes = 0;
    metricRisks.forEach((item) => () {
          totalRisk += item.getRisk();
          votes += 1;
        });
    totalRisk = totalRisk / votes;
    if (totalRisk < 0.3333) {
      _colourState = green;
    } else if (totalRisk < 0.6666) {
      _colourState = yellow;
    } else {
      _colourState = red;
    }
    setState(() {});
  }

  bool _homePage = true;
  void _sethomePage() {
    setState(() {
      _homePage = !_homePage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;

    double mainWindowWidth = appWidth * 0.85;
    double mainWindowHeight = appHeight * 0.8;

    return Scaffold(
 
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
                                    child:Text(metricRisks[0].metricName),
                                    //child: RiskCalculator(),
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

class Metric {
  double _risk = 0.0;
  String? _noRiskName;
  int _noRiskVotes = 0;
  String? _lowRiskName;
  int _lowRiskVotes = 0;
  String? _medRiskName;
  int _medRiskVotes = 0;
  String? _highRiskName;
  int _highRiskVotes = 0;
  String metricName = "Edit this metric!";
  Metric() {}

  void calcRisk() {
    _risk = (((1 / 3) * _lowRiskVotes) +
            ((2 / 3) * _medRiskVotes) +
            _highRiskVotes) /
        (_noRiskVotes + _lowRiskVotes + _medRiskVotes + _highRiskVotes);
  }

  double getRisk() {
    return _risk;
  }

  void setNoRisk(int votes) {
    _noRiskVotes = votes;
  }

  void setLowRisk(int votes) {
    _lowRiskVotes = votes;
  }

  void setMedRisk(int votes) {
    _medRiskVotes = votes;
  }

  void setHighRisk(int votes) {
    _highRiskVotes = votes;
  }

  void setNoRiskName(String name) {
    _noRiskName = name;
  }

  void setLowRiskName(String name) {
    _lowRiskName = name;
  }

  void setMedRiskName(String name) {
    _medRiskName = name;
  }

  void setHighRiskName(String name) {
    _highRiskName = name;
  }
}
