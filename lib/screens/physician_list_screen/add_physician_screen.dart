/*   This file is part of Picos, a health tracking mobile app
*    Copyright (C) 2022 Healthcare IT Solutions GmbH
*
*    This program is free software: you can redistribute it and/or modify
*    it under the terms of the GNU General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU General Public License for more details.
*
*    You should have received a copy of the GNU General Public License
*    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/api/backend_physicians_api.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_text_field.dart';
import 'package:queen_validators/queen_validators.dart';

import '../../widgets/picos_body.dart';
import '../../widgets/picos_select.dart';

/// Contains the gender of the corresponding physician.
enum Gender {
  /// element for denoting the title of men
  male,

  /// element for denoting the title of women
  female,
}

/// This is the screen in which a user can add/edit
/// information about his physicians
class AddPhysicianScreen extends StatefulWidget {
  /// PhysiciansAdd constructor
  const AddPhysicianScreen({Key? key}) : super(key: key);

  @override
  State<AddPhysicianScreen> createState() => _AddPhysicianScreenState();
}

class _AddPhysicianScreenState extends State<AddPhysicianScreen> {
  Gender? _gender = Gender.male;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final List<String> _selection = <String>[];
  static late final String _specialty;
  static late final String _practice;
  static late final String _firstName;

  //State
  String? _selectedSubjectArea;
  String? _selectedFirstName;

  @override
  Widget build(BuildContext context) {
    if (_selection.isEmpty) {
      _selection.add(AppLocalizations.of(context)!.ophthalmology);
      _selection.add(AppLocalizations.of(context)!.gynecology);
      _selection.add(AppLocalizations.of(context)!.otolaryngology);
      _selection.add(AppLocalizations.of(context)!.generalPractitioner);
      _selection.add(AppLocalizations.of(context)!.skinAndVenerealDiseases);
      _selection.add(AppLocalizations.of(context)!.internalMedicine);
      _selection.add(AppLocalizations.of(context)!.microbiology);
      _selection.add(AppLocalizations.of(context)!.neurology);
      _selection.add(AppLocalizations.of(context)!.pathology);
      _selection.add(AppLocalizations.of(context)!.pulmonology);
      _selection.add(AppLocalizations.of(context)!.psychiatry);
      _selection.add(AppLocalizations.of(context)!.urology);

      _specialty = AppLocalizations.of(context)!.specialty;
      _practice = AppLocalizations.of(context)!.practice;
      _firstName = AppLocalizations.of(context)!.firstName;
    }

    return BlocBuilder<ObjectsListBloc<BackendPhysiciansApi>, ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        return PicosScreenFrame(
          body: PicosBody(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  PicosLabel(
                    _practice,
                  ),
                  PicosSelect(
                    selection: _selection,
                    callBackFunction: (String value) {
                      setState(
                        () {
                          _selectedSubjectArea = value;
                        },
                      );
                    },
                    hint: _selectedSubjectArea ?? _specialty,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PicosLabel(
                    _firstName,
                  ),
                  PicosTextField(
                    hint: _firstName,
                    keyboardType: TextInputType.name,
                    initialValue: _selectedFirstName,
                    onChanged: (String value) {
                      setState(() {
                        _selectedFirstName = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      labelText: '${AppLocalizations.of(context)!.firstName} *',
                    ),
                    keyboardType: TextInputType.name,
                    validator: qValidator(
                      <TextValidationRule>[
                        IsRequired(
                          AppLocalizations.of(context)!.entryFirstName,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${AppLocalizations.of(context)!.title} *',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<Gender>(
                          title: Text(
                            AppLocalizations.of(context)!.mr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: Gender.male,
                          groupValue: _gender,
                          onChanged: (Gender? value) {
                            setState(
                              () {
                                _gender = value;
                              },
                            );
                          },
                          selected: false,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<Gender>(
                          title: Text(
                            AppLocalizations.of(context)!.mrs,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: Gender.female,
                          groupValue: _gender,
                          onChanged: (Gender? value) {
                            setState(
                              () {
                                _gender = value;
                              },
                            );
                          },
                          selected: false,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      labelText:
                          '${AppLocalizations.of(context)!.familyName} *',
                    ),
                    keyboardType: TextInputType.name,
                    validator: qValidator(
                      <TextValidationRule>[
                        IsRequired(
                          AppLocalizations.of(context)!.entryFamilyName,
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.email),
                      labelText: '${AppLocalizations.of(context)!.email} *',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: qValidator(
                      <TextValidationRule>[
                        IsRequired(AppLocalizations.of(context)!.entryEmail),
                        IsEmail(AppLocalizations.of(context)!.entryValidEmail),
                      ],
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.numbers),
                      labelText:
                          '${AppLocalizations.of(context)!.phoneNumber} *',
                    ),
                    keyboardType: TextInputType.number,
                    validator: qValidator(
                      <TextValidationRule>[
                        IsRequired(
                          AppLocalizations.of(context)!.entryPhoneNumber,
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.web),
                      labelText: '${AppLocalizations.of(context)!.website} *',
                    ),
                    keyboardType: TextInputType.url,
                    validator: qValidator(
                      <TextValidationRule>[
                        IsRequired(AppLocalizations.of(context)!.entryWebsite),
                        IsUrl(AppLocalizations.of(context)!.entryValidWebsite),
                      ],
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.house),
                      labelText: '${AppLocalizations.of(context)!.address} *',
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: null,
                    validator: qValidator(
                      <TextValidationRule>[
                        IsRequired(AppLocalizations.of(context)!.entryAddress),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: PicosAddButtonBar(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.submitData,
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
