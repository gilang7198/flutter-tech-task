import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Ingredients> fetchIngredient() async{
  // print("$baseUrlFcm/sentMessage/history/$id?status=delivered");
  try {
    http.Response  response = await http.get("https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev/ingredients");
    final jsonData = json.decode(response.body);
    var data = {"ingredient" : jsonData};
    return Ingredients.fromJson(data);
  } catch (e) {
    print("error $e");
    return null;
  }
}

class Ingredients {
    List<Ingredient> ingredient;

    Ingredients({
        this.ingredient,
    });

    factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
        ingredient: json["ingredient"] == null ? null : List<Ingredient>.from(json["ingredient"].map((x) => Ingredient.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ingredient": ingredient == null ? null : List<dynamic>.from(ingredient.map((x) => x.toJson())),
    };
}

class Ingredient {
    String title;
    DateTime useBy;

    Ingredient({
        this.title,
        this.useBy,
    });

    factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        title: json["title"] == null ? null : json["title"],
        useBy: json["use-by"] == null ? null : DateTime.parse(json["use-by"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "use-by": useBy == null ? null : "${useBy.year.toString().padLeft(4, '0')}-${useBy.month.toString().padLeft(2, '0')}-${useBy.day.toString().padLeft(2, '0')}",
    };
}


// class Array {
//   var array =[
//     {
//       "title": "Ham",
//       "use-by": "2019-11-25"
//     },
//     {
//       "title": "Cheese",
//       "use-by": "2019-11-08"
//     },
//     {
//       "title": "Bread",
//       "use-by": "2019-11-01"
//     },
//     {
//       "title": "Butter",
//       "use-by": "2019-11-25"
//     },
//     {
//       "title": "Bacon",
//       "use-by": "2019-11-02"
//     },
//     {
//       "title": "Eggs",
//       "use-by": "2019-11-25"
//     },
//     {
//       "title": "Mushrooms",
//       "use-by": "2019-11-11"
//     },
//     {
//       "title": "Sausage",
//       "use-by": "2019-11-25"
//     },
//     {
//       "title": "Hotdog Bun",
//       "use-by": "2019-11-25"
//     },
//     {
//       "title": "Ketchup",
//       "use-by": "2019-11-11"
//     },
//     {
//       "title": "Mustard",
//       "use-by": "2019-11-10"
//     },
//     {
//       "title": "Lettuce",
//       "use-by": "2019-11-10"
//     },
//     {
//       "title": "Tomato",
//       "use-by": "2019-11-05"
//     },
//     {
//       "title": "Cucumber",
//       "use-by": "2019-11-05"
//     },
//     {
//       "title": "Beetroot",
//       "use-by": "2019-11-06"
//     },
//     {
//       "title": "Salad Dressing",
//       "use-by": "2019-11-06"
//     }
//   ];
// }