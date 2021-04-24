import 'package:beammart_merchants/providers/category_tokens_provider.dart';
import 'package:beammart_merchants/providers/profile_provider.dart';
import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:beammart_merchants/utils/balance_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../enums/smart_home.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_upload_provider.dart';
import '../../utils/upload_files_util.dart';
import '../../utils/willpop_util.dart';
import '../tokens_screen.dart';

class SmartHomeScreen extends StatefulWidget {
  @override
  _SmartHomeScreenState createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
  SmartHome _smartHome = SmartHome.cameras;

  bool isExpanded = true;

  final _smartHomeFormKey = GlobalKey<FormState>();

  bool _loading = false;

  final String _category = 'Smart Home';

  String _subCategory = 'Cameras';

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
              title: Text('Smart Home'),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (_smartHomeFormKey.currentState!.validate()) {
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
              key: _smartHomeFormKey,
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
                            title: Text('Smart Home Subcategories'),
                          );
                        },
                        body: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text('Cameras'),
                              selectedColor: Colors.pink,
                              selected: _smartHome == SmartHome.cameras,
                              onSelected: (bool selected) {
                                setState(() {
                                  _smartHome = SmartHome.cameras;
                                  _subCategory = 'Cameras';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Lighting'),
                              selectedColor: Colors.pink,
                              selected: _smartHome == SmartHome.lighting,
                              onSelected: (bool selected) {
                                setState(() {
                                  _smartHome = SmartHome.lighting;
                                  _subCategory = 'Lighting';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Door Locks'),
                              selectedColor: Colors.pink,
                              selected: _smartHome == SmartHome.doorLocks,
                              onSelected: (bool selected) {
                                setState(() {
                                  _smartHome = SmartHome.doorLocks;
                                  _subCategory = 'Door Locks';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Plugs'),
                              selectedColor: Colors.pink,
                              selected: _smartHome == SmartHome.plugs,
                              onSelected: (bool selected) {
                                setState(() {
                                  _smartHome = SmartHome.plugs;
                                  _subCategory = 'Plugs';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Thermostats'),
                              selectedColor: Colors.pink,
                              selected: _smartHome == SmartHome.thermostats,
                              onSelected: (bool selected) {
                                setState(() {
                                  _smartHome = SmartHome.thermostats;
                                  _subCategory = 'Thermostats';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Security Systems'),
                              selectedColor: Colors.pink,
                              selected: _smartHome == SmartHome.securitySystems,
                              onSelected: (bool selected) {
                                setState(() {
                                  _smartHome = SmartHome.securitySystems;
                                  _subCategory = 'Security Systems';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Speakers'),
                              selectedColor: Colors.pink,
                              selected: _smartHome == SmartHome.speakers,
                              onSelected: (bool selected) {
                                setState(() {
                                  _smartHome = SmartHome.speakers;
                                  _subCategory = 'Speakers';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Voice Assistants'),
                              selectedColor: Colors.pink,
                              selected: _smartHome == SmartHome.voiceAssistants,
                              onSelected: (bool selected) {
                                setState(() {
                                  _smartHome = SmartHome.voiceAssistants;
                                  _subCategory = 'Voice Assistants';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Vacuums'),
                              selectedColor: Colors.pink,
                              selected: _smartHome == SmartHome.vacuums,
                              onSelected: (bool selected) {
                                setState(() {
                                  _smartHome = SmartHome.vacuums;
                                  _subCategory = 'Vacuums';
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
