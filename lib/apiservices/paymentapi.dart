import 'package:wisata_bali/models/data_payment_checking.dart';
import 'package:wisata_bali/models/list_payment_history_model.dart';
import 'package:wisata_bali/models/list_payment_unpaid_model.dart';
import 'package:http/http.dart' as http;

class PaymentApi {
  final String apiUrl = 'https://api-bali-journey.herokuapp.com/users/payments';
  Future<List<ListPaymentUnpaidModel>> getListUnpaid(String token) async {
    var response = await http
        .get(Uri.parse('$apiUrl/unpaids'), headers: {'access_token': token});
    if (response.statusCode == 200) {
      return listPaymentUnpaidModelFromJson(response.body);
    } else {
      throw Exception('Failed to Connect');
    }
  }

  Future<List<ListPaymentHistoryModel>> getListPaymentHistory(
      String token) async {
    var response = await http
        .get(Uri.parse('$apiUrl/paids'), headers: {'access_token': token});
    if (response.statusCode == 200) {
      return listPaymentHistoryModelFromJson(response.body);
    } else {
      throw Exception('Failed to Connect');
    }
  }

  Future<DataPaymentChecking> getPaymentCheck(String id, String token) async {
    var response = await http
        .get(Uri.parse('$apiUrl/detail/$id'), headers: {'access_token': token});
    if (response.statusCode == 200) {
      return dataPaymentCheckingFromJson(response.body);
    } else {
      throw Exception('Failed to Load');
    }
  }
}
