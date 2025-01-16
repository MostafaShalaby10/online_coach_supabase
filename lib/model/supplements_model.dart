class SupplementsModel {
  String? supplementsName;

  String? times;
  int? userId;

  SupplementsModel({required this.times, required this.supplementsName , required this.userId});

  SupplementsModel.fromJson(Map<dynamic, dynamic> json) {
    times = json['times'];
    supplementsName = json['supplementsName'];
    userId = json['userId'];
  }
  Map<String , dynamic> toMap(){
    return{
      "times" : times ,
      "supplementsName" : supplementsName ,
      "user_id" : userId ,
    };
  }
}
