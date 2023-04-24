import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarUpload extends StatelessWidget {
  const AvatarUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.read<AuthCubit>().pickImage(),
          child: Container(
              clipBehavior: Clip.hardEdge,
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: state.pickedImage != null
                  ? Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.file(
                          state.pickedImage!,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey[200]!.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 17.5,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Icon(
                      Icons.person,
                      size: 20,
                    )),
        );
      },
    );
  }
}
