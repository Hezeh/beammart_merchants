import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../enums/tools_home_improvement.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_upload_provider.dart';
import '../../utils/upload_files_util.dart';
import '../../utils/willpop_util.dart';

class ToolsHomeImprovementScreen extends StatefulWidget {
  @override
  _ToolsHomeImprovementScreenState createState() =>
      _ToolsHomeImprovementScreenState();
}

class _ToolsHomeImprovementScreenState
    extends State<ToolsHomeImprovementScreen> {
  bool isExpanded = true;

  ToolsHomeImprovement _toolsHomeImprovement = ToolsHomeImprovement.airQuality;

  final _toolsHomeImprovementFormKey = GlobalKey<FormState>();

  bool _loading = false;

  final String _category = 'Tools and Home Improvement';

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
    final _userId = Provider.of<AuthenticationProvider>(context).user.uid;
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
              title: Text('Tools & Home Improvement'),
              actions: [
                FlatButton(
                  onPressed: () {
                    if (_toolsHomeImprovementFormKey.currentState.validate() &&
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
                ),
              ],
            ),
            body: Form(
              key: _toolsHomeImprovementFormKey,
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
                            title:
                                Text('Tools & Home Improvement Subcategories'),
                          );
                        },
                        body: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text('Air Quality'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.airQuality,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.airQuality;
                                  _subCategory = 'Air Quality';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Building Supplies'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.buildingSupplies,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.buildingSupplies;
                                  _subCategory = 'Building Supplies';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Windows'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.windows,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.windows;
                                  _subCategory = 'Windows';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Heating'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.heating,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.heating;
                                  _subCategory = 'Heating';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Appliances'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.appliances,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.appliances;
                                  _subCategory = 'Appliances';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Electrical'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.electrical,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.electrical;
                                  _subCategory = 'Electrical';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Hardware'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.hardware,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.hardware;
                                  _subCategory = 'Hardware';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Kitchen & Bath Fixtures'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.kitchenAndBathFixtures,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement = ToolsHomeImprovement
                                      .kitchenAndBathFixtures;
                                  _subCategory = 'Kitchen and Batch Fixtures';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Light Bulbs'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.lightBulbs,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.lightBulbs;
                                  _subCategory = 'Light Bulbs';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Lighting & Ceiling Fans'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.lightningAndCeilingFans,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement = ToolsHomeImprovement
                                      .lightningAndCeilingFans;
                                  _subCategory = 'Lighting and Ceiling Fans';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Measuring & Layout Tools'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.measuringAndLayoutTools,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement = ToolsHomeImprovement
                                      .measuringAndLayoutTools;
                                  _subCategory = 'Measuring and Layout Tools';
                                });
                              },
                            ),
                            ChoiceChip(
                              label:
                                  Text('Painting Supplies & Wall Treatments'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement
                                      .paintingSuppliesAndWallTreatments,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement = ToolsHomeImprovement
                                      .paintingSuppliesAndWallTreatments;
                                  _subCategory =
                                      'Painting Supplies and Wall Treatments';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Power & Hand Tools'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.powerAndHandTools,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.powerAndHandTools;
                                  _subCategory = 'Power and Hand Tools';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Rough Plumbing'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.roughPlumbing,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.roughPlumbing;
                                  _subCategory = 'Rough Plumbing';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Safety & Security'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.safetyAndSecurity,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.safetyAndSecurity;
                                  _subCategory = 'Safety and Security';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Storage & Home Organization'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement
                                      .storageAndHomeOrganization,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement = ToolsHomeImprovement
                                      .storageAndHomeOrganization;
                                  _subCategory =
                                      'Storage and Home Organization';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Welding & Soldering'),
                              selectedColor: Colors.pink,
                              selected: _toolsHomeImprovement ==
                                  ToolsHomeImprovement.weldingAndSoldering,
                              onSelected: (bool selected) {
                                setState(() {
                                  _toolsHomeImprovement =
                                      ToolsHomeImprovement.weldingAndSoldering;
                                  _subCategory = 'Welding and Soldering';
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
                        if (value.isEmpty) {
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
                        if (value.isEmpty) {
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
                        if (value.isEmpty) {
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