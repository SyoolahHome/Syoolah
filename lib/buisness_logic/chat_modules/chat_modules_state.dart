// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_modules_cubit.dart';

class ChatModulesState extends Equatable {
  final double sliderValue;
  const ChatModulesState({
    this.sliderValue = 0.0,
  });

  @override
  List<Object> get props => [sliderValue];

  ChatModulesState copyWith({
    double? sliderValue,
  }) {
    return ChatModulesState(
      sliderValue: sliderValue ?? this.sliderValue,
    );
  }
}

class ChatModulesInitial extends ChatModulesState {}
