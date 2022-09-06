part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  final bool switchVal;

  const SwitchState({
    required this.switchVal,
  });

  @override
  List<Object> get props => [switchVal];

  Map<String, dynamic> toMap() {
    return {
      'switchVal': switchVal,
    };
  }

  factory SwitchState.fromMap(Map<String, dynamic> map) {
    return SwitchState(
      switchVal: map['switchVal'] as bool,
    );
  }
}

class SwitchInitial extends SwitchState {
  const SwitchInitial({required bool val}) : super(switchVal: val);
}
