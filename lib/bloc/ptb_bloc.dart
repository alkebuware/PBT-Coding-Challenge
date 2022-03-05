import 'package:bloc/bloc.dart';
import 'package:coding_challenge/models/ptb.dart';
import 'package:coding_challenge/repositories/ptb.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'ptb_bloc.g.dart';

part 'ptb_event.dart';

part 'ptb_state.dart';

class PTBBloc extends Bloc<PTBEvent, PTBState> {
  final PTBRepository ptbRepository;

  PTBBloc({required this.ptbRepository}) : super(LoadingPTBState()) {
    on<InitializePTBEvent>(_onInitializeEvent);
    on<SelectPTBEvent>(_onSelectEvent);
  }

  void _onSelectEvent(SelectPTBEvent event, Emitter emit) {
    final state = this.state;
    if (state is SuccessPTBState) {
      emit(state.copyWith(selectedItem: event.item));
    }
  }

  void _onInitializeEvent(InitializePTBEvent event, Emitter emit) async {
    emit(LoadingPTBState());
    try {
      final response = await ptbRepository.getPrimeTimeBillboard();
      emit(SuccessPTBState(
          items: response.items, selectedItem: response.items.first));
    } catch (e) {
      // TODO: log in Crashlytics, Sentry, etc
      emit(ErrorPTBState());
      rethrow;
    }
  }
}
