import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:setel_geofanc/core/Strings/export_strings.dart';
import 'package:setel_geofanc/features/geofence/data/datasource/geofence_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  void main() {
    GeofenceLocalDataSourceImpl localDataSourceImpl;
    MockSharedPreferences mockSharedPreferences;

    setUp(
      () {
        mockSharedPreferences = MockSharedPreferences();
        localDataSourceImpl = GeofenceLocalDataSourceImpl(
          sharedPreferences: mockSharedPreferences,
          
        );
      },
    );

    group("description", () {
      final wifiName = "Bjn";
      test("description", () async {
        when(mockSharedPreferences.getString(any)).thenReturn("Bjn");
        //act
        final result = localDataSourceImpl.getSavedWifiSsid();
        // assert
        verify(mockSharedPreferences.getString(CASHED_WIFI));
        expect(result, equals(wifiName));
      });
      // test("description", () async {});
    });

    // group("description", () {
    // });
  }
}
