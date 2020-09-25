import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/bars/error_snack_bar.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/models/feature_model.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

import 'base_api.dart';

/// Methods related to feature API
class FeatureAPI {
  /// Get features of a community
  static Future<List<FeatureModel>> getFeatures(BuildContext context, int communityId) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    Map<String, String> params = {
      'community': communityId.toString()
    };

    http.Response _res;

    try{
      _res = await BaseAPI.get(
        'api/features/',
        additionalHeaders: headers,
        params: params
      );
    } on SocketException{
      ErrorSnackBar.showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      List<dynamic> _featuresDynamicList = jsonDecode(_res.body);

      List<FeatureModel> _features = _featuresDynamicList.map((item) => FeatureModel.fromJson(item)).toList();
      return _features;
    } else if(_res.statusCode == 400) {
      ErrorSnackBar.showErrorSnackBar(context);
      return null;
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
      return null;
    }
  }

  /// Get all features in database
  /// except features already added to a community
  static Future<List<FeatureModel>> getAllFeatures(BuildContext context, String communityType, int communityId) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    Map<String, String> params = {
      'all': 'true',
      'community': communityId.toString()
    };

    http.Response _res;

    try{
      _res = await BaseAPI.get(
        'api/features/',
        additionalHeaders: headers,
        params: params
      );
    } on SocketException{
      ErrorSnackBar.showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      List<dynamic> _featuresDynamicList = jsonDecode(_res.body);

      List<FeatureModel> _features = _featuresDynamicList.map((item) => FeatureModel.fromJson(item)).toList();
      return _features;
    } else if(_res.statusCode == 400) {
      ErrorSnackBar.showErrorSnackBar(context);
      return null;
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
      return null;
    }
  }

  /// Add a feature to a community
  static Future<bool> addFeatureToCommunity(BuildContext context, int featureId, int communityId) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    Map<String, String> data = {
      'feature': featureId.toString(),
      'community': communityId.toString()
    };

    http.Response _res;

    try{
      _res = await BaseAPI.post(
          'api/features/add-to-community/',
          additionalHeaders: headers,
          data: data
      );
    } on SocketException{
      ErrorSnackBar.showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      return true;
    } else if(_res.statusCode == 400) {
      ErrorSnackBar.showErrorSnackBar(context);
      return false;
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
      return false;
    }
  }

  /// Remove a feature from a community
  static Future<bool> removeFeature(BuildContext context, String communityId, String featureId) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    Map<String, String> data = <String, String>{
      'community': communityId,
      'feature': featureId,
    };

    http.Response _res;

    try{
      _res = await BaseAPI.post(
          'api/features/remove/',
          additionalHeaders: headers,
          data: data
      );
    } on SocketException{
      ErrorSnackBar.showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      return true;
    } else if(_res.statusCode == 400) {
      return false;
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
      return false;
    }
  }
}