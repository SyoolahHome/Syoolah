import 'package:ditto/model/note.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template search_option}
/// A model class that holds data related to a single search option.
/// {@endtemplate}
@immutable
class SearchOption extends Equatable {
  /// The name of the search option.
  final String name;

  /// Weither this option will a query to perform search.
  final bool useSearchQuery;

  /// Weither this osearc option is activated/selected or not.
  final bool isSelected;

  /// The function to perform the search function.
  final List<Note> Function(List<Note> feedPosts, String search) searchFunction;

  /// Weither this option will manipulate an existing list of notes.
  final bool manipulatesExistingResultsList;

  @override
  List<Object?> get props => [
        name,
        isSelected,
        searchFunction,
        useSearchQuery,
        manipulatesExistingResultsList,
      ];

  /// {@macro search_option}
  const SearchOption({
    required this.name,
    required this.isSelected,
    required this.searchFunction,
    required this.useSearchQuery,
    this.manipulatesExistingResultsList = false,
  });

  /// {@macro search_option}
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
