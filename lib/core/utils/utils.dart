import '../shared_helper/shared_pref.dart';

var accessToken = "";
var userId = "";
var fcmToken = "";
const developmentBaseUrl = "http://192.168.0.107:4000/api/";
initiateAccessToken() async {
  accessToken = await getAccessToken();
}
initaizationUserId() async {
  userId = await getUserID();
}
initiateFcmToken() async {
  fcmToken = await getFcmToken();
}
