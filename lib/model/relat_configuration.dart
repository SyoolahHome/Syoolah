// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class RelayConfiguration extends Equatable {
  final String url;
  final bool isActive;

  const RelayConfiguration({
    required this.url,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [url, isActive];

  RelayConfiguration copyWith({
    String? url,
    bool? isActive,
  }) {
    return RelayConfiguration(
      url: url ?? this.url,
      isActive: isActive ?? this.isActive,
    );
  }
}
