class ResultModel {
  int? id;
  String? bloodPressure;
  int? heartRate;
  String? date;
  int? hourTime;
  int? munitTime;
  int? yearTime;
  int? monthDate;

  ResultModel({
    this.id,
    this.bloodPressure,
    this.heartRate,
    this.date,
    this.hourTime,
    this.munitTime,
    this.yearTime,
    this.monthDate,
  });
  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'bloodPressure':bloodPressure,
      'heartRate':heartRate,
      'date':date,
      'hourTime':hourTime,
      'munitTime':munitTime,
      'yearTime':yearTime,
      'monthTime':monthDate,
    };
  }
  ResultModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    bloodPressure=json['bloodPressure'];
    heartRate=json['heartRate'];
    date=json['date'];
    hourTime=json['hourTime'];
    munitTime=json['munitTime'];
    yearTime=json['yearTime'];
    monthDate=json['monthTime'];
  }
}
