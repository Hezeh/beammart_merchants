import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../enums/sports_fitness_outdoors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_upload_provider.dart';
import '../../utils/upload_files_util.dart';
import '../../utils/willpop_util.dart';

class SportsFitnessOutdoorsScreen extends StatefulWidget {
  @override
  _SportsFitnessOutdoorsScreenState createState() =>
      _SportsFitnessOutdoorsScreenState();
}

class _SportsFitnessOutdoorsScreenState
    extends State<SportsFitnessOutdoorsScreen> {
  bool isExpanded = true;
  SportsFitnessOutdoors _sportsFitnessOutdoors =
      SportsFitnessOutdoors.basketball;
  final _sportsFitnessOutdoorsFormKey = GlobalKey<FormState>();

  bool _loading = false;

  final String _category = 'Sports, Fitness and Outdoors';

  String _subCategory = 'Basketball';

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
              title: Text('Sports, Fitness & Outdoors'),
              actions: [
                FlatButton(
                  onPressed: () {
                    if (_sportsFitnessOutdoorsFormKey.currentState!.validate() &&
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
              key: _sportsFitnessOutdoorsFormKey,
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
                            title: Text(
                                'Sports, Fitness & Outdoors Subcategories'),
                          );
                        },
                        body: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text('Basketball'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.basketball,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.basketball;
                                  _subCategory = 'Basketball';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Bikes'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.bikes,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.bikes;
                                  _subCategory = 'Bikes';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Walk & Run'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.walkAndRun,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.walkAndRun;
                                  _subCategory = 'Walk and Run';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Treadmills'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.treadmills,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.treadmills;
                                  _subCategory = 'Treadmills';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Boxing'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.boxing,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.boxing;
                                  _subCategory = 'Boxing';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Exercise Machines'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.exerciseMachines,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.exerciseMachines;
                                  _subCategory = 'Excercise Machines';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Yoga'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.yoga,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.yoga;
                                  _subCategory = 'Yoga';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Strength Training'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.stregthTraining,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.stregthTraining;
                                  _subCategory = 'Strength Training';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Sports Recovery'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.sportsRecovery,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.sportsRecovery;
                                  _subCategory = 'Sports Recovery';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Boats & Marine'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.boatsAndMarine,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.boatsAndMarine;
                                  _subCategory = 'Boats and Marine';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Fishing'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.fishing,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.fishing;
                                  _subCategory = 'Fishing';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Hunting'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.hunting,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.hunting;
                                  _subCategory = 'Hunting';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Kayak & Paddle'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.kayakAndPaddle,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.kayakAndPaddle;
                                  _subCategory = 'Kayak and Paddle';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Recreational Shooting'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.recreationalShooting,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors = SportsFitnessOutdoors
                                      .recreationalShooting;
                                  _subCategory = 'Recreational Shooting';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Watersports'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.waterSports,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.waterSports;
                                  _subCategory = 'Watersports';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Football'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.football,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.football;
                                  _subCategory = 'Football';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Golf'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.golf,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.golf;
                                  _subCategory = 'Golf';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Hockey'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.hockey,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.hockey;
                                  _subCategory = 'Hockey';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Tennis'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.tennis,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.tennis;
                                  _subCategory = 'Tennis';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Volleyball'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.volleyball,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.volleyball;
                                  _subCategory = 'Volleyball';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Skateboards & Skates'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.skateboardsAndSkates,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors = SportsFitnessOutdoors
                                      .skateboardsAndSkates;
                                  _subCategory = 'Skateboards and Skates';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Camping & Hiking'),
                              selectedColor: Colors.pink,
                              selected: _sportsFitnessOutdoors ==
                                  SportsFitnessOutdoors.campingAndHiking,
                              onSelected: (bool selected) {
                                setState(() {
                                  _sportsFitnessOutdoors =
                                      SportsFitnessOutdoors.campingAndHiking;
                                  _subCategory = 'Camping and Hiking';
                                });
                              },
                            ),
                          ],
                        ),
                        isExpanded: isExpanded,
                      )
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
