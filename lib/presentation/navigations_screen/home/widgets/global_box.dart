import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../services/utils/paths.dart';

class GlobalBox extends StatelessWidget {
  const GlobalBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Paths.globalFeed);
      },
      child: SizedBox(
        width: double.infinity,
        height: 75,
        child: Card(
          elevation: 0.0,
          color: AppColors.teal.withOpacity(1),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.teal, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Global Box',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Public Notes from everyone using Nostr",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
