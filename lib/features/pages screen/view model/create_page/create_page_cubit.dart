import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_page_state.dart';

class CreatePageCubit extends Cubit<CreatePageState> {
  CreatePageCubit() : super(CreatePageInitial());
}
