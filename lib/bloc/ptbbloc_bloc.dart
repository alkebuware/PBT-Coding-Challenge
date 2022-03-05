import 'package:bloc/bloc.dart';
import 'package:coding_challenge/models/ptb.dart';
import 'package:coding_challenge/repositories/ptb.dart';
import 'package:equatable/equatable.dart';

part 'ptbbloc_event.dart';

part 'ptbbloc_state.dart';

class PTBBloc extends Bloc<PTBEvent, PTBState> {
  final PTBRepository ptbRepository;

  PTBBloc({required this.ptbRepository}) : super(PTBLoadingState()) {
    on<PTBInitializeEvent>(_onInitializeEvent);
  }

  void _onInitializeEvent(PTBInitializeEvent event, Emitter emit) async {
    emit(PTBLoadingState());
    try {
      final response = await ptbRepository.getPrimeTimeBillboard();
      emit(PTBSuccessState(
          items: response.items, selectedItem: response.items.first));
    } catch (e) {
      // TODO: log in Crashlytics, Sentry, etc
      emit(PTBErrorState());
      rethrow;
    }
  }
}
