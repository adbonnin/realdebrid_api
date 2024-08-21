import 'package:realdebrid_api/realdebrid_api.dart';

void main() async {
  final client = RealDebridApiClient.basicAuthentication(apiToken: "YOUR_TOKEN");
  final api = RealDebridApi(client);

  final user = await api.user.getUser();
}
