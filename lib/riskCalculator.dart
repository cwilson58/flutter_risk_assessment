import 'package:flutter/material.dart';
class RiskCalculator extends StatefulWidget {
    List<double> metricRisks = List<double>();
    @override
    _RiskState createState()=> _RiskState(metricRisks);
    
}
class _RiskState extends State<RiskCalculator> {
    String _colourState = "Red";
    //need a list of metric risks
    List<double> metricRisks = List<double>();
    //Takes in all the riskiness of each metric then sets the _colourState
    _RiskState(List<double> risks){
        metricRisks = risks;
    }
    void calculateState(){
        double totalRisk = 0.0;
        int votes = 0;
        metricRisks.forEach((item) => (){
            totalRisk += item;
            votes += 1;
        });
        totalRisk = totalRisk/votes;
        if(totalRisk < 0.3333)
            _colourState = "GREEN";
        else if(totalRisk < 0.6666)
            _colourState = "YELLOW";
        else    
            _colourState = "RED";
    }
}