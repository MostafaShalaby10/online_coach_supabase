import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/supplements/supplements_cubit.dart';
import '../../shared/components/components.dart';

class AddSupplements extends StatelessWidget {
  final int id;

  AddSupplements({super.key, required this.id});

  final formKey = GlobalKey<FormState>();
  final TextEditingController supplementsController = TextEditingController();
  final TextEditingController supplementsQuantityController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupplementsCubit()..getSupplementsCubit(userId: id),
      child: BlocConsumer<SupplementsCubit, SupplementsState>(
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: text(text: "Add Supplements"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10.h,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textField(
                        type: TextInputType.text,
                        label: "Add supplements",
                        prefixIcon: Icons.add,
                        controller: supplementsController),
                    textField(
                        type: TextInputType.text,
                        label: "Add the quantity",
                        prefixIcon: Icons.numbers_outlined,
                        controller: supplementsQuantityController),
                    state is! LoadingAddSupplementsState
                        ? defaultButton(context, label: "Save", fontSize: 20,
                            function: () {
                            if (formKey.currentState!.validate()) {
                              SupplementsCubit.get(context).addSupplementsCubit(
                                userId: id,
                                times: supplementsQuantityController.text,
                                supplementsName: supplementsController.text,
                              );
                            }
                          })
                        : Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is SuccessfullyAddSupplementsState) {
          toastMSG(text: "Added supplements successfully", color: Colors.green);
          supplementsQuantityController.clear();
          supplementsController.clear();
        } else if (state is ErrorAddSupplementsState) {
          toastMSG(text: state.error.toString(), color: Colors.red);
        }
      }),
    );
  }
}
