part of 'help_bloc.dart';

sealed class HelpEvent extends Equatable {
  const HelpEvent();

  @override
  List<Object> get props => [];
}

class CheckHelpStatus extends HelpEvent {}

class SkipHelp extends HelpEvent {}
