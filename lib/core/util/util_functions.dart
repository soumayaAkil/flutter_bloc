import 'dart:developer';
import 'dart:ui';

import '../../data/models/searchCriteria.dart';
import '../constants/strings/strings.dart';

class UtilFunctions {
  static Color getColor(int rFlag, int status) {
    if (status >= 100) return Color.fromARGB(100, 250, 50, 50);
    //    if ((status & 4L)>0)  return Color.argb(100,50,250,50);
    switch (rFlag) {
      case 0:
        return Color.fromARGB(100, 250, 250, 250);
      case 1:
        return Color(0x00C0FFC0);
      case 2:
        return Color(0x00000080);
      case 3:
        return Color(0x00FFFFFF);
      case 4:
        return Color(0x00FFFFFF);
      case 5:
        return Color.fromARGB(100, 250, 250, 250);
      case 6:
        return Color.fromARGB(100, 200, 200, 200);
      case 7:
        return Color.fromARGB(100, 150, 250, 150);
      case 8:
        return Color.fromARGB(100, 250, 150, 150);
      case 9:
        return Color.fromARGB(100, 250, 50, 50);
    }
    return Color(0x00FFFFFF);
  }

  static String getFormatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();
    return " ${day.padLeft(2, '0')}/${month.padLeft(2, '0')}/${year}";
  }

  static String filtreBackValide(String filtre, String filtreDetails,
      String valueRecherche) {
    String filtreBack = "date";

    if (filtre == "recherche" || valueRecherche != "") {
      log("www");
      if (filtreDetails == "") {
        filtreBack = "recherche";
      } else if (filtreDetails == "completetHNetnonreglé") {
        filtreBack = "filtreRNF";
      } else {
        filtreBack = "filtreRF";
      }
    } else if (filtreDetails == "completetHNetnonreglé") {
      filtreBack = "filtreNF";
    } else {
      filtreBack = "filtreF";
    }
    return filtreBack;
  }

  static List<SearchCriteriaGroup> formatSearchCriteria(String datedeb,
      String datefin,
      String filtre,
      String? valueRecherche,
      String filtreDetails) {
    List<SearchCriteriaGroup> ListsearchCriteriaGroup = [];
    List<SearchCriteria> ListsearchCriteria = [];
    List<SearchCriteria> ListsearchCriteriaNom = [];
    List<SearchCriteria> ListsearchCriteria2 = [];
    final s1 = SearchCriteria(
      key: "datePrelevement",
      operation: ">",
      orPredicate: false,
      value: "${datedeb} 00:00:00",
    );
    final s2 = SearchCriteria(
      key: "datePrelevement",
      operation: "<",
      orPredicate: false,
      value: "${datefin} 23:59:59",
    );
    final s3 = SearchCriteria(
      key: "statut",
      operation: "<",
      orPredicate: false,
      value: STATUT,
    );
    ListsearchCriteria.add(s1);
    ListsearchCriteria.add(s2);
    ListsearchCriteria.add(s3);

// date valide recherche
    if (filtre == "recherche" || valueRecherche != "") {
      final s4 = SearchCriteria(
        key: "patient.nom",
        operation: "like",
        orPredicate: false,
        value: "%${valueRecherche}%",
      );
      final s5 = SearchCriteria(
        key: "patient.prenom",
        operation: "like",
        orPredicate: true,
        value: "%${valueRecherche}%",
      );
      ListsearchCriteriaNom.add(s4);
      ListsearchCriteriaNom.add(s5);
      final sg3 = SearchCriteriaGroup(
          orPredicate: false, searchCriterias: ListsearchCriteriaNom);
      ListsearchCriteriaGroup.add(sg3);
    }
    if (filtreDetails != "") {
      if (filtreDetails == "complet") {
        final ss1 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: false,
          value: "7",
        );
        /* hors norme
      final s5 = SearchCriteria(
        key: "resultFlag",
        operation: "=",
        orPredicate: true,
        value: "8",
      );
      */
        final ss2 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: true,
          value: "9",
        );

        final ss3 = SearchCriteria(
          key: "solde",
          operation: ">",
          orPredicate: false,
          value: "0",
        );

        ListsearchCriteria2.add(ss1);
        //  ListsearchCriteria2.add(s5);
        ListsearchCriteria2.add(ss2);
        ListsearchCriteria.add(ss3);

        final sg2 = SearchCriteriaGroup(
            orPredicate: false, searchCriterias: ListsearchCriteria2);
        ListsearchCriteriaGroup.add(sg2);
      } else if (filtreDetails == "reglé" ||
          filtreDetails == "regléEtHNetnoncomplet") {
        final si4 = SearchCriteria(
          key: "solde",
          operation: "<=",
          orPredicate: false,
          value: "0",
        );
        final s5 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: false,
          value: "5",
        );
        final s6 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: true,
          value: "6",
        );
        ListsearchCriteria2.add(s5);
        ListsearchCriteria2.add(s6);
        ListsearchCriteria.add(si4);
        final sg2 = SearchCriteriaGroup(
            orPredicate: false, searchCriterias: ListsearchCriteria2);
        ListsearchCriteriaGroup.add(sg2);
      } else if (filtreDetails == "completEtreglé") {
        final s4 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: false,
          value: "7",
        );
        final s6 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: true,
          value: "9",
        );

        final s7 = SearchCriteria(
          key: "solde",
          operation: "<=",
          orPredicate: false,
          value: "0",
        );

        ListsearchCriteria2.add(s4);
        ListsearchCriteria2.add(s6);
        ListsearchCriteria.add(s7);

        final sg2 = SearchCriteriaGroup(
            orPredicate: false, searchCriterias: ListsearchCriteria2);
        ListsearchCriteriaGroup.add(sg2);
      } else if (filtreDetails == "completEtregléetHN") {
        final s5 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: true,
          value: "8",
        );
        final s6 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: true,
          value: "9",
        );

        final s7 = SearchCriteria(
          key: "solde",
          operation: "<=",
          orPredicate: false,
          value: "0",
        );
        ListsearchCriteria2.add(s5);
        ListsearchCriteria2.add(s6);
        ListsearchCriteria.add(s7);

        final sg2 = SearchCriteriaGroup(
            orPredicate: false, searchCriterias: ListsearchCriteria2);
        ListsearchCriteriaGroup.add(sg2);
      } else if (filtreDetails == "ncomplteEtnreglé" ||
          filtreDetails == "ncomplteEtnregléEtnHN") {
        final se4 = SearchCriteria(
          key: "solde",
          operation: ">",
          orPredicate: false,
          value: "0",
        );
        final s5 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: false,
          value: "5",
        );
        final s6 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: true,
          value: "6",
        );
        ListsearchCriteria2.add(s5);
        ListsearchCriteria2.add(s6);
        ListsearchCriteria.add(se4);
        final sg2 = SearchCriteriaGroup(
            orPredicate: false, searchCriterias: ListsearchCriteria2);
        ListsearchCriteriaGroup.add(sg2);
      }
      if (filtreDetails == "completetHNetnonreglé") {
        final ss1 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: false,
          value: "7",
        );
        //hors norme
        final s5 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: true,
          value: "8",
        );

        final ss2 = SearchCriteria(
          key: "resultFlag",
          operation: "=",
          orPredicate: true,
          value: "9",
        );

        final ss3 = SearchCriteria(
          key: "solde",
          operation: ">",
          orPredicate: false,
          value: "0",
        );

        ListsearchCriteria2.add(ss1);
        ListsearchCriteria2.add(s5);
        ListsearchCriteria2.add(ss2);
        ListsearchCriteria.add(ss3);

        final sg2 = SearchCriteriaGroup(
            orPredicate: false, searchCriterias: ListsearchCriteria2);
        ListsearchCriteriaGroup.add(sg2);
      }
    }

    final sg = SearchCriteriaGroup(
        orPredicate: false, searchCriterias: ListsearchCriteria);
    ListsearchCriteriaGroup.add(sg);

    return ListsearchCriteriaGroup;
  }

  static String rtfToPlain(String rtf) {
    // Remove RTF headers and unnecessary tags
    rtf = rtf.replaceAll(RegExp(r'\\pard'), '\n');
    rtf = rtf.replaceAll(RegExp(r'\\par'), '\n');
    rtf = rtf.replaceAll(RegExp(r'\\tab'), '\t');
    rtf = rtf.replaceAll(RegExp(r'\\[a-z]+\d*'), '');
    rtf = rtf.replaceAll(RegExp(r'\\\*\\[a-z]+'), '');
    rtf = rtf.replaceAll(RegExp(r'[{}]'), '');
    rtf = rtf.replaceAll(RegExp(r'\r\n|\r|\n'), ' ');
    rtf = rtf.replaceAll(RegExp(r'\s+'), ' ').trim();

    // Handle special characters
    Map<String, String> specialChars = {
      r"\'89": "‰",
      r"\'8a": "Š",
      r"\'8b": "‹",
      r"\'8c": "Œ",
      r"\'8e": "Ž",
      r"\'91": "‘",
      r"\'92": "’",
      r"\'93": "“",
      r"\'94": "”",
      r"\'95": "•",
      r"\'96": "–",
      r"\'97": "—",
      r"\'98": "˜",
      r"\'99": "™",
      r"\'9a": "š",
      r"\'9b": "›",
      r"\'9c": "œ",
      r"\'9e": "ž",
      r"\'9f": "Ÿ",
      r"\'a1": "¡",
      r"\'a2": "¢",
      r"\'a3": "£",
      r"\'a4": "¤",
      r"\'a5": "¥",
      r"\'a6": "¦",
      r"\'a7": "§",
      r"\'a8": "¨",
      r"\'a9": "©",
      r"\'aa": "ª",
      r"\'ab": "«",
      r"\'ac": "¬",
      r"\'ae": "®",
      r"\'af": "¯",
      r"\'b0": "°",
      r"\'b1": "±",
      r"\'b2": "²",
      r"\'b3": "³",
      r"\'b4": "´",
      r"\'b5": "µ",
      r"\'b6": "¶",
      r"\'b7": "·",
      r"\'b8": "¸",
      r"\'b9": "¹",
      r"\'ba": "º",
      r"\'bb": "»",
      r"\'bc": "¼",
      r"\'bd": "½",
      r"\'be": "¾",
      r"\'bf": "¿",
      r"\'c0": "À",
      r"\'c1": "Á",
      r"\'c2": "Â",
      r"\'c3": "Ã",
      r"\'c4": "Ä",
      r"\'c5": "Å",
      r"\'c6": "Æ",
      r"\'c7": "Ç",
      r"\'c8": "È",
      r"\'c9": "É",
      r"\'ca": "Ê",
      r"\'cb": "Ë",
      r"\'cc": "Ì",
      r"\'cd": "Í",
      r"\'ce": "Î",
      r"\'cf": "Ï",
      r"\'d0": "Ð",
      r"\'d1": "Ñ",
      r"\'d2": "Ò",
      r"\'d3": "Ó",
      r"\'d4": "Ô",
      r"\'d5": "Õ",
      r"\'d6": "Ö",
      r"\'d7": "×",
      r"\'d8": "Ø",
      r"\'d9": "Ù",
      r"\'da": "Ú",
      r"\'db": "Û",
      r"\'dc": "Ü",
      r"\'dd": "Ý",
      r"\'de": "Þ",
      r"\'df": "ß",
      r"\'e0": "à",
      r"\'e1": "á",
      r"\'e2": "â",
      r"\'e3": "ã",
      r"\'e4": "ä",
      r"\'e5": "å",
      r"\'e6": "æ",
      r"\'e7": "ç",
      r"\'e8": "è",
      r"\'e9": "é",
      r"\'ea": "ê",
      r"\'eb": "ë",
      r"\'ec": "ì",
      r"\'ed": "í",
      r"\'ee": "î",
      r"\'ef": "ï",
      r"\'f0": "ð",
      r"\'f1": "ñ",
      r"\'f2": "ò",
      r"\'f3": "ó",
      r"\'f4": "ô",
      r"\'f5": "õ",
      r"\'f6": "ö",
      r"\'f7": "÷",
      r"\'f8": "ø",
      r"\'f9": "ù",
      r"\'fa": "ú",
      r"\'fb": "û",
      r"\'fc": "ü",
      r"\'fd": "ý",
      r"\'fe": "þ",
      r"\'ff": "ÿ"
    };

    specialChars.forEach((key, value) {
      rtf = rtf.replaceAll(key, value);
    });
    rtf = rtf.replaceAll("Times New Roman;", "");
    rtf = rtf.replaceAll("Arial \\(Arabic\\);", "");
    rtf = rtf.replaceAll("¬", "\n");

    return rtf;
  }

  /*  static String encrypts(String str) {
    if (str.equals("")) {
      return str;
    } else {
      String ss = "";
      for (int i = 0; i < str.length(); i++) {
        String sub = str.substring(i, i + 1).charAt(0);
        int asc = ((int) sub) - 10;
        String fChar = (char) asc;
        ss = ss + fChar;
      }
      return ss;
    }
  }
  */
  static String encrypt(String str) {
    if (str.isEmpty) {
      return str;
    } else {
      String ss = "";
      for (int i = 0; i < str.length; i++) {
        String sub = str.substring(i, i + 1);
        int asc = sub.codeUnitAt(0) -
            10; // Obtenir le code ASCII et soustraire 10
        String fChar = String.fromCharCode(
            asc); // Convertir le code ASCII en caractère
        ss = ss + fChar;
      }
      return ss;
    }
  }
}
