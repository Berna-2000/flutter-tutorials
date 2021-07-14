import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SizeConfig{
  static double _screenWidth = 0.0;
  static double _screenHeight = 0.0;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;

  static double textMultiplier = 0.0;
  static double imageSizeMultiplier = 0.0;
  static double heightMultiplier = 0.0;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;


  void init(BoxConstraints constraints, Orientation orientation){
    if (orientation == Orientation.portrait){
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
    }else{
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
    }
    _blockSizeHorizontal = _screenWidth/100;
    _blockSizeVertical = _screenHeight/100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
  
  }

}