import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: SpinKitPulse(
          color: Theme.of(context).colorScheme.primary,
          size: 50,
        ),
      ),
    );
  }
}
