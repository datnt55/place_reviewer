
abstract class PreferenceRepository{

  Future<bool> saveSession(String session);

  Future<String?> getSession();

}