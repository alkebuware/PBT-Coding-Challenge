part of 'ptbbloc_bloc.dart';

abstract class PTBState extends Equatable {
  const PTBState();
}

class PTBLoadingState extends PTBState {
  @override
  List<Object> get props => [];
}

class PTBSuccessState extends PTBState {
  final PTBItem selectedItem;
  final List<PTBItem> items;

  const PTBSuccessState({required this.items, required this.selectedItem});

  @override
  List<Object?> get props => [items];
}

class PTBErrorState extends PTBState {
  @override
  List<Object?> get props => [];
}
