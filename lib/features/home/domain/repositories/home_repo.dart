import 'package:dartz/dartz.dart';
import 'package:promina_task/core/errors/failures.dart';
import 'package:promina_task/features/home/data/models/gallery_model.dart';

abstract class HomeRepo {
  Future<Either<Failures, GalleryModel>> getGallery();
}
