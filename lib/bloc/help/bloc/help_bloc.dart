import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokma_weather_app/services/storage_service.dart';

part 'help_event.dart';
part 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  final StorageService storageService;
  HelpBloc({required this.storageService}) : super(HelpInitial()) {
    on<CheckHelpStatus>(_onCheckHelpStatus);
    on<SkipHelp>(_onSkipHelp);
  }
  Future<void> _onCheckHelpStatus(
    CheckHelpStatus event,
    Emitter<HelpState> emit,
  ) async {
    final isSkipped = await storageService.isHelpSkipped();
    emit(isSkipped ? HelpSkipped() : HelpVisible());
  }

  Future<void> _onSkipHelp(SkipHelp event, Emitter<HelpState> emit) async {
    await storageService.setHelpSkipped(true);
    emit(HelpSkipped());
  }
}
