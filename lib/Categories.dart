class Categories {
  List<CatData>? data;
  int? status;
  String? message;

  Categories({this.data, this.status, this.message});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CatData>[];
      json['data'].forEach((v) {
        data!.add(new CatData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class CatData {
  List<String>? products;
  String? sId;
  String? name;
  String? slug;

  CatData({this.products, this.sId, this.name, this.slug});

  CatData.fromJson(Map<String, dynamic> json) {
    products = json['products'].cast<String>();
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products'] = this.products;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}