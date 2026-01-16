part of 'help_bloc.dart';

sealed class HelpState extends Equatable {
  const HelpState();

  @override
  List<Object> get props => [];
}

final class HelpInitial extends HelpState {}

class HelpChecking extends HelpState {}

class HelpVisible extends HelpState {}

class HelpSkipped extends HelpState {}
