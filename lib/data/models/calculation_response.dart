import 'package:project/core/utils/response.dart';
import 'package:project/domain/entities/calculation_data.dart';

typedef CalculationResponse = ServerResponse<CalculationData>;
typedef CalculationResponseWithMessage = ({
  String message,
  ServerResponse<CalculationData>? response
});
