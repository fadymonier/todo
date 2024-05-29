class GalleryModel {
  String status;
  Data data;
  String message;

  GalleryModel(
      {required this.status, required this.data, required this.message});

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      status: json['status'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  List<String> images;

  Data({required this.images});

  factory Data.fromJson(Map<String, dynamic> json) {
    List<String> imagesList = [];
    if (json['images'] != null) {
      json['images'].forEach((imageUrl) {
        imagesList.add(imageUrl as String);
      });
    }
    return Data(images: imagesList);
  }
}
