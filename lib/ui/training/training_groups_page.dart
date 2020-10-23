import 'package:boilerplate/data/database/controller/training/db_training_groups_controller.dart';
import 'package:boilerplate/models/training/training_group.dart';
import 'package:boilerplate/widgets/round_button_widget.dart';
import 'package:flutter/material.dart';

DBTrainingGroupsController _dbTrainingsController;

class TrainingGroupsPage extends StatefulWidget {
  @override
  _TrainingGroupsPageState createState() => _TrainingGroupsPageState();
}

class _TrainingGroupsPageState extends State<TrainingGroupsPage> {
  @override
  void initState() {
    super.initState();
    _dbTrainingsController = DBTrainingGroupsController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: _dbTrainingsController.getTrainingGroups(),
            builder: (context, snapshot) {
              List<Widget> trainingGroupList = [];
              if (snapshot.hasData) {
                final docs = snapshot.data.documents;

                for (var doc in docs) {
                  TrainingGroup trainingGroup = TrainingGroup.fromDocument(doc);
                  trainingGroupList.add(GestureDetector(
                    onDoubleTap: () => {
                      setState(() {
                        _dbTrainingsController.deleteTrainingGroup(
                            doc.id, trainingGroup.name);
                      }),
                    },
                    child: ExpansionTile(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      title: Text(
                        trainingGroup.name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ));
                  trainingGroupList.add(Divider(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ));
                }
              }
              trainingGroupList.add(RoundButton(
                color: Theme.of(context).primaryColorDark,
                onPressed: () => {
                  setState(() {
                    _dbTrainingsController
                        .addTrainingGroup('new training group');
                  }),
                },
                title: '+',
              ));
              return Expanded(
                child: ListView(
                  reverse: false,
                  children: trainingGroupList,
                ),
              );
            }),
      ],
    );
  }
}
