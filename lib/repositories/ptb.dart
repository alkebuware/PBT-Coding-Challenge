import 'package:coding_challenge/models/ptb.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'ptb.g.dart';

@RestApi(baseUrl: 'https://on-air-campaigns.firebaseio.com')
abstract class PTBRepository {
  factory PTBRepository(Dio dio) = _PTBRepository;

  @GET("/ptb-challenge.json")
  Future<PrimeTimeBillboard> getPrimeTimeBillboard();
}
