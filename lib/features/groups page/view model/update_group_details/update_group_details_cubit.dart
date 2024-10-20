import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_group_details_state.dart';

class UpdateGroupDetailsCubit extends Cubit<UpdateGroupDetailsState> {
  UpdateGroupDetailsCubit() : super(UpdateGroupDetailsInitial());
  // todo: handle repository then make this cubit
}
