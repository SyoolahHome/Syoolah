import 'package:ditto/model/translation_lang.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/profile_options/widgets/profile_title.dart';
import 'package:ditto/services/translator/translator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/cubit/langs_selection_cubit.dart';

class LangsSelectionWidget extends StatelessWidget {
  const LangsSelectionWidget({
    super.key,
    required this.initial,
  });

  final TranslationLang? initial;

  @override
  Widget build(BuildContext context) {
    final langs = Translator.langsCache.values.toList();

    return BlocProvider<LangsSelectionCubit>(
      create: (context) => LangsSelectionCubit(
        initial: initial,
        langs: langs,
      ),
      child: Builder(builder: (context) {
        final cubit = context.read<LangsSelectionCubit>();

        return Scaffold(
          body: Column(
            children: <Widget>[
              MarginedBody(
                child: ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: BottomSheetOptionsTitle(
                    title: "select_lang".tr(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              MarginedBody(
                child: CustomTextField(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  suffix: Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(
                      FlutterRemix.search_line,
                      size: 18,
                    ),
                  ),
                  controller: cubit.searchController,
                  hint: "search_lang".tr(args: [
                    langs.length.toString(),
                  ]),
                ),
              ),
              SizedBox(height: 10),
              BlocBuilder<LangsSelectionCubit, LangsSelectionState>(
                builder: (context, state) {
                  final listToUse = state.searchQuery.isNotEmpty
                      ? langs.where((lang) {
                          return lang.name
                                  .toLowerCase()
                                  .contains(state.searchQuery.toLowerCase()) ||
                              lang.nativeName
                                  .toLowerCase()
                                  .contains(state.searchQuery.toLowerCase());
                        }).toList()
                      : langs;

                  return Expanded(
                    child: ListView.builder(
                      controller: cubit.scrollController,
                      shrinkWrap: true,
                      itemCount: listToUse.length,
                      itemBuilder: (context, index) {
                        final lang = listToUse[index];
                        final isSelected = lang == state.selectedLang;

                        return ListTile(
                          contentPadding: MarginedBody.defaultMargin +
                              const EdgeInsets.symmetric(vertical: 5),
                          tileColor:
                              isSelected ? Colors.green.withOpacity(.1) : null,
                          title: Text(
                            "${lang.name}  -  ${lang.nativeName}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(),
                          ),
                          onTap: () {
                            cubit.selectLang(
                              lang,
                              (lang) => Navigator.of(context).pop(lang),
                            );
                          },
                          trailing: ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                isSelected
                                    ? FlutterRemix.check_fill
                                    : FlutterRemix.add_circle_fill,
                                color: isSelected ? Colors.green : null,
                                size: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
