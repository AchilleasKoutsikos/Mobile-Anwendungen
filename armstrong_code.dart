import 'dart:io';
import 'dart:math';

void main() {

  // Aufforderung an den Benutzer, eine Zahl einzugeben
  print("Enter a number.");

  // Eingabe der Zahl durch den Benutzer
  int? einge_nummer = int.parse(stdin.readLineSync()!); // ? und ! für Nullsicherheit

  // Initialisierung der Summenvariable
  int? summe = 0;

  // Bestimmen der Länge der eingegebenen Zahl
  var nummer_leange = "$einge_nummer".length;

  // Konvertieren der eingegebenen Zahl in einen String
  String zu_string = "$einge_nummer";

  // Durchlaufen jeder Ziffer der eingegebenen Zahl
  for(int i = 0; i < nummer_leange; i++){
    // Konvertieren jeder Ziffer von String zu Integer
    int t = int.parse(zu_string[i]);
    // Hinzufügen der Ziffer, die zur Potenz der Anzahl der Ziffern erhöht ist, zur Summe
    summe = pow(t, nummer_leange) + summe! as int?;
  }

  // Überprüfen, ob die Summe der ursprünglichen eingegebenen Zahl entspricht
  if(summe == einge_nummer){
    print("$einge_nummer is a Amstrong number.");
  }else if(summe != einge_nummer){
    print("$einge_nummer is not a Amstrong number.");
  }

}