import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../enums/computers.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_upload_provider.dart';
import '../../utils/upload_files_util.dart';
import '../../utils/willpop_util.dart';

class ComputersScreen extends StatefulWidget {
  @override
  _ComputersScreenState createState() => _ComputersScreenState();
}

class _ComputersScreenState extends State<ComputersScreen> {
  Computers _computers = Computers.computerAccessories;

  bool isExpanded = true;

  final _computersFormKey = GlobalKey<FormState>();

  bool _loading = false;

  final String _category = 'Computers';

  String _subCategory = 'Computers and Accessories';

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
              title: Text('Computers'),
              actions: [
                FlatButton(
                  onPressed: () {
                    if (_computersFormKey.currentState!.validate() &&
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
              key: _computersFormKey,
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
                            title: Text('Computers Subcategories'),
                          );
                        },
                        body: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text('Computers & Accessories'),
                              selectedColor: Colors.pink,
                              selected:
                                  _computers == Computers.computerAccessories,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.computerAccessories;
                                  _subCategory = 'Computers and Accessories';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Computer Components'),
                              selectedColor: Colors.pink,
                              selected:
                                  _computers == Computers.computerComponents,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.computerComponents;
                                  _subCategory = 'Computer Components';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Data Storage'),
                              selectedColor: Colors.pink,
                              selected: _computers == Computers.dataStorage,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.dataStorage;
                                  _subCategory = 'Data Storage';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('External Components'),
                              selectedColor: Colors.pink,
                              selected:
                                  _computers == Computers.externalComponents,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.externalComponents;
                                  _subCategory = 'External Components';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Laptops & Accessories'),
                              selectedColor: Colors.pink,
                              selected:
                                  _computers == Computers.laptopAccessories,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.laptopAccessories;
                                  _subCategory = 'Laptops and Accessories';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Monitors'),
                              selectedColor: Colors.pink,
                              selected: _computers == Computers.monitors,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.monitors;
                                  _subCategory = 'Monitors';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Networking Products'),
                              selectedColor: Colors.pink,
                              selected:
                                  _computers == Computers.networkinProducts,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.networkinProducts;
                                  _subCategory = 'Networking Products';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Power Strips'),
                              selectedColor: Colors.pink,
                              selected: _computers == Computers.powerStrips,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.powerStrips;
                                  _subCategory = 'Power Strips';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Surge Protectors'),
                              selectedColor: Colors.pink,
                              selected: _computers == Computers.surgeProtectors,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.surgeProtectors;
                                  _subCategory = 'Surge Protectors';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Printers'),
                              selectedColor: Colors.pink,
                              selected: _computers == Computers.printers,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.printers;
                                  _subCategory = 'Printers';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Scanners'),
                              selectedColor: Colors.pink,
                              selected: _computers == Computers.scanners,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.scanners;
                                  _subCategory = 'Scanners';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Servers'),
                              selectedColor: Colors.pink,
                              selected: _computers == Computers.servers,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.servers;
                                  _subCategory = 'Servers';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Tablet Accessories'),
                              selectedColor: Colors.pink,
                              selected:
                                  _computers == Computers.tabletAccessories,
                              onSelected: (bool selected) {
                                setState(() {
                                  _computers = Computers.tabletAccessories;
                                  _subCategory = 'Tablet Accessories';
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
                  ),
                ],
              ),
            ),
          );
  }
}