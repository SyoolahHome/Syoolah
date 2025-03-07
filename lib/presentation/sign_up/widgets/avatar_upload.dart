import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class AvatarUpload extends StatelessWidget {
  const AvatarUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
          clipBehavior: Clip.hardEdge,
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            shape: BoxShape.circle,
          ),
          child: AnimatedSwitcher(
            duration: Animate.defaultDuration,
            child: state.pickedImage != null
                ? Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: <Widget>[
                      FutureBuilder(
                          future: state.pickedImage!.readAsBytes(),
                          builder: (context, state) {
                            if (state.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (state.connectionState == ConnectionState.done) {
                              return Image.memory(
                                state.data!,
                                fit: BoxFit.cover,
                              );
                            }

                            return SizedBox.shrink();
                          }),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthCubit>().removePickedImage();
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                FlutterRemix.close_line,
                                size: 20,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            context.read<AuthCubit>().pickImageFromGallery(),
                        child: Icon(
                          FlutterRemix.gallery_line,
                          size: 20,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      VerticalDivider(
                        color: Theme.of(context).iconTheme.color,
                        thickness: 0.25,
                      ),
                      GestureDetector(
                        onTap: () =>
                            context.read<AuthCubit>().pickImageFromCamera(),
                        child: Icon(
                          FlutterRemix.camera_line,
                          size: 20,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
