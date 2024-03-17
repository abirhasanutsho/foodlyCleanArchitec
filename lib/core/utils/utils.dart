import '../shared_helper/shared_pref.dart';

var accessToken = "";
var userId = "";
const developmentBaseUrl = "http://192.168.0.100:4000/api/";
initiateAccessToken() async {
  accessToken = await getAccessToken();
}
initaizationUserId() async {
  userId = await getUserID();
}
