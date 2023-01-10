class GetImagesResponse {
 late String status;
 late List<Images> images;

  GetImagesResponse({required this.status, required this.images});

  GetImagesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['images'] != null) {
      images = List<Images>.empty(growable: true);
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['images'] = images.map((v) => v.toJson()).toList();
    return data;
  }
}

class Images {
 late String xtImage;
 late String id;

  Images({required this.xtImage,required this.id});

  Images.fromJson(Map<String, dynamic> json) {
    xtImage = json['xt_image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['xt_image'] = xtImage;
    data['id'] = id;
    return data;
  }
}
