import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../model/note.dart';
import '../../general/widget/margined_body.dart';
import '../../general/widget/note_card/note_card.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key, required this.notes, required this.feedName});

  final List<Note> notes;
  final String feedName;
  @override
  Widget build(BuildContext context) {
    return MarginedBody(
      child: ListView.builder(
        itemCount: notes.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Text(
                    AppStrings.feedOfName(feedName),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.teal.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: AnimatedSwitcher(
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        notes.length.toString(),
                        key: ValueKey(notes.length),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return NoteCard(
            note: notes[index - 1],
          );
        },
      ),
    );
  }
}
