// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'note.dart';

class SearchOption extends Equatable {
  final String name;
  final bool useSearchQuery;
  final bool isSelected;
  final List<Note> Function(List<Note> feedPosts, String search) searchFunction;

  const SearchOption({
    required this.name,
    required this.isSelected,
    required this.searchFunction,
    required this.useSearchQuery,
  });

  @override
  List<Object?> get props => [
        name,
        isSelected,
        searchFunction,
        useSearchQuery,
      ];

  SearchOption copyWith({
    String? name,
    bool? useSearchQuery,
    bool? isSelected,
    List<Note> Function(List<Note> feedPosts, String search)? searchFunction,
  }) {
    return SearchOption(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      searchFunction: searchFunction ?? this.searchFunction,
      useSearchQuery: useSearchQuery ?? this.useSearchQuery,
    );
  }
}
