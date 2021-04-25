import 'package:beammart_merchants/providers/category_tokens_provider.dart';
import 'package:beammart_merchants/providers/profile_provider.dart';
import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:beammart_merchants/utils/balance_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../enums/food.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_upload_provider.dart';
import '../../utils/upload_files_util.dart';
import '../../utils/willpop_util.dart';
import '../tokens_screen.dart';

class FoodScreen extends StatefulWidget {
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  Food _food = Food.baking;

  bool isExpanded = true;

  final _foodFormKey = GlobalKey<FormState>();

  bool _loading = false;

  final String _category = 'Food';

  String _subCategory = 'Baking';

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  bool _inStock = true;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _userId = Provider.of<AuthenticationProvider>(context).user!.uid;
    final _imageUrls = Provider.of<ImageUploadProvider>(context).imageUrls;
    final _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    final _categoryTokensProvider =
        Provider.of<CategoryTokensProvider>(context);
    final _profileProvider = Provider.of<ProfileProvider>(context);
    final _subsProvider = Provider.of<SubscriptionsProvider>(context);
    return (_loading)
        ? WillPopScope(
            onWillPop: () => onWillPop(context),
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text('Uploading...'),
                centerTitle: true,
              ),
              body: LinearProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Food'),
              actions: [
                TextButton(
                    onPressed: () async {
                      if (_foodFormKey.currentState!.validate()) {
                        setState(() {
                          _loading = true;
                        });

                        if (_profileProvider.profile!.tokensBalance != null &&
                            _categoryTokensProvider
                                    .categoryTokens!.electronicsTokens !=
                                null) {
                          final double requiredTokens = _categoryTokensProvider
                              .categoryTokens!.electronicsTokens!;
                          final bool _hasTokens =
                              await checkBalance(_userId, requiredTokens);
                          if (_hasTokens) {
                            saveItemFirestore(
                              context,
                              _userId,
                              Item(
                                category: _category,
                                subCategory: _subCategory,
                                images: _imageUrls,
                                title: _titleController.text,
                                description: _descriptionController.text,
                                price: double.parse(_priceController.text),
                                dateAdded: DateTime.now(),
                                dateModified: DateTime.now(),
                                inStock: _inStock,
                                lastRenewal: DateTime.now(),
                                isActive: true,
                              ).toJson(),
                            );
                            _imageUploadProvider.deleteImageUrls();
                            _subsProvider.consume(requiredTokens);
                            setState(() {
                              _loading = false;
                            });
                          } else {
                            setState(() {
                              _loading = false;
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => TokensScreen(),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.pink,
                      ),
                    ))
              ],
            ),
            body: Form(
              key: _foodFormKey,
              child: ListView(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (panelIndex, _isExpanded) {
                      isExpanded = !isExpanded;
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text('Food Subcategories'),
                          );
                        },
                        body: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text('Baking'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.baking,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.baking;
                                  _subCategory = 'Baking';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Breakfast & Cereal'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.breakfastAndCereal,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.breakfastAndCereal;
                                  _subCategory = 'Breakfast and Cereal';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Beverages'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.beverages,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.beverages;
                                  _subCategory = 'Beverages';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Snacks'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.snacks,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.snacks;
                                  _subCategory = 'Snacks';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Food Gifts'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.foodGifts,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.foodGifts;
                                  _subCategory = 'Food Gifts';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Candy & Gums'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.candyAndGums,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.candyAndGums;
                                  _subCategory = 'Candy and Gums';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Meals'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.meals,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.meals;
                                  _subCategory = 'Meals';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Condiments'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.condiments,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.condiments;
                                  _subCategory = 'Condiments';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Gluten Free Foods'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.glutenFreeFoods,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.glutenFreeFoods;
                                  _subCategory = 'Gluten Free Foods';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Plant Based Foods'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.plantBasedFoods,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.plantBasedFoods;
                                  _subCategory = 'Plant Based Foods';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Christmas Candy'),
                              selectedColor: Colors.pink,
                              selected: _food == Food.christmasCandy,
                              onSelected: (bool selected) {
                                setState(() {
                                  _food = Food.christmasCandy;
                                  _subCategory = 'Christmas Candy';
                                });
                              },
                            ),
                          ],
                        ),
                        isExpanded: isExpanded,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _titleController,
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a title";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Title (required)',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a description";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Description (required)',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a price";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Price (required)',
                      ),
                    ),
                  ),
                  MergeSemantics(
                    child: ListTile(
                      title: Text('Item in Stock'),
                      trailing: CupertinoSwitch(
                        value: _inStock,
                        onChanged: (bool value) {
                          setState(() {
                            _inStock = value;
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _inStock = !_inStock;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
