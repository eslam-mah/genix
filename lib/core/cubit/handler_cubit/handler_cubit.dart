import 'package:flutter_bloc/flutter_bloc.dart';

class HandlerCubit<T> extends Cubit<T> {
  HandlerCubit(super.initialState);

  init(T value) => emit(value);

  update(T value) => emit(value);
}
