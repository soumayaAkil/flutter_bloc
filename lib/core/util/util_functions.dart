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

  static String filtreBackValide(String filtre, String filtreDetails,String valueRecherche) {
    String filtreBack = "date";

    if (filtre == "recherche"||valueRecherche!="") {
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

  static List<SearchCriteriaGroup> formatSearchCriteria(
      String datedeb,
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
    if (filtre == "recherche"|| valueRecherche!="") {

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
    //  rtf="{\rtf1\ansi\deff0\deftab720{\fonttbl{\f0\fswiss MS Sans Serif;}{\f1\froman\fcharset2 Symbol;}{\f2\froman\fcharset178 Times New Roman;}{\f3\froman\fcharset178 Times New Roman;}{\f4\fswiss\fcharset178 Arial;}}";
    rtf = rtf.replaceAll("(?s)\\\\(par|line)(?=(\\W|\\w+\\s|\\s|[{}]))", "¬");
    rtf = rtf.replaceAll(
        "\\{\\*?\\\\[^{}]+\\}|\\\\(?=\\\\)|\\\\(?=[{}])|(?<!\\\\)[{}]|(?<!\\\\)\\\\[A-Za-z]+\n?(?:-?\\d+)?[ ]?",
        "");
    String speceialChars =
        "‰;Š;‹;Œ;;Ž;;;‘;’;“;”;•;–;—;~;™;š;›;œ;;ž;Ÿ;;¡;¢;£;¤;¥;¦;§;¨;©;ª;«;¬;(-);®;¯;°;±;²;³;´;µ;¶;·;¸;¹;º;»;¼;½;¾;¿;À;Á;Â;Ã;Ä;Å;Æ;Ç;È;É;Ê;Ë;Ì;Í;Î;Ï;Ð;Ñ;Ò;Ó;Ô;Õ;Ö;×;Ø;Ù;Ú;Û;Ü;Ý;Þ;ß;à;á;â;ã;ä;å;æ;ç;è;é;ê;ë;ì;í;î;ï;ð;ñ;ò;ó;ô;õ;ö;÷;ø;ù;ú;û;ü;ý;þ;ÿ";
    String speceialCharsCode =
        "\\\\'89;\\\\'8a;\\\\'8b;\\\\'8c;\\\\'8d;\\\\'8e;\\\\'8f;\\\\'90;\\\\'91;\\\\'92;\\\\'93;\\\\'94;\\\\'95;\\\\'96;\\\\'97;\\\\'98;\\\\'99;\\\\'9a;\\\\'9b;\\\\'9c;\\\\'9d;\\\\'9e;\\\\'9f;\\\\~;\\\\'a1;\\\\'a2;\\\\'a3;\\\\'a4;\\\\'a5;\\\\'a6;\\\\'a7;\\\\'a8;\\\\'a9;\\\\'aa;\\\\'ab;\\\\'ac;\\\\-;\\\\'ae;\\\\'af;\\\\'b0;\\\\'b1;\\\\'b2;\\\\'b3;\\\\'b4;\\\\'b5;\\\\'b6;\\\\'b7;\\\\'b8;\\\\'b9;\\\\'ba;\\\\'bb;\\\\'bc;\\\\'bd;\\\\'be;\\\\'bf;\\\\'c0;\\\\'c1;\\\\'c2;\\\\'c3;\\\\'c4;\\\\'c5;\\\\'c6;\\\\'c7;\\\\'c8;\\\\'c9;\\\\'ca;\\\\'cb;\\\\'cc;\\\\'cd;\\\\'ce;\\\\'cf;\\\\'d0;\\\\'d1;\\\\'d2;\\\\'d3;\\\\'d4;\\\\'d5;\\\\'d6;\\\\'d7;\\\\'d8;\\\\'d9;\\\\'da;\\\\'db;\\\\'dc;\\\\'dd;\\\\'de;\\\\'df;\\\\'e0;\\\\'e1;\\\\'e2;\\\\'e3;\\\\'e4;\\\\'e5;\\\\'e6;\\\\'e7;\\\\'e8;\\\\'e9;\\\\'ea;\\\\'eb;\\\\'ec;\\\\'ed;\\\\'ee;\\\\'ef;\\\\'f0;\\\\'f1;\\\\'f2;\\\\'f3;\\\\'f4;\\\\'f5;\\\\'f6;\\\\'f7;\\\\'f8;\\\\'f9;\\\\'fa;\\\\'fb;\\\\'fc;\\\\'fd;\\\\'fe;\\\\'ff";
    List<String> chars = speceialChars.split(";");
    List<String> charscodes = speceialCharsCode.split(";");
    for (int i = 0; i < chars.length; i++) {
      rtf = rtf.replaceAll(charscodes[i], chars[i]);
    }
    rtf = rtf.replaceAll("Times New Roman \\(Arabic\\);", "");
    rtf = rtf.replaceAll("Arial \\(Arabic\\);", "");
    rtf = rtf.replaceAll("¬", "\n");
    rtf = rtf.trim();
    return rtf;
  }
}
