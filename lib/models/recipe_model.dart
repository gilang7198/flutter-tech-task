import 'package:http/http.dart' as http;
import 'dart:convert';

Future<AllRecipe> fetchRecipe(String ingredient) async{
  try {
    http.Response  response = await http.get("https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev/recipes?ingredients=$ingredient");
    final jsonData = json.decode(response.body);
    var data = {"recipe" : jsonData};
    return AllRecipe.fromJson(data);
  } catch (e) {
    print("error $e");
    return null;
  }
}

class AllRecipe {
    List<Recipe> recipe;

    AllRecipe({
        this.recipe,
    });

    factory AllRecipe.fromJson(Map<String, dynamic> json) => AllRecipe(
        recipe: json["recipe"] == null ? null : List<Recipe>.from(json["recipe"].map((x) => Recipe.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "recipe": recipe == null ? null : List<dynamic>.from(recipe.map((x) => x.toJson())),
    };
}

class Recipe {
    String title;
    List<String> ingredients;

    Recipe({
        this.title,
        this.ingredients,
    });

    factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        title: json["title"] == null ? null : json["title"],
        ingredients: json["ingredients"] == null ? null : List<String>.from(json["ingredients"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "ingredients": ingredients == null ? null : List<dynamic>.from(ingredients.map((x) => x)),
    };
}