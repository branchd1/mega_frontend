import 'package:flutter/foundation.dart';
import 'package:mega/models/community_model.dart';

class CurrentCommunityStateModel {
  CommunityModel _currentCommunity;

  CommunityModel get currentCommunity => _currentCommunity;

  void setCurrentCommunity(CommunityModel currentCommunity){
    _currentCommunity = currentCommunity;
  }
}