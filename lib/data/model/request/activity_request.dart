import 'package:equatable/equatable.dart';

import '../../../domain/entities/enum/activity_type.dart';
import 'location_request.dart';

interface class ActivityRequest extends Equatable {
  final String? id;
  final ActivityType type;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final double distance;
  final List<LocationRequest> locations;

  const ActivityRequest({
    this.id,
    required this.type,
    required this.startDatetime,
    required this.endDatetime,
    required this.distance,
    required this.locations,
  });

  @override
  List<Object?> get props =>
      [id, type, startDatetime, endDatetime, distance, locations];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.toString().split('.').last.toUpperCase(),
      'startDatetime': startDatetime.toIso8601String(),
      'endDatetime': endDatetime.toIso8601String(),
      'distance': distance,
      'locations': locations.map((location) => location.toMap()).toList(),
    };
  }

  @override
  bool get stringify => true;
}
