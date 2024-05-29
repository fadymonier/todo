// ignore_for_file: unused_local_variable

import 'package:promina_task/core/api/api_manager.dart';
import 'package:promina_task/core/api/endpoints.dart';
import 'package:promina_task/core/cache/shared_prefs.dart';
import 'package:promina_task/features/home/data/data_sources/home_ds.dart';
import 'package:promina_task/features/home/data/models/gallery_model.dart';

class HomeDSImpl implements HomeDS {
  final ApiManager apiManager;

  HomeDSImpl(this.apiManager);

  @override
  Future<GalleryModel> getGallery() async {
    String? myToken = CacheHelper.getToken("token");
    var response =
        await apiManager.getData(endPoint: EndPoints.gallery, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Bearer Token': myToken
    });
    return GalleryModel.fromJson(response.data);
  }
}
