class OpeningHoursModel {
  final String startTime;
  final String endTime;
  final String selectedDay;

  OpeningHoursModel({
    required this.startTime,
    required this.endTime,
    required this.selectedDay,
  });

  // Factory constructor to create an instance from a JSON Map
  factory OpeningHoursModel.fromJson(Map<String, dynamic> json) {
    return OpeningHoursModel(
      startTime: json['opening_time'],
      endTime: json['closing_time'],
      selectedDay: json['day'],
    );
  }

  // Method to convert the instance to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'selectedDay': selectedDay,
    };
  }
}
