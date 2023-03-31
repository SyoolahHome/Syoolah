// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'filters.dart';

class NostrRequest extends Equatable {
  final String subscriptionId;
  Filters? filters;

  NostrRequest({
    required this.subscriptionId,
    this.filters,
  });

  List serialized() {
    return ["REQ", subscriptionId, if (filters != null) filters!.toMap()];
  }

  @override
  List<Object?> get props => [subscriptionId, filters];
}
