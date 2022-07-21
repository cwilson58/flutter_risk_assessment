import 'package:flutter/material.dart';
class RiskCalculator extends StatefulWidget {
    @override
    _RiskState createState()=> _RiskState();

}
class _RiskState extends State<RiskCalculator> {
    String _colourState = "Red";
    //need a list of metrics, own widget?
    
    //Takes in all the riskiness of each metric then sets the _colourState
    void calculateState(){
        double riskiness = (0.3333*_yellowVotes) + (0.6666*_orangeVotes) + _redVotes;
        if(riskiness < 0.3333)
            _colourState = "Green";
        else if(riskiness < 0.6666)
            _colourState = "Yellow";
        else
            _colourState = "Red";
    }
}