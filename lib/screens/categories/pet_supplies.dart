import 'package:beammart_merchants/providers/category_tokens_provider.dart';
import 'package:beammart_merchants/providers/profile_provider.dart';
import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:beammart_merchants/utils/balance_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../enums/pet_supplies.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_upload_provider.dart';
import '../../utils/upload_files_util.dart';
import '../../utils/willpop_util.dart';
import '../tokens_screen.dart';

class PetSuppliesScreen extends StatefulWidget {
  @override
  _PetSuppliesScreenState createState() => _PetSuppliesScreenState();
}

class _PetSuppliesScreenState extends State<PetSuppliesScreen> {
  PetSupplies _petSupplies = PetSupplies.dogs;

  bool isExpanded = true;

  final _petSuppliesFormKey = GlobalKey<FormState>();

  bool _loading = false;

  final String _category = 'Pet Supplies';

  String _subCategory = 'Dogs';

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
              title: Text('Pet Supplies'),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (_petSuppliesFormKey.currentState!.validate()) {
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
                  ),
                ),
              ],
            ),
            body: Form(
              key: _petSuppliesFormKey,
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
                            title: Text('Pet Supplies Subcategories'),
                          );
                        },
                        body: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text('Dogs'),
                              selected: _petSupplies == PetSupplies.dogs,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _petSupplies = PetSupplies.dogs;
                                  _subCategory = 'Dogs';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Cats'),
                              selected: _petSupplies == PetSupplies.cats,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _petSupplies = PetSupplies.cats;
                                  _subCategory = 'Cats';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Fish & Aquatic Pets'),
                              selected: _petSupplies ==
                                  PetSupplies.fishAndAquaticPets,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _petSupplies = PetSupplies.fishAndAquaticPets;
                                  _subCategory = 'Fish and Aquatic Pets';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Birds'),
                              selected: _petSupplies == PetSupplies.birds,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _petSupplies = PetSupplies.birds;
                                  _subCategory = 'Birds';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Horses'),
                              selected: _petSupplies == PetSupplies.horses,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _petSupplies = PetSupplies.horses;
                                  _subCategory = 'Horses';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Reptiles & Amphibians'),
                              selected: _petSupplies ==
                                  PetSupplies.reptilesAndAmphibians,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _petSupplies =
                                      PetSupplies.reptilesAndAmphibians;
                                  _subCategory = 'Reptiles and Amphibians';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Small Animals'),
                              selected:
                                  _petSupplies == PetSupplies.smallAnimals,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _petSupplies = PetSupplies.smallAnimals;
                                  _subCategory = 'Small Animals';
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
