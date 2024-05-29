import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:promina_task/core/enums/screen_status.dart';
import 'package:promina_task/features/home/domain/use_cases/get_gallery_usecase.dart';
import 'package:promina_task/features/home/data/models/gallery_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetGalleryUseCase getGalleryUseCase;

  HomeBloc(this.getGalleryUseCase) : super(const HomeState()) {
    on<GetGalleryEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatus.loading));

      final result = await getGalleryUseCase();

      result.fold(
        (failure) => emit(state.copyWith(
            status: RequestStatus.failure, errorMessage: failure.toString())),
        (galleryModel) => emit(state.copyWith(
            status: RequestStatus.success, galleryModel: galleryModel)),
      );
    });
  }
}
