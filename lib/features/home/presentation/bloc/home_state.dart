part of 'home_bloc.dart';

class HomeState extends Equatable {
  final RequestStatus status;
  final GalleryModel? galleryModel;
  final String? errorMessage;

  const HomeState({
    this.status = RequestStatus.init,
    this.galleryModel,
    this.errorMessage,
  });

  HomeState copyWith({
    RequestStatus? status,
    GalleryModel? galleryModel,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      galleryModel: galleryModel ?? this.galleryModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, galleryModel, errorMessage];
}
