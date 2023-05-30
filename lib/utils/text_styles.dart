import 'package:flutter/material.dart';

largeTitleBold(BuildContext context) => TextStyle(
  fontSize: 64.0,
  color: Theme.of(context).colorScheme.onBackground,
  fontWeight: FontWeight.bold,
  height: 1.2,
);

title100(BuildContext context) => TextStyle(
  fontSize: 32.0,
  color: Theme.of(context).colorScheme.onBackground,
  fontWeight: FontWeight.w100,
  height: 1.2,
);

body(BuildContext context) => TextStyle(
  fontSize: 20.0,
  color: Theme.of(context).colorScheme.onBackground,
  fontWeight: FontWeight.normal,
  height: 1.2,
);

caption(BuildContext context, double opacity) => TextStyle(
  fontSize: 16.0,
  color: Theme.of(context).colorScheme.onBackground.withOpacity(opacity),
  fontWeight: FontWeight.normal,
  height: 1.2,
);

caption1(BuildContext context, double opacity) => TextStyle(
  fontSize: 14.0,
  color: Theme.of(context).colorScheme.onBackground.withOpacity(opacity),
  fontWeight: FontWeight.normal,
  height: 1.2,
);

caption2(BuildContext context, double opacity) => TextStyle(
  fontSize: 12.0,
  color: Theme.of(context).colorScheme.onBackground.withOpacity(opacity),
  fontWeight: FontWeight.normal,
  height: 1.2,
);

caption3(BuildContext context, double opacity) => TextStyle(
  fontSize: 10.0,
  color: Theme.of(context).colorScheme.onBackground.withOpacity(opacity),
  fontWeight: FontWeight.normal,
  height: 1.2,
);