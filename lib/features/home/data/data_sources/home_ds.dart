import 'package:promina_task/features/home/data/models/gallery_model.dart';

abstract class HomeDS {
  Future<GalleryModel> getGallery();
}
