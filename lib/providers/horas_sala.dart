import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeProvider extends StateNotifier<TimeSelection> {
  TimeProvider()
      : super(
            TimeSelection(startTime: DateTime.now(), endTime: DateTime.now()));

  void updateStartTime(DateTime time) {
    state = state.copyWith(startTime: time);
  }

  void updateEndTime(DateTime time) {
    state = state.copyWith(endTime: time);
  }
}

class TimeSelection {
  final DateTime startTime;
  final DateTime endTime;

  TimeSelection({required this.startTime, required this.endTime});

  TimeSelection copyWith({DateTime? startTime, DateTime? endTime}) {
    return TimeSelection(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

final timeProvider = StateNotifierProvider<TimeProvider, TimeSelection>((ref) {
  return TimeProvider();
});
