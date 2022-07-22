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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      child: Text(metricRisks[0].metricName),
    ));
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
