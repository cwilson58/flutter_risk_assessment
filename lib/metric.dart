import 'package:flutter/material.dart';
class Metric extends StatefulWidget {
    @override
    _MetricState createState()=> _MetricState();

}
class _MetricState extends State<Metric> {
    double _risk = 0.0;
    String? _noRiskName;
    int _noRiskVotes = 0;
    String? _lowRiskName;
    int _lowRiskVotes = 0;
    String? _medRiskName;
    int _medRiskVotes = 0;
    String? _highRiskName;
    int _highRiskVotes = 0;

    void calcRisk(){
        _risk = (0.3333*_lowRiskVotes) + (0.6666*_medRiskVotes) + _highRiskVotes;
        setState(() {});
    }

    double getRisk(){
        return _risk;
    }
}
