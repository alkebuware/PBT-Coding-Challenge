part of 'ptb_bloc.dart';

abstract class PTBState extends Equatable {
  const PTBState();
}

class LoadingPTBState extends PTBState {
  @override
  List<Object> get props => [];
}

@CopyWith()
class SuccessPTBState extends PTBState {
  final PTBItem selectedItem;
  final List<PTBItem> items;

  const SuccessPTBState({required this.items, required this.selectedItem});

  @override
  List<Object?> get props => [items, selectedItem];
}

class ErrorPTBState extends PTBState {
  @override
  List<Object?> get props => [];
}
