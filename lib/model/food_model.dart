class FoodModel {
  late String food;

  late String type;

  FoodModel({required this.type, required this.food});

  FoodModel.fromJson(Map<String, dynamic> json) {
    food = json['food'];
    type = json['type'];
  }

  Map<String, dynamic> toMap() {
    return {"food": food, "type": type};
  }
}
