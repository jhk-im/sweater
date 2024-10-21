import 'package:flutter/material.dart';
import 'package:sweater/utils/images.dart';
import 'package:sweater/utils/text_styles.dart';
import 'package:sweater/viewmodel/weather_main_state.dart';

class MainGridViewWidget extends StatelessWidget {
  const MainGridViewWidget({
    super.key,
    required this.state,
  });

  final WeatherMainState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 행의 개수
          childAspectRatio: 1 / 1, // 가로세로 비율
          mainAxisSpacing: 8.0, // 수평 padding
          crossAxisSpacing: 8.0, // 수직 padding
        ),
        itemBuilder: (BuildContext context, int index) {
          return createCard(index, context);
        },
      ),
    );
  }

  Card createCard(int index, BuildContext context) {
    switch (index) {
      case 0:
        return Card(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '미세먼지',
                  style: caption(context, 1.0),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  state.fineDustList.isNotEmpty
                      ? '${state.fineDustList[0].pm10Value24 ?? ''}μg/m3'
                      : '',
                  style: caption(context, 0.5),
                ),
              ],
            ),
          ),
        );
      case 1:
        return Card(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '초미세먼지',
                  style: caption(context, 1.0),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  state.fineDustList.isNotEmpty
                      ? '${state.fineDustList[0].pm25Value24 ?? ''}μg/m3'
                      : '',
                  style: caption(context, 0.5),
                ),
              ],
            ),
          ),
        );
      case 2:
        return Card(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pngIcon(
                    'sad_sunny.png', Theme.of(context).colorScheme.onSurface,
                    width: 32, height: 32),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '자외선지수',
                  style: caption(context, 1.0),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  state.ultraviolet != null ? state.ultraviolet?.h0 ?? '' : '',
                  style: caption(context, 0.5),
                ),
              ],
            ),
          ),
        );
      case 3:
        return Card(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.water_drop,
                  size: 32.0,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '습도',
                  style: caption(context, 1.0),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  state.ultraShortTerm.isNotEmpty
                      ? '${state.ultraShortTerm.where((element) => element.category == 'REH').toList()[0].obsrValue}%'
                      : '',
                  style: caption(context, 0.5),
                ),
              ],
            ),
          ),
        );
      case 4:
        return Card(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pngIcon('windy.png', Theme.of(context).colorScheme.onSurface,
                    width: 32, height: 32),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '바람',
                  style: caption(context, 1.0),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  state.ultraShortTerm.isNotEmpty
                      ? '${state.ultraShortTerm.where((element) => element.category == 'WSD').toList()[0].obsrValue}m/s'
                      : '',
                  style: caption(context, 0.5),
                ),
              ],
            ),
          ),
        );
    }
    // 일출 일몰
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pngIcon('sunrise.png', Theme.of(context).colorScheme.onSurface,
                    width: 32, height: 32),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  state.riseSet != null
                      ? '${int.parse(state.riseSet?.sunrise?.substring(0, 2) ?? '0')}:${state.riseSet?.sunrise?.substring(2, 4)}'
                      : '',
                  style: caption(context, 0.5),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pngIcon('sunset.png', Theme.of(context).colorScheme.onSurface,
                    width: 32, height: 32),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  state.riseSet != null
                      ? '${int.parse(state.riseSet?.sunset?.substring(0, 2) ?? '0')}:${state.riseSet?.sunset?.substring(2, 4)}'
                      : '',
                  style: caption(context, 0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
