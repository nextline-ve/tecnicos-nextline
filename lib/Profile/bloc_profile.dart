import 'dart:async';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import './repository_profile.dart';
import 'model/model_profile.dart';

class BlocProfile implements Bloc {
  final RepositoryProfile repository = RepositoryProfile();

  final StreamController<int> _streamController =
      StreamController<int>.broadcast();


  Future<TechProfile> getTechProfile() async {
    return await repository.getTechProfileAPI();
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
