part of 'ptb_bloc.dart';

abstract class PTBEvent extends Equatable {
  const PTBEvent();
}

class InitializePTBEvent extends PTBEvent {
  @override
  List<Object?> get props => [];
}

class SelectPTBEvent extends PTBEvent {
  final PTBItem item;

  const SelectPTBEvent({required this.item});

  @override
  List<Object?> get props => [item];
}
