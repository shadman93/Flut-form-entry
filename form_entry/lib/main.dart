import 'package:flutter/material.dart';

void main() => runApp(MyFormApp());

class MyFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form 1',
      theme: ThemeData(primaryColor: Colors.orange),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  MyFormState createState() {
    // TODO: implement createState
    return MyFormState();
  }
}

class MyFormState extends State<MyHome> {
  //
  // String _name;
  bool? _isMale;
  DateTime? _dateOfBirth;
  final TextEditingController _DOBTextController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? _country;
  late List<DropdownMenuItem> _countryList;

  List<String>? _languages;
  List<String>? _selectedLanguages;
  // DateTime? _timeOfSomething;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2020, 11, 21),
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (pickedDate != null && pickedDate.isBefore(DateTime.now())) {
      setState(() {
        _dateOfBirth = pickedDate;
        print("selected date is ${_dateOfBirth?.toLocal()}");
        _DOBTextController.text = "${_dateOfBirth?.toLocal()}".split(' ')[0];
      });
    }
  }

  void _pickTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 10),
    );
    if (newTime != null) {
      print(" the selected time is ${newTime}");
      _timeController.text = "${newTime.hour} : ${newTime.minute}";
    }
  }

  SnackBar _showSnackbarWithMessage(String message) {
    return SnackBar(content: Text(message));
  }

  List<DropdownMenuItem<String>> _createCountryList() {
    return const [
      DropdownMenuItem(value: 'India', child: Text('India')),
      DropdownMenuItem(value: 'Pakistan', child: Text('Pakistan')),
      DropdownMenuItem(value: 'Afghanistan', child: Text('Afghanistan')),
      DropdownMenuItem(value: 'Nepal', child: Text('Nepal')),
      DropdownMenuItem(value: 'Bhutan', child: Text('Bhutan')),
      DropdownMenuItem(value: 'Bangladesh', child: Text('Bangladesh')),
      DropdownMenuItem(value: 'China', child: Text('China')),
      DropdownMenuItem(value: 'SriLanka', child: Text('SriLanka')),
      DropdownMenuItem(value: 'Myanmar', child: Text('Myanmar'))
    ];
  }

  void _getLanguages() {
    _languages =  ['English','Hindi','Urdu','Pastu','Bangla','Mandarin','Nepali'];
  }


  @override
  void initState() {
    super.initState();
    _getLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: const Text("Form 1"),
              backgroundColor: Colors.orangeAccent,
            ),
            body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter data';
                            }
                          },
                          maxLength: 40,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                            errorText: null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          onTap: _pickDate,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter data';
                            }
                          },
                          readOnly: true,
                          showCursor: false,
                          controller: _DOBTextController,
                          // initialValue: _dateOfBirth == null ? "" : "${_dateOfBirth?.toLocal()}".split(' ')[0],
                          /// ItemDecoration shouldn't be 'const' as its gonna show and remove date dialog
                          /// on click of suffix image. If not, const can be put
                          decoration: const InputDecoration(
                              labelText: 'Date Of Birth',
                              border: OutlineInputBorder(),
                              suffixIcon: InkWell(
                                ///Inkwell is used to add onTap()
                                child: Icon(Icons.calendar_today_rounded),

                                /// onTap: _pickDate, /// If DatePicker is needed to be shown from suffix Icon
                              )),
                        ),
                        const SizedBox(height: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Choose you Gender'),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 140,
                                    child: ListTile(
                                      title: Text('Male',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              ?.copyWith()),
                                      // subtitle: const Text('You are a Man'),
                                      leading: Radio(
                                        /// if the vale == groupValue, then the radio button will be selected
                                        value: true,
                                        groupValue: _isMale,
                                        onChanged: (val) {
                                          setState(() {
                                            _isMale = true;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 160,
                                    child: ListTile(
                                      title: Text('Female',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              ?.copyWith()),
                                      // subtitle: const Text('You are the lady'),
                                      leading: Radio(
                                        /// if the vale == groupValue, then the radio button will be selected
                                        value: false,
                                        groupValue: _isMale,
                                        onChanged: (val) {
                                          setState(() {
                                            _isMale = false;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                        const SizedBox(height: 16),
                        Container(
                          child: DropdownButtonFormField(
                            value: _country,
                            hint: const Text('Country'),
                            items: _createCountryList(),
                            onChanged: (val) {
                              setState(() {
                                _country = val as String?;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          onTap: () {
                            _pickTime();
                          },
                          readOnly: true,
                          showCursor: false,
                          controller: _timeController,
                          decoration: const InputDecoration(
                              label: Text('Select Time'),
                              suffixIcon: Icon(Icons.access_time_rounded),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          child: Column (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Languages you know"),
                              Row(
                                children: [
                                  for (var i = 0; i < 5; i += 1)
                                    Row(
                                      children: [
                                        Checkbox(
                                          onChanged: (value) {
                                            print('chck box value: $value');
                                            setState(() {
                                              if (_selectedLanguages != null && _selectedLanguages!.contains(_languages![i]) ) {
                                                _selectedLanguages?.remove(_languages![i]);
                                              } else {
                                                _selectedLanguages?.add(_languages![i]);
                                              }
                                            });
                                          },
                                          value: _selectedLanguages?.contains(_languages![i]),
                                        ),
                                        Text(
                                          _languages![i],
                                          style: Theme.of(context).textTheme.subtitle1,
                                        ),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    ),
                                ],
                              ),
                            ],
                          )
                        ),

                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                              onPressed: () {
                                final snck = _showSnackbarWithMessage("message submitted");

                                // SnackBar(
                                //   content: Text("snackbar Sumbmitted"),
                                //   backgroundColor: Colors.black,
                                //   duration: Duration(seconds: 5),
                                // );
                                /// ScaffoldMessenger.of(context) is not working- has to use
                                _scaffoldKey.currentState?.showSnackBar(snck);
                                print("submit button clicked");
                              },
                              child: const Text(
                                'Submit Form',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                  )),
            )));
  }
}
