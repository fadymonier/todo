import 'package:dartz/dartz.dart';
import 'package:promina_task/core/errors/failures.dart';
import 'package:promina_task/features/home/data/data_sources/home_ds.dart';
import 'package:promina_task/features/home/data/models/gallery_model.dart';
import 'package:promina_task/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeDS homeDS;

  HomeRepoImpl(this.homeDS);

  @override
  Future<Either<Failures, GalleryModel>> getGallery() async {
    try {
      var result = await homeDS.getGallery();
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }
}
