import 'package:boilerplate/data/database/controller/training/db_live_training_controller.dart';
import 'package:boilerplate/models/training/training.dart';
import 'package:flutter/material.dart';

DBLiveTrainingsController _dbTrainingsController;
final Training training = new Training(
    id: '12312dasdas', sport: 'Fitness', name: 'easy bench', exercises: []);

class TrainingPage extends StatefulWidget {
  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _dbTrainingsController.initiateLiveTraining(training.id),
        builder: (context, snapshot) {
          return Expanded(
            child: ListView(
              reverse: false,
              children: [
                Text('Training Name',
                    style: Theme.of(context).textTheme.headline3),
              ],
            ),
          );
        });
  }
}
