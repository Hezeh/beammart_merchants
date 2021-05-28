import 'package:flutter/material.dart';

class CreateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Profile"),
      ),
      body: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      type: StepperType.vertical,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index >= 0 && _index <= 2) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Business Information'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const Text('Content for Step 1'),
          ),
        ),
        const Step(
          title: Text('Business Profile Image'),
          content: Text('Content for Step 2'),
          subtitle: Text("Optional"),
        ),
        Step(
          title: const Text('Business Operating Hours'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const Text('Content for Step 3'),
          ),
        ),
        Step(
          title: const Text('Shop Location'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const Text('Content for Step 4'),
          ),
        ),
      ],
    );
  }
}
