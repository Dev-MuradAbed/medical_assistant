class ResultModel {
  String? date;
  String? minuteTime;
  String? hourTime;
  int? bpm;

  ResultModel({
    this.date,
    this.minuteTime,
    this.hourTime,
    this.bpm,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'minuteTime': minuteTime,
      'hourTime': hourTime,
      'bpm': bpm,
    };
  }

  ResultModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    minuteTime = json['minuteTime'];
    hourTime = json['hourTime'];
    bpm = json['bpm'];
  }
}
