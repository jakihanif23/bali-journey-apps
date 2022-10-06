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
}
