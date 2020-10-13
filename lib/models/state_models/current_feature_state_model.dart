import 'package:mega/models/feature_model.dart';

/// Holds the current feature
/// i.e The feature whose screen was last accessed
class CurrentFeatureStateModel {
  /// The feature whose screen was last accessed
  FeatureModel _currentFeature;

  // Getters
  FeatureModel get currentFeature => _currentFeature;

  // Setters
  void setCurrentFeature(FeatureModel currentFeature){
    _currentFeature = currentFeature;
  }
}