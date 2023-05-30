import 'package:flutter/material.dart';

cloudy(BuildContext context) => Image.asset(
  'assets/images/cloudy.png',
  color: Theme.of(context).colorScheme.onBackground,
);

sunny(BuildContext context) => Image.asset(
  'assets/images/sunny.png',
  color: Theme.of(context).colorScheme.onBackground,
);

pngIcon(String fileName, Color color, {double width = 24, double height = 24}) => Image.asset(
  'assets/images/$fileName',
  color: color,
  width: width,
  height: height,
);