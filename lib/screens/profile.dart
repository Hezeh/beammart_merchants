import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../models/profile.dart';
import '../providers/add_business_profile_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../screens/add_business_photo.dart';
import '../screens/operating_hours_screen.dart';
import '../widgets/add_location.dart';

class ProfileScreen extends StatefulWidget {
  final Profile profile;
  static const routeName = '/ProfileScreen';

  const ProfileScreen({Key key, this.profile}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileFormKey = GlobalKey<FormState>();

  final TextEditingController _businessName = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _locationDescription = TextEditingController();
  final TextEditingController _businessDescription = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  void dispose() {
    _businessName.dispose();
    _city.dispose();
    _locationDescription.dispose();
    _businessDescription.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.profile != null) {
      _businessName.text = widget.profile.businessName;
      _city.text = widget.profile.city;
      _locationDescription.text = widget.profile.locationDescription;
      _businessDescription.text = widget.profile.businessDescription;
      _phoneNumber.text = widget.profile.phoneNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profile;
    final _userProvider = Provider.of<AuthenticationProvider>(context);
    final _businessProfileProvider =
        Provider.of<AddBusinessProfileProvider>(context);
    // final _userId = _userProvider.user;
    return Scaffold(
      appBar: (widget.profile != null)
          ? AppBar(
              title: Text('Edit Business Profile'),
              centerTitle: true,
            )
          : AppBar(
              title: Text('Business Profile'),
              centerTitle: true,
            ),
      body: Form(
        key: _profileFormKey,
        child: ListView(
          children: [
            (widget.profile != null)
                ? Container(
                    padding: EdgeInsets.all(8.0),
                    height: 400,
                    child: (widget.profile.businessProfilePhoto != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: GridTile(
                              footer: GridTileBar(
                                backgroundColor: Colors.black12,
                                title: Text(
                                  'Change Photo',
                                  style: GoogleFonts.gelasio(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.edit_outlined),
                                  onPressed: () {
                                    // Navigate to Edit Profile Page
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => AddBusinessProfilePhoto(
                                          changePhoto: true,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: widget.profile.businessProfilePhoto,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Expanded(
                                    child: Shimmer.fromColors(
                                      child: Card(
                                        child: Container(
                                          width: double.infinity,
                                          height: 400,
                                          color: Colors.white,
                                        ),
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[100],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Text('No Profile Photo'),
                  )
                : Container(),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _businessName,
                autocorrect: true,
                enableSuggestions: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  labelText: 'Business Name (required)',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter a Business Name";
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _businessDescription,
                autocorrect: true,
                enableSuggestions: true,
                maxLines: 3,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  labelText: 'Business Description (required)',
                  hintText: 'What does your business offer?',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter a Business Description";
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _city,
                autocorrect: true,
                enableSuggestions: true,
                maxLines: 2,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  labelText: 'City/Town (required)',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter a city or town";
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _locationDescription,
                autocorrect: true,
                enableSuggestions: true,
                maxLines: 3,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  labelText: 'Address/Location Description (required)',
                  hintText: 'E.g. Street Name, Building Address, Store Number',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter a location description";
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _phoneNumber,
                autocorrect: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enableSuggestions: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  labelText: 'Phone Number (required)',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter a Phone Number";
                  }
                  return null;
                },
              ),
            ),
            (widget.profile != null)
                ? Container(
                    child: ListTile(
                      title: Text('GPS Location'),
                      subtitle: (profile != null)
                          ? Text(
                              '${profile.gpsLocation.latitude}, ${profile.gpsLocation.longitude}')
                          : Container(),
                      trailing: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AddLocationMap(
                                currentLocation: GeoPoint(
                                  profile.gpsLocation.latitude,
                                  profile.gpsLocation.longitude,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text('Change'),
                      ),
                    ),
                  )
                : Container(),
            (widget.profile != null)
                ? Container(
                    child: ListTile(
                      title: Text('Operating Hours'),
                      subtitle: Text('Opening & Closing Time'),
                      trailing: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => OperatingHoursScreen(
                                profile: Profile(
                                  mondayOpeningHours:
                                      profile.mondayOpeningHours,
                                  mondayClosingHours:
                                      profile.mondayClosingHours,
                                  tuesdayOpeningHours:
                                      profile.tuesdayOpeningHours,
                                  tuesdayClosingHours:
                                      profile.tuesdayClosingHours,
                                  wednesdayOpeningHours:
                                      profile.wednesdayOpeningHours,
                                  wednesdayClosingHours:
                                      profile.wednesdayClosingHours,
                                  thursdayOpeningHours:
                                      profile.thursdayOpeningHours,
                                  thursdayClosingHours:
                                      profile.thursdayClosingHours,
                                  fridayOpeningHours:
                                      profile.fridayOpeningHours,
                                  fridayClosingHours:
                                      profile.fridayClosingHours,
                                  saturdayOpeningHours:
                                      profile.saturdayOpeningHours,
                                  saturdayClosingHours:
                                      profile.saturdayClosingHours,
                                  sundayOpeningHours:
                                      profile.sundayOpeningHours,
                                  sundayClosingHours:
                                      profile.sundayClosingHours,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text('Edit'),
                      ),
                    ),
                  )
                : Container(),
            (widget.profile != null)
                ? Container(
                    padding: EdgeInsets.only(
                      top: 25,
                      left: 10,
                      right: 10,
                    ),
                    height: 70,
                    child: RaisedButton(
                      elevation: 30,
                      onPressed: () {
                        if (_profileFormKey.currentState.validate()) {
                          _userProvider.addBusinessProfile(
                            {
                              'businessName': _businessName.text,
                              'businessDescription': _businessDescription.text,
                              'city': _city.text,
                              'phoneNumber': _phoneNumber.text,
                              'locationDescription': _locationDescription.text,
                            },
                            _userProvider.user.uid,
                          );

                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Save',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_profileFormKey.currentState.validate()) {
                          _businessProfileProvider.businessInfo(
                            businessName: _businessName.text,
                            businessDescription: _businessDescription.text,
                            city: _city.text,
                            phoneNumber: _phoneNumber.text,
                            locationDescription: _locationDescription.text,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AddBusinessProfilePhoto(
                                changePhoto: false,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('Next'),
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
