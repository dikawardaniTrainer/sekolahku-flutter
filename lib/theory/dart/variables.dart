// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, prefer_const_declarations, avoid_init_to_null

void sampleVariableDeclaration() {
  var variableName;
  final variableName2 = null;
  int age = 100;

  print(variableName);
  variableName = "Dika";
  print(variableName);
  variableName = 100;
  print(variableName);
  print(variableName2);
  print(age);
  age = 30;
  print(age);
  // variableName2 = "Dika";
}

void sampleStringData() {
  var name = 'Dika Wardani';
  const name2 = 'Somebody';
  String name3 = '''
  In publishing and graphic design, Lorem ipsum is a placeholder text commonly 
  used to demonstrate the visual form of a document or a typeface without 
  relying on meaningful content. Lorem ipsum may be used as a 
  placeholder before final copy is available.
  ''';

  print(name);
  print(name2);
  print(name3);
}

void sampleInt() {
  var positive = 30;
  var negative = -90;
  var decimal = 8.9023;
  int? x = null;

  print(positive);
  print(negative);
  print(decimal);
  print(x);
  x = 100;
  print(x);
}

void sampleMaps() {
  var gifts = {
    "first": "Car",
    "second": "Motor",
    "third" : "Bicycle"
  };
  var gifts2 = {
    1: "Car",
    2: "Motor",
    3 : "Bicycle"
  };
  Map<String, String> gifts3 = {
    'x': "Car",
    'y': "Motor",
    'z' : "Bicycle"
  };
  var gifts4 = {
    1: 100,
    "second": "Motor",
    "third" : 8.5
  };

  print(gifts["first"]);
  print(gifts2[2]);
  print(gifts);
  print(gifts2);
  print(gifts3);
  print(gifts4);
  print(gifts4[0]);
  print(gifts4[1]);
  print(gifts4["third"]);
  gifts4.remove(1);
  print(gifts4);
  gifts4.putIfAbsent("baru", () => "Data baru masuk");
  print(gifts4);
}

void sampleList() {
  var numbers = [1, 2, 3, 4, 5];
  var list = [1, "Dika", "Wardani", 8.293];
  List<int> points = [2323, 234, 234, 13];

  print(numbers);
  print(numbers[4]);
  print(list);
  print(list[0]);
  print(list[1]);
  print(points);
  points.removeAt(1);
  print(points);
}