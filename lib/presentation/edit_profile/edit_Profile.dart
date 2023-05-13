import 'package:ditto/buisness_logic/edit_profile/edit_profile_cubit.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_colors.dart';
import 'widgets/edit_field.dart';
import 'widgets/save_button.dart';
import 'widgets/top_bar.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  UserMetaData? userMetaData;
  @override
  Widget build(BuildContext context) {
    userMetaData = ModalRoute.of(context)!.settings.arguments as UserMetaData;

    return BlocProvider<EditProfileCubit>(
      create: (context) => EditProfileCubit(userMetaData!),
      lazy: false,
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Builder(builder: (context) {
              final cubit = context.read<EditProfileCubit>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  EditField(
                    label: "nameLabel".tr(),
                    controller: cubit.nameController!,
                  ),
                  EditField(
                    label: "usernameLabel".tr(),
                    controller: cubit.usernameController!,
                  ),
                  EditField(
                    controller: cubit.pictureController!,
                    label: "profileLabel".tr(),
                  ),
                  EditField(
                    label: "profileLabel".tr(),
                    controller: cubit.aboutController!,
                  ),
                  const SizedBox(height: 20),
                  SaveButton(
                    onTap: () {
                      cubit.saveEdits();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
