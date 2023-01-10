class GetImages {
  late String userId;
  late String offset;
  late String type;

  GetImages({required this.userId, required this.offset, required this.type});

  GetImages.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    offset = json['offset'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = <String, String>{};
    data['user_id'] = userId;
    data['offset'] = offset;
    data['type'] = type;
    return data;
  }
}
