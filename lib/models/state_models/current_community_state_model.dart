import 'package:mega/models/community_model.dart';

///  Holds the current community
class CurrentCommunityStateModel {
  /// The community whose profile was last accessed
  CommunityModel _currentCommunity;

  // Getters
  CommunityModel get currentCommunity => _currentCommunity;

  // Setters
  void setCurrentCommunity(CommunityModel currentCommunity){
    _currentCommunity = currentCommunity;
  }
}