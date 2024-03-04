import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/payslip_model.dart';

abstract class PayslipRemoteDataSource {
  Future<List<PayslipModel>> getPayslip(String year, String month);
}

class PayslipRemoteDataSourceImpl implements PayslipRemoteDataSource {
  final http.Client client;

  PayslipRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PayslipModel>> getPayslip(String year, String month) async {
    List<String> months = List.generate(12, (index) {
      return DateFormat('MMMM').format(DateTime(2023, index + 1, 1));
    });
    DateTime lastDayOfMonth = DateTime(int.parse(year), months.indexOf(month) + 2, 0);
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/payment/payslip?date=${DateFormat('yyyy-MM-dd').format(lastDayOfMonth)}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return payslipFromJson(response.body);
    } else {
      throw ErrorException(message: 'Server Error');
    }
  }
}
