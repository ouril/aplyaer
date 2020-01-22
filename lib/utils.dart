import 'package:flutter/material.dart';

import 'exceptions.dart';

class APlayerUtils {
  static bool isCoordinateInRect(
      Offset coordinate, Offset rectCoordinate, Size rectSize) {
    return coordinate.dx >= rectCoordinate.dx &&
        coordinate.dx <= (rectCoordinate.dx + rectSize.width) &&
        coordinate.dy >= rectCoordinate.dy &&
        coordinate.dy <= (rectCoordinate.dy + rectSize.height);
  }

  static double getPosition(Offset coordinate, Offset rectCoordinate, Size rectSize) {
      if(isCoordinateInRect(coordinate, rectCoordinate, rectSize)){
          return (coordinate.dx - rectCoordinate.dx)/rectSize.width;
      }
      else throw APlayerException("Bad sizes for get position!");
  }
}
