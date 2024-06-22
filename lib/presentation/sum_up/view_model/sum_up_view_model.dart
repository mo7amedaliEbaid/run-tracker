import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:run_tracker/domain/entities/activity.dart';
import 'package:run_tracker/domain/entities/location.dart';

import '../../../data/model/request/activity_request.dart';
import '../../../data/repositories/activity_repository_impl.dart';
import '../../../domain/entities/enum/activity_type.dart';
import '../../../main.dart';
import '../../common/location/view_model/location_view_model.dart';
import '../../common/metrics/view_model/metrics_view_model.dart';
import '../../common/timer/viewmodel/timer_view_model.dart';
import 'sum_up_state.dart';

final sumUpViewModel = Provider.autoDispose((ref) {
  return SumUpViewModel(ref);
});

final sumUpViewModelProvider =
    StateNotifierProvider.autoDispose<SumUpViewModel, SumUpState>(
  (ref) => SumUpViewModel(ref),
);

interface class SumUpViewModel extends StateNotifier<SumUpState> {
  late Ref ref;

  SumUpViewModel(this.ref) : super(SumUpState.initial());

  void setType(ActivityType type) {
    state = state.copyWith(type: type);
  }

  void save() {
    state = state.copyWith(isSaving: true);

    final startDatetime = ref.read(timerViewModelProvider).startDatetime;
    final endDatetime = startDatetime.add(Duration(
      hours: ref.read(timerViewModelProvider).hours,
      minutes: ref.read(timerViewModelProvider).minutes,
      seconds: ref.read(timerViewModelProvider).seconds,
    ));

    final locations = ref.read(locationViewModelProvider).savedPositions;

    ref
        .read(activityRepositoryProvider)
        .addActivity(ActivityRequest(
          type: state.type,
          startDatetime: startDatetime,
          endDatetime: endDatetime,
          distance: ref.read(metricsViewModelProvider).distance,
          locations: locations,
        ))
        .then((value) {
      ref.read(timerViewModelProvider.notifier).resetTimer();
      ref.read(locationViewModelProvider.notifier).resetSavedPositions();
      ref.read(metricsViewModelProvider.notifier).reset();
      ref.read(locationViewModelProvider.notifier).startGettingLocation();

      state = state.copyWith(isSaving: false);
      navigatorKey.currentState?.pop();
    });
  }

  getActivity() {
    final startDatetime = ref.read(timerViewModelProvider).startDatetime;
    final endDatetime = startDatetime.add(Duration(
      hours: ref.read(timerViewModelProvider).hours,
      minutes: ref.read(timerViewModelProvider).minutes,
      seconds: ref.read(timerViewModelProvider).seconds,
    ));
    final locations = ref.read(locationViewModelProvider).savedPositions;
    final distance = ref.read(metricsViewModelProvider).distance;
    final speed = ref.read(metricsViewModelProvider).globalSpeed;

    Duration difference = endDatetime.difference(startDatetime);
    double differenceInMilliseconds = difference.inMilliseconds.toDouble();

    return Activity(
        id: '',
        type: state.type,
        startDatetime: startDatetime,
        endDatetime: endDatetime,
        distance: distance,
        speed: speed,
        time: differenceInMilliseconds,
        locations: locations
            .map((l) => Location(
                id: '',
                datetime: l.datetime,
                latitude: l.latitude,
                longitude: l.longitude))
            .toList());
  }
}
