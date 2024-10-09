import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_page_by_id_state.dart';

class GetPageByIdCubit extends Cubit<GetPageByIdState> {
  GetPageByIdCubit() : super(GetPageByIdInitial());
}
