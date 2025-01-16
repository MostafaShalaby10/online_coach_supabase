class ExerciseModel{
  String? link ;
  String? label ;
  String? day ;
  int? reps ;
  int? sets ;
  int? userId ;

  ExerciseModel({required this.label , required this.link , required this.reps , required this.sets , required this.userId , required this.day});


  ExerciseModel.fromJson(Map<dynamic, dynamic> json) {
    link = json['link'];
    label = json['label'];
    reps = json['reps'];
    sets = json['sets'];
    userId = json['user_id'];
    day = json['day'];
  }

Map<String , dynamic> toMap(){
    return{
"link" : link ,
"label" : label ,
"reps" : reps ,
"sets" : sets ,
"day" : day ,
"user_id" : userId ,};
}
}