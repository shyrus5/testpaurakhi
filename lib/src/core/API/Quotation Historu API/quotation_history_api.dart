import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/app/screens/home/presentation/history/Quotation%20Hisotry/model/quotationhistory_model.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class QuotationHistory {
  static Future<QuotationHistoryModel?> quotationHistory(page) async {
    var cookie = await ManageCookie.getCookie();
    final String url =
        '${Environment.apiUrl}${AllAPIEndPoint.getQuotationHistoryAPI}?page=$page';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Cookie': cookie},
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        final Map<String, dynamic> jsonList = jsonDecode(response.body);
        final List<dynamic> dataList = jsonList['data'] as List<dynamic>;
        final List<Datum> items = dataList
            .map((item) => Datum.fromJson(item as Map<String, dynamic>))
            .toList();

        return QuotationHistoryModel(data: items);
      } else if (code == 400) {
        // Handle 400 error
      } else if (code == 500) {
        // Handle 500 error
      }
      return null;
    } catch (e) {
      debugPrint("$e");
      // Handle exception
      return null;
    }
  }
}
