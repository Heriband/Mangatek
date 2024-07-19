import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class Scraper {
  static String URL = "https://www.nautiljon.com";
  static Map<String, http.Response>? load;
  static Scraper? scraper;

  Scraper() {
    load = new Map();
  }

  static getInstance() {
    if (scraper == null) {
      scraper = Scraper();
    }
    return scraper;
  }


  String parseString(String str){
    str = str.toLowerCase();
    str = str.replaceAll(' ', '+');
    str = str.replaceAll('\'', '-');
    return str;
  }

  Future<String> getPathImage(String name) async {
    name = parseString(name);

    if (load?[name] == null) {
      http.Response response = await http
          .get(Uri.parse('https://www.nautiljon.com/mangas/$name.html'));
      load?[name] = response;
      print("make request");
    }
    if (load?[name] != null && load?[name]!.statusCode == 200) {
      var document = parse(load?[name]!.body);
      var couverture = document.getElementById('onglets_3_couverture');
      String path = couverture?.attributes['href'] ?? "";
      return URL + path;
    } else {
      return "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png";
    }
  }

  Future<String> getNbVolume(String name) async {
    name = parseString(name);

    final response = await http
        .get(Uri.parse('https://www.nautiljon.com/mangas/$name.html'));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var couverture = document.getElementsByClassName('mb10');
      String res = "Nb volumes VF : ";
      for (int index = 0; index != couverture[0].nodes.length; index++) {
        String? vf = couverture[0].nodes[index].nodes[0].nodes[0].text;
        if (vf != null && vf == 'Nb volumes VF : ') {
          String nbTome =
              couverture[0].nodes[index].nodes[1].text ?? " ?"; // X (en cours)
          res += nbTome;
          break;
        }
      }
      return res;
    } else {
      throw Exception('Failed to load website');
    }
  }
}
