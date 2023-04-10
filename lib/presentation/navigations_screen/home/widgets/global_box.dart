import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/global_feed/global_feed_cubit.dart';
import '../../../../constants/colors.dart';

class FeedBox extends StatelessWidget {
  const FeedBox({
    super.key,
    required this.onTap,
    required this.title,
    required this.description,
    required this.icon,
  });

  final VoidCallback onTap;
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 85,
        child: Card(
          elevation: 0.0,
          color: AppColors.lighGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: AppColors.black.withOpacity(0.95),
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description,
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: AppColors.black.withOpacity(0.95),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Icon(icon, color: AppColors.teal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
