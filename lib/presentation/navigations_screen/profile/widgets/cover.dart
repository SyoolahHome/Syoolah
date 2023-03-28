import 'package:flutter/material.dart';

import '../../../../main.dart';

class ProfileCover extends StatelessWidget {
  const ProfileCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
            "assets/back.jpeg",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
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
