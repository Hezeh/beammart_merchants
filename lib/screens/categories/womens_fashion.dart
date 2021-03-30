import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../enums/womens_fashion.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_upload_provider.dart';
import '../../utils/upload_files_util.dart';
import '../../utils/willpop_util.dart';

class WomensFashionScreen extends StatefulWidget {
  @override
  _WomensFashionScreenState createState() => _WomensFashionScreenState();
}

class _WomensFashionScreenState extends State<WomensFashionScreen> {
  bool isExpanded = true;

  final _womensFashionFormKey = GlobalKey<FormState>();

  WomensFashion _womensFashion = WomensFashion.accessories;

  bool _loading = false;

  final String _category = "Women's Fashion";

  String _subCategory = 'Accessories';

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
              title: Text("Women's Fashion"),
              actions: [
                FlatButton(
                  onPressed: () {
                    if (_womensFashionFormKey.currentState!.validate() &&
                        _subCategory != null) {
                      setState(() {
                        _loading = true;
                      });
                      if (_imageUrls != null) {
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
                        setState(() {
                          _loading = false;
                        });
                        _imageUploadProvider.deleteImageUrls();
                      }
                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.pink,
                    ),
                  ),
                )
              ],
            ),
            body: Form(
              key: _womensFashionFormKey,
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
                            title: Text("Women's Fashion Subcategories"),
                          );
                        },
                        body: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text('Accessories'),
                              selectedColor: Colors.pink,
                              selected:
                                  _womensFashion == WomensFashion.accessories,
                              onSelected: (bool selected) {
                                setState(() {
                                  _womensFashion = WomensFashion.accessories;
                                  _subCategory = 'Accessories';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Clothing'),
                              selectedColor: Colors.pink,
                              selected:
                                  _womensFashion == WomensFashion.clothing,
                              onSelected: (bool selected) {
                                setState(() {
                                  _womensFashion = WomensFashion.clothing;
                                  _subCategory = 'Clothing';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Shoes'),
                              selectedColor: Colors.pink,
                              selected: _womensFashion == WomensFashion.shoes,
                              onSelected: (bool selected) {
                                setState(() {
                                  _womensFashion = WomensFashion.shoes;
                                  _subCategory = 'Shoes';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Jewelry'),
                              selectedColor: Colors.pink,
                              selected: _womensFashion == WomensFashion.jewelry,
                              onSelected: (bool selected) {
                                setState(() {
                                  _womensFashion = WomensFashion.jewelry;
                                  _subCategory = 'Jewerly';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Watches'),
                              selectedColor: Colors.pink,
                              selected: _womensFashion == WomensFashion.watches,
                              onSelected: (bool selected) {
                                setState(() {
                                  _womensFashion = WomensFashion.watches;
                                  _subCategory = 'Watches';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Handbags'),
                              selectedColor: Colors.pink,
                              selected:
                                  _womensFashion == WomensFashion.handbags,
                              onSelected: (bool selected) {
                                setState(() {
                                  _womensFashion = WomensFashion.handbags;
                                  _subCategory = 'Handbags';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Bras, Panties & Lingerie'),
                              selectedColor: Colors.pink,
                              selected: _womensFashion ==
                                  WomensFashion.brasPantiesAndLingerie,
                              onSelected: (bool selected) {
                                setState(() {
                                  _womensFashion =
                                      WomensFashion.brasPantiesAndLingerie;
                                  _subCategory = 'Bras, Panties and Lingerie';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Pajamas & Loungewear'),
                              selectedColor: Colors.pink,
                              selected: _womensFashion ==
                                  WomensFashion.pajamasAndLoungewear,
                              onSelected: (bool selected) {
                                setState(() {
                                  _womensFashion =
                                      WomensFashion.pajamasAndLoungewear;
                                  _subCategory = 'Pajamas and Loungewear';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Maternity'),
                              selectedColor: Colors.pink,
                              selected:
                                  _womensFashion == WomensFashion.maternity,
                              onSelected: (bool selected) {
                                setState(() {
                                  _womensFashion = WomensFashion.maternity;
                                  _subCategory = 'Maternity';
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