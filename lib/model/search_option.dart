import 'package:ditto/model/note.dart';
import 'package:equatable/equatable.dart';

class SearchOption extends Equatable {
  final String name;
  final bool useSearchQuery;
  final bool isSelected;
  final List<Note> Function(List<Note> feedPosts, String search) searchFunction;
  final bool manipulatesExistingResultsList;
  @override
  List<Object?> get props => [
        name,
        isSelected,
        searchFunction,
        useSearchQuery,
        manipulatesExistingResultsList,
      ];

  const SearchOption({
    required this.name,
    required this.isSelected,
    required this.searchFunction,
    required this.useSearchQuery,
    this.manipulatesExistingResultsList = false,
  });

  SearchOption copyWith({
    String? name,
    bool? useSearchQuery,
    bool? isSelected,
    List<Note> Function(List<Note> feedPosts, String search)? searchFunction,
    bool? manipulatesExistingResultsList,
  }) {
    return SearchOption(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      searchFunction: searchFunction ?? this.searchFunction,
      useSearchQuery: useSearchQuery ?? this.useSearchQuery,
      manipulatesExistingResultsList:
          manipulatesExistingResultsList ?? this.manipulatesExistingResultsList,
    );
  }
}
