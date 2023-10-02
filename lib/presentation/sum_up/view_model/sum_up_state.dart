import 'package:flutter/cupertino.dart';

import '../../../domain/entities/enum/activity_type.dart';

interface class SumUpState {
  final bool isSaving;
  final ActivityType type;
  final GlobalKey boundaryKey;

  const SumUpState(
      {required this.type, required this.isSaving, required this.boundaryKey});

  factory SumUpState.initial() {
    return SumUpState(
        isSaving: false, type: ActivityType.running, boundaryKey: GlobalKey());
  }

  SumUpState copyWith({
    bool? isSaving,
    ActivityType? type,
  }) {
    return SumUpState(
        isSaving: isSaving ?? this.isSaving,
        type: type ?? this.type,
        boundaryKey: boundaryKey);
  }
}
