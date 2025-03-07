import 'package:ditto/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FollowingBox extends StatelessWidget {
  const FollowingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 75,
      child: Card(
        elevation: 0.0,
        color: Theme.of(context).primaryColor.withOpacity(1),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Following Box',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Public Notes from people you follow",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
