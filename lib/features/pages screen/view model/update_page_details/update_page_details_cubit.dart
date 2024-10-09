import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_page_details_state.dart';

class UpdatePageDetailsCubit extends Cubit<UpdatePageDetailsState> {
  UpdatePageDetailsCubit() : super(UpdatePageDetailsInitial());
}
