var _gifts = {
  "first": "Car",
  "second": "Motor",
  "third" : "Bicycle"
};

String? findFirstGift() {
  return _gifts["first"];
}

findGiftByKey(Object key) {
  var secondGift = _gifts[key];
  if (secondGift != null) {
    return secondGift;
  } else {
    return 0;
  }
}