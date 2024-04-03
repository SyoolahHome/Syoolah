import 'package:ditto/presentation/bottom_bar_screen/widgets/bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../general/widget/title.dart';

class AboutRoundaboutContent extends StatelessWidget {
  const AboutRoundaboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // final showOnlyAppDescription =
    //     args?["showOnlyAppDescription"] as bool? ?? false;

    const height = 10.0;

    final sections = <(String, String)>[
      (
        'Restoring Digital Liberty',
        'Roundabout is a powerful antidote to censorship on the Internet and embodies the true spirit of liberty in the digital age.'
      ),
      (
        'Reviving Social Media’s Original Vision',
        'Roundabout returns to the essence of social media as a platform for free expression and connection, countering the trend of centralized control and censorship.'
      ),
      (
        'Challenging the Status Quo',
        'Roundabout not only changes how we interact online but also questions the underlying power structures of the digital world, advocating for a more balanced and equitable information ecosystem.'
      ),
      (
        'Empowerment Through Decentralization',
        'By decentralizing control, Roundabout hands back power to users, allowing them to shape their digital experience without interference.'
      ),
      (
        'Innovating Beyond Social Media',
        'Roundabout\'s potential extends far beyond traditional social media, offering a resilient framework for exciting new features like Reddit-style communities, Bitcoin payments for truly global banking and even Bitcoin ballots for elections hat can\'t be stolen.'
      ),
      (
        'A New Era of Digital Interaction',
        'Roundabout isn’t just a platform - it’s a movement towards a more open, interconnected digital world where freedom of expression and innovation thrive.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: height),
        ...sections.indexed.map(
          (entry) {
            return Animate(
              delay: (400 + entry.$1 * 100).ms,
              effects: <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(0, 0.5),
                ),
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.$2.$1,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height),
                  Text(
                    entry.$2.$2,
                  ),
                  SizedBox(height: height * 3),
                ],
              ),
            );
          },
        ),
        SizedBox(height: height * 2),
      ],
    );
  }
}
