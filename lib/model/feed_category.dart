// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FeedCategory extends Equatable {
  final String name;
  final bool isSelected;
  const FeedCategory({
    required this.name,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [name, isSelected];

  FeedCategory copyWith({
    String? name,
    bool? isSelected,
  }) {
    return FeedCategory(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
