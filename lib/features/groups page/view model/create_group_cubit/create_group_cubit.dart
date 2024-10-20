import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit() : super(CreateGroupInitial());

  // todo: handle repository then make the cubit
}
