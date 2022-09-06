import 'package:equatable/equatable.dart';
import 'package:flutter_better_muslim/bloc/bloc_exports.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchInitial(val: false)) {
    on<SwitchOn>((event, emit) {
      emit(const SwitchState(switchVal: true));
    });
    on<SwitchOff>((event, emit) {
      emit(const SwitchState(switchVal: false));
    });
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    return SwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    return state.toMap();
  }
}
