import 'dart:io';

import 'package:flutter/material.dart';
import '../screens/categories/art_craft_screen.dart';
import '../screens/categories/automotive.dart';
import '../screens/categories/baby.dart';
import '../screens/categories/beauty_personal_care.dart';
import '../screens/categories/computers.dart';
import '../screens/categories/food.dart';
import '../screens/categories/health_household.dart';
import '../screens/categories/home_kitchen.dart';
import '../screens/categories/household_essentials.dart';
import '../screens/categories/industrial_scientific.dart';
import '../screens/categories/luggage.dart';
import '../screens/categories/mens_fashion.dart';
import '../screens/categories/patio_garden.dart';
import '../screens/categories/pet_supplies.dart';
import '../screens/categories/smart_home.dart';
import '../screens/categories/sports_fitness_outdoors.dart';
import '../screens/categories/tools_home_improvement.dart';
import '../screens/categories/toys_games.dart';
import '../screens/categories/womens_fashion.dart';
import '../utils/willpop_util.dart';
import '../screens/categories/electronics_screen.dart';

class PickCategory extends StatelessWidget {
  final List<File>? images;

  const PickCategory({Key? key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final  user = Provider.of<AuthServiceProvider>(context).user.userId;
    return WillPopScope(
      onWillPop: () => onCategoryWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pick Category',
          ),
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ElectronicsScreen(),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Electronics',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ComputersScreen(),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Computers',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SmartHomeScreen()),
              ),
              child: ListTile(
                title: Text(
                  'Smart Home',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ArtsCraftsScreen()),
              ),
              child: ListTile(
                title: Text(
                  'Arts & Crafts',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AutomotiveScreen()),
              ),
              child: ListTile(
                title: Text(
                  'Automotive',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => BabyScreen()),
              ),
              child: ListTile(
                title: Text(
                  'Baby',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => BeautyPersonalCareScreen()),
              ),
              child: ListTile(
                title: Text(
                  'Beauty & Personal Care',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => WomensFashionScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Women's Fashion",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MensFashionScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Men's Fashion",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => HealthHouseholdScreen()),
              ),
              child: ListTile(
                title: Text(
                  'Health & Household',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => HomeKitchenScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Home & Kitchen",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PatioGardenScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Patio & Garden",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => IndustrialScientificScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Industrial & Scientific",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => LuggageScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Luggage",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PetSuppliesScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Pet Supplies",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SportsFitnessOutdoorsScreen())),
              child: ListTile(
                title: Text(
                  "Sports, Fitness & Outdoors",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ToolsHomeImprovementScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Tools & Home Imporvement",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ToysGamesScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Toys & Games",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => FoodScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Food",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => HouseholdEssentialsScreen()),
              ),
              child: ListTile(
                title: Text(
                  "Household Essentials",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
