import 'package:flutter/material.dart';

class RiskCalculator extends StatefulWidget {
  List<Metric> metricRisks = [];
  @override
  _RiskState createState() => _RiskState(metricRisks);
}

class _RiskState extends State<RiskCalculator> {
  String _colourState = "Red";
  //need a list of metric risks
  List<Metric> metricRisks = [];
  //Takes in all the riskiness of each metric then sets the _colourState
  _RiskState(List<Metric> risks) {
    metricRisks = risks;
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
      _colourState = "GREEN";
    } else if (totalRisk < 0.6666) {
      _colourState = "YELLOW";
    } else {
      _colourState = "RED";
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
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
}
