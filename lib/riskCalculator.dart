import 'package:flutter/material.dart';

class RiskCalculator extends StatefulWidget {
  @override
  RiskState createState() => RiskState();
}

class RiskState extends State<RiskCalculator> {
  //The state of the risk as a colour
  static Color red = const Color.fromARGB(255, 255, 0, 0);
  static Color green = const Color.fromARGB(255, 0, 255, 0);
  static Color yellow = Color.fromARGB(255, 238, 255, 0);

  Color _colourState = red;
  String _stringState = "Red";
  int _pageNumber = 0;

  String assessSubmitString = "Next";

  //need a list of metric risks
  List<Metric> metricRisks = [];
  RiskState() {
    //Phase one hardcoded values
    metricRisks.add(Metric.param(
        "The Total Number of Defects",
        "The Number of Defects are well below expected",
        "The number of defects are about where expected",
        "The number of defects is higher than we would expect",
        "The number of defects greatly exceeds expectations"));
    metricRisks.add(Metric.param(
        "Schedule Feasibility",
        "Can be easily completed in the scheduled time",
        "Can be completed within the scheduled time with strict management",
        "Project may be completed within the scheduled time, but will require crunch",
        "The project is unlikely to be completed on time"));
    metricRisks.add(Metric.param(
        "Design Progress",
        "The design is complete",
        "The design is mostly complete with no major problems noted",
        "The design is incomplete and there is one noted major problem with a mitigation strategy",
        "The design is incomplete, has several major problems and no mitigation plan"));
    metricRisks.add(Metric.param(
        "Implementation Progress",
        "The implementation is ahead of schedule",
        "the implementation is on schedule",
        "the implementation is slightly behind schedule",
        "the implementation is far behind schedule"));
    metricRisks.add(Metric.param(
        "Integration Progress",
        "No major integration problems detected",
        "Minor integration problems detected",
        "At least one major integration problem, with a plan to remedy",
        "Multiple major integration problems with no plans to remedy"));
  }

  void calculateState() {
    double totalRisk = 0.0;
    metricRisks.forEach((item) {
      totalRisk += item.getRisk();
    });
    totalRisk = totalRisk / metricRisks.length;
    if (totalRisk < (1 / 3)) {
      _colourState = green;
      _stringState = "Green";
    } else if (totalRisk < (2 / 3)) {
      _colourState = yellow;
      _stringState = "Yellow";
    } else {
      _colourState = red;
      _stringState = "Red";
    }
    setState(() {});
  }

  bool _homePage = true;
  void _sethomePage() {
    setState(() {
      assessSubmitString = "Next";
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        leadingWidth: 600,
        backgroundColor: const Color(0xFF08006A),
        leading: const Text(
          "Project Name",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 48,
          ),
        ),
        title: RichText(
          text: TextSpan(
              text: "Total Risk:",
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 48,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: _stringState,
                    style: TextStyle(
                      color: _colourState,
                      fontSize: 48,
                    ))
              ]),
        ),
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
                                    child: Column(
                                      children: getRiskTitleList(),
                                    ),
                                  ),
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
                                Container(
                                  width: mainWindowWidth * 0.25,
                                  height: appHeight * 0.7 - 5,
                                  child: Column(
                                    children: getRiskColourList(),
                                  ),
                                ),
                              ])),
                        ],
                      ),
                    ),
                    //Assess Page
                    Visibility(
                        visible: !_homePage,
                        child: Column(
                          children: <Widget>[
                            //Header
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(
                                      width: mainWindowWidth * 0.85,
                                      height: mainWindowHeight * 0.1,
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Total Risk:",
                                              style: const TextStyle(
                                                color: Color(0xFF000000),
                                                fontSize: 48,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        metricRisks[_pageNumber]
                                                            .riskColourName,
                                                    style: TextStyle(
                                                        color: metricRisks[
                                                                _pageNumber]
                                                            .riskColour,
                                                        fontSize: 48,
                                                        shadows: const [
                                                          Shadow(
                                                              offset: Offset(
                                                                  -1.5, -1.5),
                                                              color:
                                                                  Colors.black),
                                                          Shadow(
                                                              offset: Offset(
                                                                  1.5, -1.5),
                                                              color:
                                                                  Colors.black),
                                                          Shadow(
                                                              offset: Offset(
                                                                  1.5, 1.5),
                                                              color:
                                                                  Colors.black),
                                                          Shadow(
                                                              offset: Offset(
                                                                  -1.5, 1.5),
                                                              color:
                                                                  Colors.black),
                                                        ]))
                                              ]),
                                        ),
                                      )),
                                  const VerticalDivider(
                                    width: 5,
                                    color: Color(0xFF000000),
                                    thickness: 5,
                                  ),
                                  Container(
                                      width: mainWindowWidth * 0.15 - 5,
                                      height: mainWindowHeight * 0.1,
                                      child: const Center(
                                        child: Text(
                                          "EDIT",
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 52,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            const Divider(
                              height: 5,
                              color: Color(0xFF000000),
                              thickness: 5,
                            ),
                            //Body
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(
                                      width: mainWindowWidth * 0.75,
                                      height: mainWindowHeight * 0.1,
                                      child: const Center(
                                          child: Text(
                                        "Risk Name",
                                        style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 52,
                                        ),
                                      ))),
                                  Container(
                                      width: mainWindowWidth * 0.25,
                                      height: mainWindowHeight * 0.1,
                                      child: const Center(
                                        child: Text(
                                          "Votes",
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 52,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(
                                      width: mainWindowWidth * 0.75,
                                      height: mainWindowHeight * 0.8 - 21,
                                      child: Center(
                                          child: Column(
                                        children: getCurrentPageIndicators(
                                            mainWindowWidth,
                                            mainWindowHeight * 0.8 - 21),
                                      ))),
                                  Container(
                                      width: mainWindowWidth * 0.25,
                                      height: mainWindowHeight * 0.8 - 21,
                                      child: Center(
                                          child: Column(
                                        children: getPageVotes(mainWindowWidth,
                                            mainWindowHeight * 0.8 - 21),
                                      ))),
                                ],
                              ),
                            )
                          ],
                        )),
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
                  key: const Key('AssessButton'),
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
                        onPressed: previousPage,
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
                        onPressed: nextPage,
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue.shade800),
                        ),
                        child: Text(
                          assessSubmitString,
                          style: const TextStyle(
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

  List<Widget> getRiskTitleList() {
    List<Widget> toRet = [];
    metricRisks.forEach((element) {
      toRet.add(Text(
        element.metricName,
        style: const TextStyle(
          color: Color(0xFF000000),
          fontSize: 48,
        ),
      ));
      toRet.add(const Divider(
        height: 2,
        color: Color(0xFF000000),
        thickness: 2,
      ));
    });
    return toRet;
  }

  List<Widget> getRiskColourList() {
    List<Widget> toRet = [];
    metricRisks.forEach((element) {
      toRet.add(Text(
        element.riskColourName,
        style: TextStyle(
          color: element.riskColour,
          fontSize: 48,
        ),
      ));
      toRet.add(const Divider(
        height: 2,
        color: Color(0xFF000000),
        thickness: 2,
      ));
    });
    return toRet;
  }

  void decrementVote(int level) {
    if (level == 0) {
      if (metricRisks[_pageNumber]._noRiskVotes > 0) {
        metricRisks[_pageNumber]._noRiskVotes--;
      }
    } else if (level == 1) {
      if (metricRisks[_pageNumber]._lowRiskVotes > 0) {
        metricRisks[_pageNumber]._lowRiskVotes--;
      }
    } else if (level == 2) {
      if (metricRisks[_pageNumber]._medRiskVotes > 0) {
        metricRisks[_pageNumber]._medRiskVotes--;
      }
    } else if (level == 3) {
      if (metricRisks[_pageNumber]._highRiskVotes > 0) {
        metricRisks[_pageNumber]._highRiskVotes--;
      }
    }
    metricRisks[_pageNumber].calcRisk();
    calculateState();
    setState(() {});
  }

  void incrementVote(int level) {
    if (level == 0) {
      metricRisks[_pageNumber]._noRiskVotes++;
    } else if (level == 1) {
      metricRisks[_pageNumber]._lowRiskVotes++;
    } else if (level == 2) {
      metricRisks[_pageNumber]._medRiskVotes++;
    } else if (level == 3) {
      metricRisks[_pageNumber]._highRiskVotes++;
    }
    metricRisks[_pageNumber].calcRisk();
    calculateState();
    setState(() {});
  }

  List<Widget> getPageVotes(double containerWidth, double containerHeight) {
    List<Widget> toRet = [];
    toRet.add(Container(
      height: containerHeight * 0.25 - 1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => decrementVote(0),
            child: const Text("-"),
          ),
          Text(metricRisks[_pageNumber]._noRiskVotes.toString()),
          TextButton(
            onPressed: () => incrementVote(0),
            child: const Text("+"),
          ),
        ],
      ),
    ));
    toRet.add(const Divider(
      height: 2,
      color: Color(0xFF000000),
      thickness: 2,
    ));
    toRet.add(Container(
      height: containerHeight * 0.25 - 1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => decrementVote(1),
            child: const Text("-"),
          ),
          Text(metricRisks[_pageNumber]._lowRiskVotes.toString()),
          TextButton(
            onPressed: () => incrementVote(1),
            child: const Text("+"),
          ),
        ],
      ),
    ));
    toRet.add(const Divider(
      height: 2,
      color: Color(0xFF000000),
      thickness: 2,
    ));
    toRet.add(Container(
      height: containerHeight * 0.25 - 1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => decrementVote(2),
            child: const Text("-"),
          ),
          Text(metricRisks[_pageNumber]._medRiskVotes.toString()),
          TextButton(
            onPressed: () => incrementVote(2),
            child: const Text("+"),
          ),
        ],
      ),
    ));
    toRet.add(const Divider(
      height: 2,
      color: Color(0xFF000000),
      thickness: 2,
    ));
    toRet.add(Container(
      height: containerHeight * 0.25 - 1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => decrementVote(3),
            child: const Text("-"),
          ),
          Text(metricRisks[_pageNumber]._highRiskVotes.toString()),
          TextButton(
            onPressed: () => incrementVote(3),
            child: const Text("+"),
          ),
        ],
      ),
    ));
    return toRet;
  }

  List<Widget> getCurrentPageIndicators(
      double containerWidth, double containerHeight) {
    List<Widget> toRet = [];
    toRet.add(Container(
      height: containerHeight * 0.25 - 1.5,
      child: FittedBox(
        child: Text(metricRisks[_pageNumber]._noRiskName,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 52,
            )),
      ),
    ));
    toRet.add(Container(
      height: containerHeight * 0.25 - 1.5,
      child: FittedBox(
        child: Text(metricRisks[_pageNumber]._lowRiskName,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 52,
            )),
      ),
    ));
    toRet.add(Container(
      height: containerHeight * 0.25 - 1.5,
      child: FittedBox(
        child: Text(metricRisks[_pageNumber]._medRiskName,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 52,
            )),
      ),
    ));
    toRet.add(Container(
      height: containerHeight * 0.25 - 1.5,
      child: FittedBox(
        child: Text(metricRisks[_pageNumber]._highRiskName,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 52,
            )),
      ),
    ));
    return toRet;
  }

  void nextPage() {
    if (_pageNumber < metricRisks.length - 1) {
      _pageNumber++;
      getCurrentPageIndicators;
      if (_pageNumber == metricRisks.length - 1) {
        assessSubmitString = "Submit";
      } else {
        assessSubmitString = "Next";
      }
      setState(() {});
    } else {
      _homePage = !_homePage;
      _pageNumber = 0;
      setState(() {});
    }
  }

  void previousPage() {
    if (_pageNumber > 0) {
      _pageNumber--;
      getCurrentPageIndicators;
      setState(() {});
    } else {
      _homePage = !_homePage;
      setState(() {});
    }
  }
}

class Metric {
  static Color red = const Color.fromARGB(255, 255, 0, 0);
  static Color green = const Color.fromARGB(255, 0, 255, 0);
  static Color yellow = Color.fromARGB(255, 238, 255, 0);

  Color riskColour = red;
  String riskColourName = "Red";
  double _risk = 1;
  String _noRiskName = "";
  int _noRiskVotes = 0;
  String _lowRiskName = "";
  int _lowRiskVotes = 0;
  String _medRiskName = "";
  int _medRiskVotes = 0;
  String _highRiskName = "";
  int _highRiskVotes = 0;
  String metricName = "Edit this metric!";
  Metric() {}
  Metric.param(String name, String noRisk, String lowRisk, String medRisk,
      String highRisk) {
    metricName = name;
    _noRiskName = noRisk;
    _lowRiskName = lowRisk;
    _medRiskName = medRisk;
    _highRiskName = highRisk;
  }

  void calcRisk() {
    if (_noRiskVotes + _lowRiskVotes + _medRiskVotes + _highRiskVotes <= 0) {
      _risk = 1;
      riskColour = red;
      riskColourName = "Red";
      return;
    }
    _risk = (((1 / 3) * _lowRiskVotes) +
            ((2 / 3) * _medRiskVotes) +
            _highRiskVotes) /
        (_noRiskVotes + _lowRiskVotes + _medRiskVotes + _highRiskVotes);
    if (_risk < (1 / 3)) {
      riskColour = green;
      riskColourName = "Green";
    } else if (_risk < (2 / 3)) {
      riskColour = yellow;
      riskColourName = "Yellow";
    } else {
      riskColour = red;
      riskColourName = "Red";
    }
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
