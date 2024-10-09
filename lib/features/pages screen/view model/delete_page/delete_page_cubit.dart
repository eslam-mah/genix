import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_page_state.dart';

class DeletePageCubit extends Cubit<DeletePageState> {
  DeletePageCubit() : super(DeletePageInitial());
}
