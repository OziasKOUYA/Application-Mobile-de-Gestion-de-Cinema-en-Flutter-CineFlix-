import 'package:shared_preferences/shared_preferences.dart';

class ReservationService {
  static const String reservedFilmsKey = 'reserved_films';

  Future<void> reserveFilm(int filmId) async {
    final prefs = await SharedPreferences.getInstance();
    final reservedFilms = prefs.getStringList(reservedFilmsKey) ?? [];
    if (!reservedFilms.contains(filmId.toString())) {
      reservedFilms.add(filmId.toString());
      await prefs.setStringList(reservedFilmsKey, reservedFilms);
    }
  }

  Future<List<int>> getReservedFilms() async {
    final prefs = await SharedPreferences.getInstance();
    final reservedFilms = prefs.getStringList(reservedFilmsKey) ?? [];
    return reservedFilms.map((id) => int.parse(id)).toList();
  }

  Future<void> cancelReservation(int filmId) async {
    final prefs = await SharedPreferences.getInstance();
    final reservedFilms = prefs.getStringList(reservedFilmsKey) ?? [];
    reservedFilms.remove(filmId.toString());
    await prefs.setStringList(reservedFilmsKey, reservedFilms);
  }

 static Future<void> clearAllReservations() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(reservedFilmsKey);
  }
}
