part of 'ptbbloc_bloc.dart';

abstract class PTBEvent extends Equatable {
  const PTBEvent();
}

class PTBInitializeEvent extends PTBEvent {
  @override
  List<Object?> get props => [];
}
