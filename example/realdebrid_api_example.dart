import 'package:realdebrid_api/realdebrid_api.dart';

void main() async {
  final client = ApiClient.basicAuthentication(apiToken: "YOUR_TOKEN");
  final api = RealDebridApi(client);

  final user = await api.user.getUser();
}
