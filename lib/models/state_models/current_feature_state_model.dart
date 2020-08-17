import 'package:flutter/foundation.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';

class CurrentFeatureStateModel {
  FeatureModel _currentFeature;

  FeatureModel get currentFeature => _currentFeature;

  void setCurrentFeature(FeatureModel currentFeature){
    _currentFeature = currentFeature;
  }
}