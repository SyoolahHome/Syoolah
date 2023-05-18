import 'package:ditto/buisness_logic/edit_profile/edit_profile_cubit.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_colors.dart';
import '../general/widget/title.dart';
import 'widgets/edit_field.dart';
import 'widgets/save_button.dart';
import 'widgets/top_bar.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  UserMetaData? userMetaData;
  @override
  Widget build(BuildContext context) {
    userMetaData = ModalRoute.of(context)!.settings.arguments as UserMetaData;
    const height = 10.0;

    return BlocProvider<EditProfileCubit>(
      create: (context) => EditProfileCubit(userMetaData!),
      lazy: false,
      child: Builder(builder: (context) {
        return BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state.error != null) {
              SnackBars.text(context, state.error!);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: const CustomAppBar(),
              body: MarginedBody(
                child: Builder(builder: (context) {
                  final cubit = context.read<EditProfileCubit>();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: height * 3),
                      Text(
                        "editProfile".tr(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: height * 3),
                      EditField(
                        label: "nameLabel".tr(),
                        controller: cubit.nameController!,
                      ),
                      SizedBox(height: height),
                      EditField(
                        label: "usernameLabel".tr(),
                        controller: cubit.usernameController!,
                      ),
                      const Spacer(),
                      SaveButton(
                        onTap: () {
                          cubit.saveEdits();
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: height),
                    ],
                  );
                }),
              ),
            );
          },
        );
      }),
    );
  }
}
