import 'package:flutter/material.dart';

class MnemonicWordsGridView extends StatelessWidget {
  const MnemonicWordsGridView({
    super.key,
    required this.words,
    required this.onGetWordController,
    required this.onIsVisible,
    required this.onIsEnabled,
    this.onEyeIconTap,
  });

  final List<String> words;
  final TextEditingController? Function(String word) onGetWordController;
  final bool Function(String word) onIsVisible;
  final bool Function(String word) onIsEnabled;
  final void Function(int index)? onEyeIconTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: words.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3.5,
      ),
      itemBuilder: (context, index) {
        final word = words[index];
        final isVisible = onIsVisible(word);
        final enabled = onIsEnabled(word);

        return Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              enabled: enabled,
              style: Theme.of(context).textTheme.bodyMedium,
              controller: onGetWordController(word),
              decoration: InputDecoration(
                prefix: Text(
                  "${index + 1}.  ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            if (onEyeIconTap != null)
              Positioned(
                right: 10,
                child: GestureDetector(
                  onTap: () => onEyeIconTap!.call(index),
                  child: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
