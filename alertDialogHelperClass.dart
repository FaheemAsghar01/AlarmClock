class AlertDialogHelperClass {
  bool mon = false;
  bool tue = false;
  bool wed = false;
  bool thur = false;
  bool fri = false;
  bool sat = false;
  bool sund = false;

  String setAlertValues() {
    String val = '';
    if (mon == true) {
      val = val + ' Mon';
    }
    if (tue == true) {
      val = val + ' Tue';
    }
    if (wed == true) {
      val = val + ' Wed';
    }
    if (thur == true) {
      val = val + ' Thur';
    }
    if (fri == true) {
      val = val + ' Fri';
    }
    if (sat == true) {
      val = val + ' Sat';
    }
    if (sund == true) {
      val = val + ' Sun';
    }
    return val;
  }

  List<String> getSetValues() {
    String ans = setAlertValues();
    return ans.split(' ');
  }

  get monday {
    return mon;
  }

  get tuesday {
    return tue;
  }

  get wednesday {
    return wed;
  }

  get thursday {
    return thur;
  }

  get friday {
    return fri;
  }

  get saturday {
    return sat;
  }

  get sunday {
    return sund;
  }

  set mondayt(bool val) {
    mon = val;
  }

  set tuesdayt(bool val) {
    tue = val;
  }

  set wednesdayt(bool val) {
    wed = val;
  }

  set thursdayt(bool val) {
    thur = val;
  }

  set fridayt(bool val) {
    fri = val;
  }

  set saturdayt(bool val) {
    sat = val;
  }

  set sundayt(bool val) {
    sund = val;
  }
}
