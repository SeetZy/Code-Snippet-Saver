/*
  * Utility imports
 */
import 'package:app/db/db.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Authentication {
  Future<String?> register({
    required String email,
    required String password,
  }) async {
    final AuthResponse res = await SupabaseConstants.supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
    // final Session? session = res.session;
    // final User? user = res.user;
    return null;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final AuthResponse res =
        await SupabaseConstants.supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    // final Session? session = res.session;
    return null;
  }
}
