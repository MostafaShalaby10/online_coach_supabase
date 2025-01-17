import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../logic/supplements/supplements_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import '../admin/add_supplements.dart';


class ShowSupplements extends StatelessWidget {
  final int id;

  final bool isAdmin;

  const ShowSupplements({super.key, required this.id, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupplementsCubit()..getSupplementsCubit(userId: id),
      child: BlocConsumer<SupplementsCubit, SupplementsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: state is! LoadingGetSupplementsState? Column(
                        children: [
                          if (SupplementsCubit.get(context)
                              .supplementsData
                              .isNotEmpty)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ListView.builder(
                                    itemBuilder: (context, index) => Stack(
alignment: Alignment.topRight,
                                      children: [
                                        if(isAdmin)
                                        IconButton(onPressed: (){
                                          SupplementsCubit.get(context).deleteSupplements(id: SupplementsCubit.get(context).supplementsData[index]
                                          [
                                          "id"]);
                                        }, icon: Icon(Icons.delete_forever_outlined , color: Colors.red,)),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: text(
                                                  text: SupplementsCubit.get(
                                                      context)
                                                      .supplementsData
                                                  [index]
                                                  ["supplementsName"],
                                                  fontSize: 25,
                                                  fontColor:HexColor("#26619C"),
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            text(
                                                text: SupplementsCubit.get(
                                                    context)
                                                    .supplementsData
                                                [index]["times"]),
                                          ],
                                        ),
                                      ],
                                    ),
                              
                                    itemCount: SupplementsCubit.get(context)
                                        .supplementsData
                                        .length),
                              ),
                            ),
                          if (SupplementsCubit.get(context)
                              .supplementsData
                              .isEmpty)
                       Expanded(
                         child: Column(
                           children: [
                             Expanded(
                               child: Image(
                                   image: CachedNetworkImageProvider(
                                       "https://img.freepik.com/free-psd/lying-down-watching-movies-home-3d-illustration_1419-2560.jpg?t=st=1735255085~exp=1735258685~hmac=41e4cc0ba502404ceb06ec0afb4ef2435f353087805de89f7404edc1df9ea25b&w=740")),
                             ),
                             Center(
                               child: text(
                                   text:
                                   "There is no Supplements yet\n Waittttt!!",
                                   fontSize: 25,
                                   fontColor: secondaryColor),
                             ),
                           ],
                         ),
                       ) ,
                          Spacer(),
                          if (isAdmin)
                            defaultButton(context,
                                label: "Add supplements",
                                fontSize: 20,
                                function: () {
                                  moveForward(
                                      context: context,
                                      page: AddSupplements(id: id));
                                })
                        ],
                      ): Center(child: CircularProgressIndicator()),
            );
          },
          listener: (context, state) {
            if (state is SuccessfullyDeleteSupplementsState) {
              toastMSG(text: "Deleted Successfully", color: Colors.green) ;
              moveBackWord(context: context);
            }  else if (state is ErrorDeleteSupplementsState) {
              toastMSG(text: state.error.toString(), color: Colors.red) ;
            }
          }),
    );
  }
}
