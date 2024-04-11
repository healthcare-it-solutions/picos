/*
*  This file is part of Picos, a health tracking mobile app
*  Copyright (C) 2022 Healthcare IT Solutions GmbH
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program. If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/screens/home_screen/overview/widgets/progress_section.dart';

import '../../../../api/backend_daily_inputs_api.dart';
import '../../../../state/objects_list_bloc.dart';
import '../../../../themes/global_theme.dart';
import 'input_card_section.dart';

/// Widget which shows the questionaire section.
class QuestionaireSection extends StatefulWidget {
  /// QuestionaireSection constructor
  const QuestionaireSection({Key? key}) : super(key: key);

  @override
  State<QuestionaireSection> createState() => _QuestionaireSectionState();
}

class _QuestionaireSectionState extends State<QuestionaireSection>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<ObjectsListBloc<BackendDailyInputsApi>>().add(
        const LoadObjectsList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return BlocBuilder<ObjectsListBloc<BackendDailyInputsApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        return Column(
          children: <Container>[
            Container(
              color: theme.darkGreen1,
              child: InputCardSection(state: state),
            ),
            Container(
              color: theme.darkGreen3,
              child: ProgressSection(state: state),
            ),
          ],
        );
      },
    );
  }
}