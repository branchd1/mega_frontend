import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/bars/ErrorSnackBar.dart';
import 'package:mega/models/AuthTokenModel.dart';
import 'package:mega/models/FeatureModel.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

import 'BaseAPI.dart';

class FeatureAPI {
  static Future<List<FeatureModel>> getFeatures(BuildContext context, int communityId) async {

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ' + Provider.of<AuthTokenModel>(context, listen: false).token
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
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      final Map<String, dynamic> _resBody = jsonDecode(_res.body);
      List<dynamic> _featuresDynamicList = _resBody['results'];

      List<FeatureModel> _features = _featuresDynamicList.map((item) => FeatureModel.fromJson(item)).toList();
      return _features;
    } else if(_res.statusCode == 400) {
      showErrorSnackBar(context);
      return null;
    } else {
      showErrorSnackBar(context);
      return null;
    }
  }

  static Future<List<FeatureModel>> getAllFeatures(BuildContext context, String communityType, int communityId) async {

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ' + Provider.of<AuthTokenModel>(context, listen: false).token
    };

    Map<String, String> params = {
      'type': communityType,
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
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      final Map<String, dynamic> _resBody = jsonDecode(_res.body);
      List<dynamic> _featuresDynamicList = _resBody['results'];

      List<FeatureModel> _features = _featuresDynamicList.map((item) => FeatureModel.fromJson(item)).toList();
      return _features;
    } else if(_res.statusCode == 400) {
      showErrorSnackBar(context);
      return null;
    } else {
      showErrorSnackBar(context);
      return null;
    }
  }

  static Future<bool> addFeatureToCommunity(BuildContext context, int featureId, int communityId) async {

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ' + Provider.of<AuthTokenModel>(context, listen: false).token
    };

    Map<String, String> data = {
      'feature': featureId.toString(),
      'community': communityId.toString()
    };

    http.Response _res;

    try{
      _res = await BaseAPI.post(
        'api/features/add_to_community/',
        additionalHeaders: headers,
        data: data
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      return true;
    } else if(_res.statusCode == 400) {
      showErrorSnackBar(context);
      return false;
    } else {
      showErrorSnackBar(context);
      return false;
    }
  }
}