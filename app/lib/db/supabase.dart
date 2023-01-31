/*
  * Utility imports
 */
// ? https://pub.dev/packages/supabase_flutter
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConstants {
  static const String projURL = "https://yuntfqhaqiabigogffon.supabase.co";
  static const String apiKEY =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl1bnRmcWhhcWlhYmlnb2dmZm9uIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzUxNzUyNDQsImV4cCI6MTk5MDc1MTI0NH0.zdV3WwB1H6qCUPbFOw2NMsZNwovOnfUitcNa5019_nk";

  static SupabaseClient supabaseClient = SupabaseClient(projURL, apiKEY);
}
