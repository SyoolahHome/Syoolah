import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../../../main.dart';
import '../../../../model/user_meta_data.dart';

class ProfileCover extends StatelessWidget {
  const ProfileCover({
    super.key,
    required this.metadata,
  });

  final UserMetaData metadata;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            metadata.banner!,
          ),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.teal.withOpacity(0.8), BlendMode.dstATop),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 38),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox.shrink(),
            PopupMenuButton(
              icon: const Icon(Icons.more_horiz, color: Colors.black, size: 40),
              itemBuilder: (_) {
                return <PopupMenuItem<String>>[
                  PopupMenuItem(
                    value: "Logout",
                    child: InkWell(
                      child: const Text("Logout"),
                      onTap: () {
                        context.read<AuthCubit>().signOut();
                      },
                    ),
                  ),
                  PopupMenuItem(
                    value: "Copy Private Key",
                    child: InkWell(
                      child: const Text("Copy Private Key"),
                      onTap: () {
                        context.read<AuthCubit>().copyPrivateKey();
                      },
                    ),
                  )
                ];
              },
            )
          ],
        ),
      ),
    );
  }
}
