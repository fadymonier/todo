import 'package:dartz/dartz.dart';
import 'package:promina_task/core/errors/failures.dart';
import 'package:promina_task/features/home/data/models/gallery_model.dart';
import 'package:promina_task/features/home/domain/repositories/home_repo.dart';

class GetGalleryUseCase {
  HomeRepo homeRepo;

  GetGalleryUseCase(this.homeRepo);

  Future<Either<Failures, GalleryModel>> call() => homeRepo.getGallery();
}
