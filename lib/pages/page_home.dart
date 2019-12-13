import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/components/provider.dart';
import 'package:tech_task/models/ingredient_model.dart';
import 'package:tech_task/pages/page_recipe.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const primaryBlack = const Color(0xFF313544);
  static const primaryBlue = const Color(0xFF272F5F);
  static const secondaryColor = const Color(0xFFFF8C33);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ingredient = "";
  String selected = "";

  @override
  Widget build(BuildContext context) {
    final cartState = Provider.of<CartState>(context);
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
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
                  Text(
                    "MyFridge",
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontSize: 30.0,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    "Choose your ingredient",
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
                      future: fetchIngredient(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData ? ListView.builder(
                          itemCount: snapshot.data.ingredient.length,
                          itemBuilder: (context, position) {
                            bool selected = false;
                            int index;
                            for(int i = 0; i < cartState.listIngredientSelected.length; i++){
                              if(cartState.listIngredientSelected[i].item.title == snapshot.data.ingredient[position].title){
                                index = i;
                                selected = true;
                                break;
                              }
                            }
                            return GestureDetector(
                              onTap: snapshot.data.ingredient[position].useBy.difference(DateTime.now()).inDays < 0 ? () {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('This ingredient is exipred'))
                                );
                              } : selected ? () {
                                print(cartState.listIngredientSelected);
                                setState(() {
                                  cartState.listIngredientSelected.removeAt(index);
                                });
                              } : () => cartState.tambahItem(snapshot.data.ingredient[position]),
                              child: Card(
                                elevation: 3.0,
                                color: selected ? Colors.lightBlue : Colors.white,
                                child: ListTile(
                                  title: Text(
                                    snapshot.data.ingredient[position].title,
                                    style: TextStyle(
                                      color: selected ? Colors.white : Colors.black87
                                    ),
                                  ),
                                  subtitle: snapshot.data.ingredient[position].useBy.difference(DateTime.now()).inDays < 0 ? 
                                  Text(
                                    "Expired at ${DateFormat.yMMMd().format(snapshot.data.ingredient[position].useBy)}",
                                    // snapshot.data.ingredient[position].useBy.toString(),
                                    style: TextStyle(
                                      color: Colors.red
                                    ),
                                  ) :
                                  Text(
                                    "Expired at ${DateFormat.yMMMd().format(snapshot.data.ingredient[position].useBy)}",
                                    // snapshot.data.ingredient[position].useBy.toString(),
                                    style: TextStyle(
                                      color: selected ? Colors.white : Colors.black54
                                    ),
                                  )
                                  ,
                                  trailing: selected ? Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                    size: 40,
                                  ) : null
                                ),
                              ),
                            );
                          }
                        ) : Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.secondaryColor,
        child: Container(
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            padding: EdgeInsets.all(16.0),
            onPressed: () {
              // Navigator.pushNamed(context, routes.manageViewRoute);
              // print("masookk");
              Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => CartIngredient()
                )
              );
            },
            color: AppColors.secondaryColor,
            child: Text(
              "Get Receipe",
              style: TextStyle(
                fontFamily: "Quicksand",
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Ingredient item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    int index;
    var cart = Provider.of<CartState>(context);
    for(int i = 0; i < cart.listIngredientSelected.length; i++){
      if(cart.listIngredientSelected[i].item.title == item.title){
        index = i;
        selected = true;
        break;
      }
    }

    return selected ? FlatButton(
      // onPressed: cart.listIngredientSelected.contains(item) ? null : () => cart.tambahItem(item),
      // onPressed: selected ? null : () => cart.tambahItem(item),
      onPressed: () {
        print(cart.listIngredientSelected);
        // setState(() {
                    cart.listIngredientSelected.removeAt(index);
                  // });
      },
      splashColor: Theme.of(context).primaryColor,
      child: selected
          ? Icon(Icons.check, semanticLabel: 'ADDED')
          : Text('ADD'),
    ) : 
    FlatButton(
      // onPressed: cart.listIngredientSelected.contains(item) ? null : () => cart.tambahItem(item),
      // onPressed: selected ? null : () => cart.tambahItem(item),
      onPressed: () {
        print(cart.listIngredientSelected);
        // setState(() {
                    cart.listIngredientSelected.removeAt(index);
                  // });
      },
      splashColor: Theme.of(context).primaryColor,
      child: selected
          ? Icon(Icons.check, semanticLabel: 'ADDED')
          : Text('ADD'),
    );
  }
}
