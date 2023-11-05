import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rua/src/config/config.dart';
import 'package:rua/src/core/util/validation.dart';
import 'package:rua/src/features/random_user/presentation/viewmodels/local_user_bloc.dart';
import 'package:rua/src/features/random_user/presentation/viewmodels/local_user_event.dart';
import 'package:rua/src/features/random_user/presentation/widgets/custom_user_input.dart';

import '../../domain/entities/user_entity.dart';
import '../viewmodels/custom_user_bloc.dart';
import '../viewmodels/custom_user_event.dart';
import '../viewmodels/custom_user_state.dart';

class CustomUserGenerator extends StatefulWidget {
  final UserEntity user;

  const CustomUserGenerator({super.key, required this.user});

  @override
  State<CustomUserGenerator> createState() => _CustomUserGeneratorState();
}

class _CustomUserGeneratorState extends State<CustomUserGenerator> {
  final String name = customUserName;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  late UserEntity _user;

  @override
  void initState() {
    super.initState();
    setState(() {
      _user = widget.user;
      _emailController.text = _user.email?? '';
      _firstNameController.text = _user.firstName?? '';
      _lastNameController.text = _user.lastName?? '';
      _phoneController.text = _user.phone?? '';
    });
  }
@override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomUserBloc, CustomUserState>(
      bloc: BlocProvider.of<CustomUserBloc>(context),
      listener: (context, state) {
        if (state.user != null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Submission success!'),
                content: const Text("Your submission was a success"),
                actions: [
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      BlocProvider.of<LocalUserBloc>(context).add(SaveUser(user: _user));
                      Navigator.pushNamed(context, savedUsersRoute);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  )
                ]
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: RuaAppBar(parentName: name),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: BlocBuilder<CustomUserBloc, CustomUserState>(
              bloc: BlocProvider.of<CustomUserBloc>(context),
              builder: (context, state) {
                if (state == const InputValidation()) {
                  return const CircularProgressIndicator();
                }
                return ListView(
                  children: <Widget>[
                    UserInputField(
                      controller: _emailController,
                      state: state,
                      input: _user.email?? '',
                      tag: 'Email',
                    ),
                    UserInputField(
                      controller: _firstNameController,
                      state: state,
                      input: _user.firstName?? '',
                      tag: 'Firstname',
                    ),
                    UserInputField(
                      controller: _lastNameController,
                      state: state,
                      input: _user.lastName?? '',
                      tag: 'Lastname',
                    ),
                    UserInputField(
                      controller: _phoneController,
                      state: state,
                      input: _user.phone?? '',
                      tag: 'Phone',
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Birthday'),
                        Text('Age'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${_user.birthDay?? 'dd'}.${_user.birthMonth?? 'mm'}.${_user.birthYear?? 'yyyy'}'),
                        if (_user.age != null) Text(_user.age.toString()),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                            BlocProvider.of<CustomUserBloc>(context).add(SubmitCustomUser(_user));
                            _selectDate(context);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('Edit Birthday'),
                          Icon(Icons.calendar_month),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        BlocProvider.of<CustomUserBloc>(context).add(SubmitCustomUser(_user));
                        setState(() {
                          _user = UserEntity(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            birthDay: _user.birthDay,
                            birthMonth: _user.birthMonth,
                            birthYear: _user.birthYear,
                            age: _user.age,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            urlToLargeImage: _user.urlToLargeImage,
                            urlToMediumImage: _user.urlToMediumImage,
                            urlToThumbnail: _user.urlToThumbnail,
                          );
                        });
                      },
                    ),
                  ]);
                }),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
      int year = DateTime.now().year - picked.year;
      setState(() {
        _user = UserEntity(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          birthDay: picked.day.toString(),
          birthMonth: picked.month.toString(),
          birthYear: picked.year.toString(),
          age: year,
          email: _emailController.text,
          phone: _phoneController.text,
          urlToLargeImage: _user.urlToLargeImage,
          urlToMediumImage: _user.urlToMediumImage,
          urlToThumbnail: _user.urlToThumbnail,
        );
      });
    }
  }
}