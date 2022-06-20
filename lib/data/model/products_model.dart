// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

// import 'dart:convert';

// List<ProductsModel> productsModelFromJson(String str) => List<ProductsModel>.from(json.decode(str).map((x) => ProductsModel.fromJson(x)));

// String productsModelToJson(List<ProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
  ProductsModel(
      {this.tenantId,
      this.name,
      this.description,
      this.isAvailable,
      this.id,
      this.isDownloaded = false});

  int? tenantId;
  String? name;
  String? description;
  bool? isAvailable;
  int? id;
  bool? isDownloaded;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        tenantId: json["tenantId"],
        name: json["name"],
        description: json["description"],
        isAvailable: json["isAvailable"],
        id: json["id"],
        isDownloaded: json["isDownloaded"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "tenantId": tenantId,
        "name": name,
        "description": description,
        "isAvailable": isAvailable,
        "id": id,
        "isDownloaded": isDownloaded,
      };
}
