import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/state/therapies/therapies_list_bloc.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_edit_item_button_bar.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/therapy.dart';

/// Shows a single therapy item.
class ViewTherapyScreen extends StatelessWidget {
  /// Creates ViewTherapyScreen.
  const ViewTherapyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Therapy therapy = ModalRoute.of(context)!.settings.arguments as Therapy;

    return BlocBuilder<TherapiesListBloc, TherapiesListState>(
      builder: (BuildContext context, TherapiesListState state) {
        return PicosScreenFrame(
          bottomNavigationBar: PicosEditItemButtonBar(
            onTapLeft: () async {
              Therapy? newTherapy = await Navigator.of(context).pushNamed(
                '/my-therapy-screen/add-therapy',
                arguments: therapy,
              ) as Therapy;

              therapy = newTherapy;
            },
            onTapRight: () {
              context.read<TherapiesListBloc>().add(RemoveTherapy(therapy));
              Navigator.of(context).pop();
            },
          ),
          title: AppLocalizations.of(context)!.myTherapy,
          body: PicosBody(
            child: Column(
              children: <Widget>[
                PicosLabel(
                  label: '${therapy.dateString} '
                      '${AppLocalizations.of(context)!.therapy}',
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
