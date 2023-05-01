class ProductModel {

  final String? id;
  final String name;
  final String description;
  final String image;
  final String color;
  final String category;


  const ProductModel({

    this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.color,
    required this.category,

});

  toJson(){
    return{
      "Name": name,
      "Description": description,
      "Image": image,
      "Color": color,
      "Category": category,
    };
  }
}