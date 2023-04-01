import 'package:ditto/buisness_logic/edit_profile/edit_profile_cubit.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/colors.dart';
import '../bottom_bar_screen/bottom_bar_screen.dart';
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
                children: <Widget>[
                  EditField(
                    label: "Name:",
                    controller: cubit.nameController!,
                  ),
                  EditField(
                    label: "Username:",
                    controller: cubit.usernameController!,
                  ),
                  EditField(
                    controller: cubit.pictureController!,
                    label: "Picture url:",
                  ),
                  EditField(
                    controller: cubit.aboutController!,
                    label: "about:",
                  ),
                  EditField(
                    controller: cubit.bannerController!,
                    label: "Banner url:",
                  ),
                  // EditField(
                  //   controller: cubit.aboutController,
                  //   label: "Bitcoin lightning address:",
                  // ),
                  // EditField(
                  //   controller: cubit.aboutController,
                  //   label: "Nostr address(nip05):",
                  // ),
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
