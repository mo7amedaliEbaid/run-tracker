import 'package:equatable/equatable.dart';

interface class LocationRequest extends Equatable {
  final String? id;
  final DateTime datetime;
  final double latitude;
  final double longitude;

  const LocationRequest({
    this.id,
    required this.datetime,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [datetime, latitude, longitude];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'datetime': datetime.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  bool get stringify => true;
}
