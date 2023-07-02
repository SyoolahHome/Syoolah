part of 'chat_modules_cubit.dart';

/// {@template chat_modules_state}
/// The state of [ChatModulesCubit].
/// {@endtemplate}
class ChatModulesState extends Equatable {
  /// The value of the slider that controls the Imam level
  final double sliderValue;

  /// {@macro chat_modules_state}
  const ChatModulesState({
    this.sliderValue = 0.0,
  });

  @override
  List<Object> get props => [
        sliderValue,
      ];

  /// {@macro chat_modules_state}
  ChatModulesState copyWith({
    double? sliderValue,
  }) {
    return ChatModulesState(
      sliderValue: sliderValue ?? this.sliderValue,
    );
  }

  /// {@macro chat_modules_state}
  factory ChatModulesState.initial() {
    return ChatModulesInitial();
  }
}

class ChatModulesInitial extends ChatModulesState {}
