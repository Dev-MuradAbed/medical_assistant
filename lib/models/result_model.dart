class ResultModel {
  int? id;
  int? heartRate;
  String? date;
  int? hourTime;
  int? munitTime;
  int? yearTime;
  int? monthDate;
  int? dayDate;
  int? sy;
  int? dy;
  String? heartRateType;
  String? booldPressureType;

  ResultModel({
    this.id,
    this.heartRate,
    this.date,
    this.hourTime,
    this.munitTime,
    this.yearTime,
    this.monthDate,
    this.dayDate,
    this.sy,
    this.dy,
    this.heartRateType,
    this.booldPressureType,
  });
  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'heartRate':heartRate,
      'date':date,
      'hourTime':hourTime,
      'munitTime':munitTime,
      'yearTime':yearTime,
      'monthTime':monthDate,
      'dayDate':dayDate,
      'sy':sy,
      'dy':dy,
      'heartRateType':heartRateType,
      'booldPressureType':booldPressureType,
    };
  }
  ResultModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    heartRate=json['heartRate'];
    sy=json['sy'];
    dy=json['dy'];
    date=json['date'];
    hourTime=json['hourTime'];
    munitTime=json['munitTime'];
    yearTime=json['yearTime'];
    monthDate=json['monthTime'];
    dayDate=json['dayDate'];
    heartRateType=json['heartRateType'];
    booldPressureType=json['booldPressureType'];
  }
}
