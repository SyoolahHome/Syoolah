import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template relay_config}
/// A model class that represents a relay configuration
/// {@endtemplate}
@immutable
class RelayConfiguration extends Equatable {
  /// The web socket url of this Nostr relay.
  final String url;

  /// Weither this relay is activated for Nostr operations.
  final bool isActive;

  @override
  List<Object?> get props => [url, isActive];

  /// {@macro relay_config}
  const RelayConfiguration({
    required this.url,
    this.isActive = true,
  });

  /// {@macro relay_config}
  RelayConfiguration copyWith({
    String? url,
    bool? isActive,
  }) {
    return RelayConfiguration(
      url: url ?? this.url,
      isActive: isActive ?? this.isActive,
    );
  }

  /// {@macro relay_config}
  factory RelayConfiguration.active({
    required String url,
  }) {
    return RelayConfiguration(
      url: url,
      isActive: true,
    );
  }
}
