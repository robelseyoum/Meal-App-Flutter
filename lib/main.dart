import 'package:flutter/material.dart';
import 'package:meal_shop/dummy_data.dart';
import 'package:meal_shop/models/meal.dart';
import 'package:meal_shop/screens/category_meals_detial_screen.dart';
import 'package:meal_shop/screens/filiters_screen.dart';
import 'package:meal_shop/screens/meal_detail_screen.dart';
import 'package:meal_shop/screens/tabs_screen.dart';

import 'screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Meal> _availableMeals = DUMMY_MEALS;

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  //we have to pass false if don't want to include certain item in the new generated list
  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
        
        if(_filters['lactose'] && !meal.isGlutenFree){
          return false;
        } 
        
        if(_filters['vegan'] && !meal.isGlutenFree){
          return false;
        }
        
        if(_filters['vegetarian'] && !meal.isGlutenFree){
          return false;
        }
        
        return true;
        
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          body2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          title: TextStyle(
            fontSize: 22,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          )
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(),
        CategoryMealsScreen.routeName: (cxt) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (cxt) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}


