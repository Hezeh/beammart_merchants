import 'package:beammart_merchants/providers/category_tokens_provider.dart';
import 'package:beammart_merchants/providers/profile_provider.dart';
import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:beammart_merchants/utils/balance_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../enums/patio_garden.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_upload_provider.dart';
import '../../utils/upload_files_util.dart';
import '../../utils/willpop_util.dart';
import '../tokens_screen.dart';

class PatioGardenScreen extends StatefulWidget {
  @override
  _PatioGardenScreenState createState() => _PatioGardenScreenState();
}

class _PatioGardenScreenState extends State<PatioGardenScreen> {
  PatioGarden _patioGarden = PatioGarden.garden;

  bool isExpanded = true;

  final _patioGardenFormKey = GlobalKey<FormState>();

  bool _loading = false;

  final String _category = 'Patio and Garden';

  String _subCategory = 'Garden';

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
              title: Text('Patio & Garden'),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (_patioGardenFormKey.currentState!.validate()) {
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
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              ],
            ),
            body: Form(
              key: _patioGardenFormKey,
              child: ListView(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (panelIndex, _isExpanded) {
                      isExpanded = !isExpanded;
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text('Patio & Garden Subcategories'),
                          );
                        },
                        body: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text('Garden'),
                              selected: _patioGarden == PatioGarden.garden,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _patioGarden = PatioGarden.garden;
                                  _subCategory = 'Garden';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Patio Furniture'),
                              selected:
                                  _patioGarden == PatioGarden.patioFurniture,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _patioGarden = PatioGarden.patioFurniture;
                                  _subCategory = 'Patio Furniture';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Grills & Outdoor Cooking'),
                              selected: _patioGarden ==
                                  PatioGarden.grillsAndOutdoorCooking,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _patioGarden =
                                      PatioGarden.grillsAndOutdoorCooking;
                                  _subCategory = 'Grills and Outdoor Cooking';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Outdoor Decor'),
                              selected:
                                  _patioGarden == PatioGarden.outdoorDecor,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _patioGarden = PatioGarden.outdoorDecor;
                                  _subCategory = 'Outdoor Decor';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Sheds & Outdoor Storage'),
                              selected: _patioGarden ==
                                  PatioGarden.shedsAndOutdoorStorage,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _patioGarden =
                                      PatioGarden.shedsAndOutdoorStorage;
                                  _subCategory = 'Sheds and Outdoor Storage';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Outdoor Heating'),
                              selected:
                                  _patioGarden == PatioGarden.outdoorHeating,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _patioGarden = PatioGarden.outdoorHeating;
                                  _subCategory = 'Outdoor Heating';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Outdoor Shade'),
                              selected:
                                  _patioGarden == PatioGarden.outdoorShade,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _patioGarden = PatioGarden.outdoorShade;
                                  _subCategory = 'Outdoor Shade';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Outdoor Lighting'),
                              selected:
                                  _patioGarden == PatioGarden.outdoorLighting,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _patioGarden = PatioGarden.outdoorLighting;
                                  _subCategory = 'Outdoor Lighting';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Plants, Flowers & Trees'),
                              selected: _patioGarden ==
                                  PatioGarden.plantsFlowersAndTrees,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _patioGarden =
                                      PatioGarden.plantsFlowersAndTrees;
                                  _subCategory = 'Plants, Flowers and Trees';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Outdoor Power Equipment'),
                              selected: _patioGarden ==
                                  PatioGarden.outdoorPowerEquipment,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _patioGarden =
                                      PatioGarden.outdoorPowerEquipment;
                                  _subCategory = 'Outdoor Power Equipment';
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
