// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Shared {
  var context;
  String baseurl = "https://whiskers.dev.wedev.sbs/api/";

  Shared(BuildContext c) {
    context = c;
  }

  postLogin(url, body) async {
    var res = await http.post(Uri.parse(baseurl + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    return res;
  }

  get(url) async {
    var res = await http.get(Uri.parse(baseurl + url));
    return res;
  }
  delete(url) async {
    var res = await http.delete(Uri.parse(baseurl + url));
    return res;
  }

  put(url, body) async {
    var res = await http.put(Uri.parse(baseurl + url), body: body, headers: {
      'Content-Type': 'application/json; charset=UTF-8'
    });
    return res;
  }

  post(url, body) async {
    var res = await http.post(Uri.parse(baseurl + url), body: body);
    return res;
  }
}
