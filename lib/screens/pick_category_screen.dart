import 'dart:io';

import 'package:beammart_merchants/providers/category_tokens_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  Widget _subTitle(double? tokens) {
    return Row(
      children: [
        Icon(
          Icons.toll_outlined,
          color: Colors.yellow,
        ),
        SizedBox(
          width: 15,
        ),
        Text('$tokens')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final CategoryTokensProvider _tokensProvider =
        Provider.of<CategoryTokensProvider>(context);
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
                  settings: RouteSettings(name: 'ElectronicsScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Electronics',
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.electronicsTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ComputersScreen(),
                  settings: RouteSettings(name: 'ComputersScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Computers',
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.computersTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SmartHomeScreen(),
                  settings: RouteSettings(name: 'SmartHomeScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Smart Home',
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.smartHomeTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ArtsCraftsScreen(),
                  settings: RouteSettings(name: 'ArtsCraftsScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Arts & Crafts',
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.artCraftTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AutomotiveScreen(),
                  settings: RouteSettings(name: 'AutomotiveScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Automotive',
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.automotiveTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BabyScreen(),
                  settings: RouteSettings(name: 'BabyScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Baby',
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.babyTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BeautyPersonalCareScreen(),
                  settings: RouteSettings(name: 'BeautyPersonalCareScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Beauty & Personal Care',
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.beautyPersonalCareTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => WomensFashionScreen(),
                  settings: RouteSettings(name: 'WomensFashionScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Women's Fashion",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.womensFashionTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MensFashionScreen(),
                  settings: RouteSettings(name: 'MensFashionScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Men's Fashion",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.mensFashionTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HealthHouseholdScreen(),
                  settings: RouteSettings(name: 'HealthHouseholdScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Health & Household',
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.healthHouseholdTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HomeKitchenScreen(),
                  settings: RouteSettings(name: 'HomeKitchenScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Home & Kitchen",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.homeKitchenTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PatioGardenScreen(),
                  settings: RouteSettings(name: 'PatioGardenScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Patio & Garden",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.patioGardenTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => IndustrialScientificScreen(),
                  settings: RouteSettings(name: 'IndustrialScientificScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Industrial & Scientific",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.industrialScientificTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => LuggageScreen(),
                  settings: RouteSettings(name: 'LuggageScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Luggage",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.luggageTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PetSuppliesScreen(),
                  settings: RouteSettings(name: 'PetSuppliesScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Pet Supplies",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.petSuppliesTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SportsFitnessOutdoorsScreen(),
                  settings: RouteSettings(name: 'SportsFitnessOutdoorsScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Sports, Fitness & Outdoors",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.sportsFitnessOutdoorsTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ToolsHomeImprovementScreen(),
                  settings: RouteSettings(name: 'ToolsHomeImprovementScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Tools & Home Improvement",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.toolsHomeImprovementTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ToysGamesScreen(),
                  settings: RouteSettings(name: 'ToysGamesScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Toys & Games",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.toysGamesTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FoodScreen(),
                  settings: RouteSettings(name: 'FoodScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Food",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.foodTokens),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HouseholdEssentialsScreen(),
                  settings: RouteSettings(name: 'HouseholdEssentialsScreen'),
                ),
              ),
              child: ListTile(
                title: Text(
                  "Household Essentials",
                ),
                subtitle: _subTitle(_tokensProvider.categoryTokens!.householdEssentialsTokens),
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
