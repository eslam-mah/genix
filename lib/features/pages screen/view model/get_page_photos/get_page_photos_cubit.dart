import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_page_photos_state.dart';

class GetPagePhotosCubit extends Cubit<GetPagePhotosState> {
  GetPagePhotosCubit() : super(GetPagePhotosInitial());
}
