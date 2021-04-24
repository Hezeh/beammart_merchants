import 'dart:io';

import 'package:beammart_merchants/providers/category_tokens_provider.dart';
import 'package:beammart_merchants/providers/profile_provider.dart';
import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:beammart_merchants/screens/tokens_screen.dart';
import 'package:beammart_merchants/utils/balance_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../enums/electronics.dart';
import '../../providers/image_upload_provider.dart';
import '../../utils/upload_files_util.dart';
import '../../utils/willpop_util.dart';

class ElectronicsScreen extends StatefulWidget {
  final List<File>? images;

  const ElectronicsScreen({Key? key, this.images}) : super(key: key);

  @override
  _ElectronicsScreenState createState() => _ElectronicsScreenState();
}

class _ElectronicsScreenState extends State<ElectronicsScreen> {
  Electronics _electronics = Electronics.cameraAndPhoto;

  bool isExpanded = true;

  final _electronicsFormKey = GlobalKey<FormState>();

  bool _loading = false;

  final String _category = 'Electronics';

  String _subCategory = 'Camera and Photo';

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
    // final _userId = Provider.of<AuthenticationProvider>(context).user!.uid;
    final _userId = FirebaseAuth.instance.currentUser!.uid;
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
              title: Text("Electronics"),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (_electronicsFormKey.currentState!.validate()) {
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
              key: _electronicsFormKey,
              child: ListView(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (int index, bool _isExpanded) {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text('Electronics Subcategories'),
                          );
                        },
                        body: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text('Camera & Photo'),
                              selectedColor: Colors.pink,
                              selected:
                                  _electronics == Electronics.cameraAndPhoto,
                              onSelected: (bool selected) {
                                setState(() {
                                  _electronics = Electronics.cameraAndPhoto;
                                  _subCategory = 'Camera and Photo';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Car & Vehicle Electronics'),
                              selected: _electronics ==
                                  Electronics.carAndVehicleElectronics,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _electronics =
                                      Electronics.carAndVehicleElectronics;
                                  _subCategory = 'Car and Vehicle Electronis';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Smartphones'),
                              selected: _electronics == Electronics.smartPhones,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _electronics = Electronics.smartPhones;
                                  _subCategory = 'Smartphones';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Headphones'),
                              selected: _electronics == Electronics.headPhones,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _electronics = Electronics.headPhones;
                                  _subCategory = 'Headphones';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Home Audio'),
                              selected: _electronics == Electronics.homeAudio,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _electronics = Electronics.homeAudio;
                                  _subCategory = 'Home Audio';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Office Electronics'),
                              selected:
                                  _electronics == Electronics.officeElectronics,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _electronics = Electronics.officeElectronics;
                                  _subCategory = 'Office Electronics';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Security & Surveillance'),
                              selected: _electronics ==
                                  Electronics.securityAndSurvillance,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _electronics =
                                      Electronics.securityAndSurvillance;
                                  _subCategory = 'Security and Surveillance';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Television'),
                              selected: _electronics == Electronics.television,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _electronics = Electronics.television;
                                  _subCategory = 'Television';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Video Game Consoles'),
                              selected:
                                  _electronics == Electronics.videGameConsoles,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _electronics = Electronics.videGameConsoles;
                                  _subCategory = 'Video Game Consoles';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Wearable Technology'),
                              selected: _electronics ==
                                  Electronics.wearableTechnology,
                              selectedColor: Colors.pink,
                              onSelected: (bool selected) {
                                setState(() {
                                  _electronics = Electronics.wearableTechnology;
                                  _subCategory = 'Wearable Technology';
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
