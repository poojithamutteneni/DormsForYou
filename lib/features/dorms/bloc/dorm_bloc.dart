import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:database_provider/database_provider.dart';
import 'package:equatable/equatable.dart';

part 'dorm_event.dart';
part 'dorm_state.dart';

class DormBloc extends Bloc<DormEvent, DormState> {
  DormBloc() : super(DormState.empty());

  @override
  Stream<DormState> mapEventToState(
    DormEvent event,
  ) async* {}
}
