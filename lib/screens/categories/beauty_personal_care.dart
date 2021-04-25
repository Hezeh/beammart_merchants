import 'package:beammart_merchants/providers/category_tokens_provider.dart';
import 'package:beammart_merchants/providers/profile_provider.dart';
import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:beammart_merchants/utils/balance_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../enums/beauty_personal_care.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_upload_provider.dart';
import '../../utils/upload_files_util.dart';
import '../../utils/willpop_util.dart';
import '../tokens_screen.dart';

class BeautyPersonalCareScreen extends StatefulWidget {
  @override
  _BeautyPersonalCareScreenState createState() =>
      _BeautyPersonalCareScreenState();
}

class _BeautyPersonalCareScreenState extends State<BeautyPersonalCareScreen> {
  final _beautyPersonalCareFormKey = GlobalKey<FormState>();

  bool isExpanded = true;

  BeautyPersonalCare _beautyPersonalCare = BeautyPersonalCare.makeup;

  bool _loading = false;

  final String _category = 'Beauty and Personal Care';

  String _subCategory = 'Makeup';

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
              title: Text('Beauty & Personal Care'),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (_beautyPersonalCareFormKey.currentState!.validate()) {
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
                  ),
                ),
              ],
            ),
            body: Form(
              key: _beautyPersonalCareFormKey,
              child: ListView(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (int index, bool _isExpanded) {
                      isExpanded = !isExpanded;
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text('Beauty & Personal Care Subcategories'),
                          );
                        },
                        body: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text('Makeup'),
                              selectedColor: Colors.pink,
                              selected: _beautyPersonalCare ==
                                  BeautyPersonalCare.makeup,
                              onSelected: (bool selected) {
                                setState(() {
                                  _beautyPersonalCare =
                                      BeautyPersonalCare.makeup;
                                  _subCategory = 'Makeup';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Skin Care'),
                              selectedColor: Colors.pink,
                              selected: _beautyPersonalCare ==
                                  BeautyPersonalCare.skinCare,
                              onSelected: (bool selected) {
                                setState(() {
                                  _beautyPersonalCare =
                                      BeautyPersonalCare.skinCare;
                                  _subCategory = 'Skin Care';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Hair Care'),
                              selectedColor: Colors.pink,
                              selected: _beautyPersonalCare ==
                                  BeautyPersonalCare.hairCare,
                              onSelected: (bool selected) {
                                setState(() {
                                  _beautyPersonalCare =
                                      BeautyPersonalCare.hairCare;
                                  _subCategory = 'Hair Care';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Fragrance'),
                              selectedColor: Colors.pink,
                              selected: _beautyPersonalCare ==
                                  BeautyPersonalCare.fragrance,
                              onSelected: (bool selected) {
                                setState(() {
                                  _beautyPersonalCare =
                                      BeautyPersonalCare.fragrance;
                                  _subCategory = 'Fragrance';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Foot, Hand & Nail Care'),
                              selectedColor: Colors.pink,
                              selected: _beautyPersonalCare ==
                                  BeautyPersonalCare.footHandAndNailCare,
                              onSelected: (bool selected) {
                                setState(() {
                                  _beautyPersonalCare =
                                      BeautyPersonalCare.footHandAndNailCare;
                                  _subCategory = 'Foot, Hand and Nail Care';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Tools & Accessories'),
                              selectedColor: Colors.pink,
                              selected: _beautyPersonalCare ==
                                  BeautyPersonalCare.toolsAndAccessories,
                              onSelected: (bool selected) {
                                setState(() {
                                  _beautyPersonalCare =
                                      BeautyPersonalCare.toolsAndAccessories;
                                  _subCategory = 'Tools and Accessories';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Shave & Hair Removal'),
                              selectedColor: Colors.pink,
                              selected: _beautyPersonalCare ==
                                  BeautyPersonalCare.shaveAndHairRemoval,
                              onSelected: (bool selected) {
                                setState(() {
                                  _beautyPersonalCare =
                                      BeautyPersonalCare.shaveAndHairRemoval;
                                  _subCategory = 'Shave and Hair Removal';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Personal Care'),
                              selectedColor: Colors.pink,
                              selected: _beautyPersonalCare ==
                                  BeautyPersonalCare.personalCare,
                              onSelected: (bool selected) {
                                setState(() {
                                  _beautyPersonalCare =
                                      BeautyPersonalCare.personalCare;
                                  _subCategory = 'Personal Care';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Oral Care'),
                              selectedColor: Colors.pink,
                              selected: _beautyPersonalCare ==
                                  BeautyPersonalCare.oralCare,
                              onSelected: (bool selected) {
                                setState(() {
                                  _beautyPersonalCare =
                                      BeautyPersonalCare.oralCare;
                                  _subCategory = 'Oral Care';
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
