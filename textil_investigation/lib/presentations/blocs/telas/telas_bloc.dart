import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textil_investigation/domain/entities/tela_entity.dart';
import 'package:textil_investigation/domain/usecases/fetch_filtered_telas_usecase.dart';
import 'telas_event.dart';
import 'telas_state.dart';

class TelasBloc extends Bloc<TelasEvent, TelasState> {
  final FetchFilteredTelasUseCase fetchFilteredTelasUseCase;

  TelasBloc({required this.fetchFilteredTelasUseCase})
      : super(const TelasLoaded()) {
    on<UpdateTelasEvent>(_onUpdateTelas);
  }

  Future<void> _onUpdateTelas(
      UpdateTelasEvent event, Emitter<TelasState> emit) async {
    if (state is TelasLoaded) {
      final currentState = state as TelasLoaded;

      emit(
        TelasLoaded(
          transparency: event.transparency ?? currentState.transparency,
          shine: event.shine ?? currentState.shine,
          endurance: event.endurance ?? currentState.endurance,
          absorption: event.absorption ?? currentState.absorption,
          elasticity: event.elasticity ?? currentState.elasticity,
          isWaterResistant:
              event.isWaterResistant ?? currentState.isWaterResistant,
          isStainResistant:
              event.isStainResistant ?? currentState.isStainResistant,
          isFireRetardant:
              event.isFireRetardant ?? currentState.isFireRetardant,
          telas: currentState.telas,
          isAnadirOrBuscar: event.isAnadirOrBuscar ?? false,
        ),
      );

      final filters = {
        'transparency': event.transparency ?? currentState.transparency,
        'brightness': event.shine ?? currentState.shine,
        'endurance': event.endurance ?? currentState.endurance,
        'absorption': event.absorption ?? currentState.absorption,
        'elasticity': event.elasticity ?? currentState.elasticity,
        'isWaterResistant':
            event.isWaterResistant ?? currentState.isWaterResistant,
        'isStainResistant':
            event.isStainResistant ?? currentState.isStainResistant,
        'isFireRetardant':
            event.isFireRetardant ?? currentState.isFireRetardant,
      };

      if (event.isAnadirOrBuscar == true) {
        final telas = await fetchFilteredTelasUseCase(filters);
        emit(
          TelasLoaded(
            transparency: currentState.transparency,
            shine: currentState.shine,
            endurance: currentState.endurance,
            absorption: currentState.absorption,
            elasticity: currentState.elasticity,
            isWaterResistant: currentState.isWaterResistant,
            isStainResistant: currentState.isStainResistant,
            isFireRetardant: currentState.isFireRetardant,
            telas: telas,
            isAnadirOrBuscar: currentState.isAnadirOrBuscar,
          ),
        );
      }
    }
  }
}
