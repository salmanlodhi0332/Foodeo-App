import 'package:foodeoapp/screens/addproduct/model/allergens_model.dart';
import 'package:foodeoapp/screens/videos/model/addServiceprovider.dart';
import 'package:foodeoapp/screens/videos/model/nutrients_model.dart';
import 'package:foodeoapp/screens/videos/model/tags_model.dart';

class AddVideoModel {
  int id;
  String title;
  String description;
  String price;
  String thumbnail;
  String content;
  int serverProviderId;
  List<tags_model> tagsList;
  List<AllergensModel> allergensList;
  List<Nutrients> nutrientList;
  List<AddServiceProviderModel> ServiceProviderList;

  AddVideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.content,
    required this.serverProviderId,
    required this.tagsList,
    required this.allergensList,
    required this.nutrientList,
    required this.ServiceProviderList
  });

  factory AddVideoModel.fromJson(Map<String, dynamic> json) {
    return AddVideoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      content: json['content'],
      serverProviderId: json['serverProviderId'],
      tagsList: (json['tagsList'] as List)
          .map((tag) => tags_model.fromjson(tag))
          .toList(),
      allergensList: (json['allergensList'] as List)
          .map((allergen) => AllergensModel.fromjson(allergen))
          .toList(),
      nutrientList: (json['nutrientList'] as List)
          .map((nutrient) => Nutrients.fromjson(nutrient))
          .toList(),
      ServiceProviderList: (json['ServiceProviderList'] as List)
          .map((provider) => AddServiceProviderModel.fromJson(provider))
          .toList(),
    );
  }
}
