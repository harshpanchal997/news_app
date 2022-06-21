
class ApiEndPoints {

  static String strBaseUrl = "https://newsapi.org/v2";


  /*
  * ----- Api status
  * */
  static int apiStatus_200 = 200; //success


  /*
  * ---- Static data to pass in api's
  * */


  /*
  * ----- End Points
  * */

  static String apiKey = "a34f17e6e15b4990b992da88c477a2d6";

  //Common API
  static String newsList(String search)                   => strBaseUrl + "/everything?q=$search&from=2022-06-20&to2022-07-21&sortBy=publishedAt&apiKey=$apiKey";






}
