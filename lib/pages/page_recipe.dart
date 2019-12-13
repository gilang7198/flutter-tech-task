import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/components/provider.dart';
import 'package:tech_task/models/recipe_model.dart';
import 'package:tech_task/pages/page_home.dart';

class CartIngredient extends StatefulWidget {

  @override
  _CartIngredientState createState() => _CartIngredientState();
}

class _CartIngredientState extends State<CartIngredient> {
  String _ingredient = "";

  getIngredient() {
    final cartState = Provider.of<CartState>(context);
    for (int i=0; i<cartState.listIngredientSelected.length; i++) {
      _ingredient = _ingredient + cartState.listIngredientSelected[i].item.title + ",";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getIngredient();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = Provider.of<CartState>(context);
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: Icon(Icons.close, color: AppColors.primaryBlue),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Your Recipe",
                        style: TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 30.0,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          cartState.listIngredientSelected.clear();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Clear",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    "Happy cooking",
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontSize: 18.0,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 400,
                    child: FutureBuilder(
                      future: fetchRecipe(_ingredient),
                      builder: (context, snapshot) {
                        return snapshot.hasData ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.recipe.length, 
                          itemBuilder: (context, index) {
                            var data = snapshot.data.recipe[index];
                            return SizedBox(
                              width: 200,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 32, left: 8, right: 8, bottom: 16),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Color(0xFFFFB295)
                                                  .withOpacity(0.6),
                                              offset: Offset(1.1, 4.0),
                                              blurRadius: 8.0),
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(index % 3 != 0 ? index % 2 == 0 ? 0xFFFA7D82 : 0xFF738AE6 : 0xFFFE95B6),
                                            Color(index % 3 != 0 ? index % 2 == 0 ? 0xFFFFB295 : 0xFF5C5EDD : 0xFFFE95B6),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(54.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 54, left: 16, right: 16, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${data.title}",
                                              // textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Quicksand",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                letterSpacing: 0.2,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Text(
                                              "Ingredients :",
                                              // textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontFamily: "Quicksand",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                letterSpacing: 0.2,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 8, bottom: 8),
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: List.generate(data.ingredients.length,(index){
                                                      return Text(
                                                        "- ${data.ingredients[index]}",
                                                        style: TextStyle(
                                                          fontFamily: "Quicksand",
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18,
                                                          letterSpacing: 0.2,
                                                          color: Colors.white,
                                                        ),
                                                      );
                                                    }),
                                                  )
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: 84,
                                      height: 84,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFAFAFA).withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        ) : Center(child: CircularProgressIndicator());
                      },
                    ),
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}
