class ResultModel {
  int? id;
  int? heartRate;
  String? date;
  String? type1;
  String? type2;
  int? hourTime;
  int? munitTime;
  int? yearTime;
  int? monthDate;
  int? dayDate;
  int? sy;
  int? dy;

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
    this.type1,
    this.type2,
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
      'type1':type1,
      'type2':type2,
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
    type1=json['type1'];
    type2=json['type2'];
  }
}
