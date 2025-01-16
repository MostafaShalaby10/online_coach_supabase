import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_coach_supabase/views/shared/show_exercise.dart';
import 'package:online_coach_supabase/views/shared/show_food.dart';

import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';

class Days extends StatelessWidget {
  final bool isExercise;
  final int uid;

  final bool isAdmin;

  const Days(
      {super.key,
      required this.isExercise,
      required this.uid,
      required this.isAdmin});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(

      ),
      body: ListView.separated(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              moveForward(
                  context: context,
                  page: isExercise
                      ? ShowExercise(
                          day: (index + 1).toString(),
                          id: uid,
                          isAdmin: isAdmin,
                        )
                      : ShowFood(
                          day: (index + 1).toString(),
                          id: uid,
                          isAdmin: isAdmin,
                        ));
            },
            child: SizedBox(
              height: 170.h,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Image(
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      image: CachedNetworkImageProvider(isExercise?exerciseImages[index]:foodImages[index])),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                        vertical: 10.h, horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 72.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: secondaryColor, width: 8),
                          ),
                          child: Center(
                              child: text(
                                  text: "${index + 1} /7",
                                  fontColor: Colors.white,
                                  fontSize: 20)),
                        ),
                        text(
                            text: "DAY ${index + 1}",
                            fontSize: 24,
                            fontWeight: FontWeight.w900)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        itemCount: 7,
        separatorBuilder: (context, index) => verticalSpace(space: 10),
      ),
    );
  }
}
