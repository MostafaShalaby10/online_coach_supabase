class MealModel {
  String? meal;
  String? day;

  String? type;

  int? userId;

  MealModel({required this.meal, required this.userId, required this.type, required this.day});

  MealModel.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    meal = json['meal'];
    type = json['type'];
    day = json['day'];
  }

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "meal": meal,
      "user_id": userId,
      "day": day,
    };
  }
}
