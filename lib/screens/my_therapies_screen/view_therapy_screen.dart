import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_edit_item_button_bar.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/gen_l10n/app_localizations.dart';

import '../../api/backend_therapies_api.dart';
import '../../models/therapy.dart';
import '../../state/objects_list_bloc.dart';

/// Shows a single therapy item.
class ViewTherapyScreen extends StatelessWidget {
  /// Creates ViewTherapyScreen.
  const ViewTherapyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Therapy therapy = ModalRoute.of(context)!.settings.arguments as Therapy;

    return BlocBuilder<ObjectsListBloc<BackendTherapiesApi>, ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        return PicosScreenFrame(
          bottomNavigationBar: PicosEditItemButtonBar(
            onTapLeft: () async {
              Therapy? newTherapy = await Navigator.of(context).pushNamed(
                '/my-therapy-screen/add-therapy',
                arguments: therapy,
              ) as Therapy?;

              if (newTherapy == null) return;

              therapy = newTherapy;
            },
            onTapRight: () {
              context
                  .read<ObjectsListBloc<BackendTherapiesApi>>()
                  .add(RemoveObject(therapy));
              Navigator.of(context).pop();
            },
          ),
          title: AppLocalizations.of(context)!.myTherapy,
          body: PicosBody(
            child: Column(
              children: <Widget>[
                PicosLabel(
                  '${therapy.dateString} - '
                  '${therapy.name}',
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    therapy.therapy,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
