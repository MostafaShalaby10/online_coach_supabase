import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/meal_model.dart';
import '../../shared/constants/constants.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit() : super(MealInitial());

  static MealCubit get(context) => BlocProvider.of(context);

  MealModel? foodModel;

  void addMealCubit({
    required int userId,
    required String day,
    required String meal,
    required String type,
  }) async {
    emit(LoadingAddMealState());
    foodModel = MealModel(meal: meal, userId: userId, type: type, day: day);
    await supaBase.from("Meals").insert(foodModel!.toMap()).then((value) {
      emit(SuccessfullyAddMealState());
    }).catchError((error) {
      emit(ErrorAddMealState(error));
    });
  }

  List breakfastMealData = [];
  List lunchMealData = [];
  List dinnerMealData = [];

  Future? getFoodCubit({
    required int userId,
    required String day,
    // required String type,
  }) async {
    breakfastMealData = [];
    lunchMealData = [];
    dinnerMealData = [];

    emit(LoadingGetMealState());

    await supaBase
        .from("Meals")
        .select()
        .eq("user_id", userId)
        .eq("day", day)
        .then((value) {
      for (var element in value) {
        if (element["type"] == "breakfast") {
          breakfastMealData.add(element);
        } else if (element["type"] == "lunch") {
          lunchMealData.add(element);
        } else if (element["type"] == "dinner") {
          dinnerMealData.add(element);
        }
      }
      // foodData = value;
      // exerciseData.addAll({exerciseDataSingle["data"]});
      emit(SuccessfullyGetMealState());
    }).catchError((error) {
      emit(ErrorGetMealState(error.toString()));
    });
  }
}
