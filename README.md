## Geofence App
application that will detect if the device is located inside of a geofence area
user will save the config or the current wifi and circle 
then the user will be able to check his/here current status in or outside the geofnce


## FEATURES
1. Users can save Wifi/circle config from configurations page  he can leave the wifi blank to get the current wifi or enter new wifi name by himself 
2. Users can check if he is inside our outside the geofence from the main page 



## Development Environment /Tools/Languages
1. Dart 
2. MVVM
3. flutter_bloc: ^6.1.2
4. dartz: ^0.9.1
5. data_connection_checker: ^0.3.4
6. shared_preferences: ^2.0.5
7. permission_handler: 6.1.1
8. wifi_info_flutter: ^2.0.0
9. connectivity: ^3.0.3
10. equatable: ^2.0.0
10. get_it: ^5.0.6


## Getting Started
```bash
git clone https://github.com/baraaaljabban/setel_geofence.git
cd setel_geofence
```

## Improvements
1. Bloc in both pages can be in one place so one listener will be there 
2. widget in Geofnce Page can be separated controller 
3. in the app util function saveCurrentWifiSsid and currentWifiSSID has same code in some area so it should be refactor inorder to take out duplicate code also they code be in one class that will be registered in injection service and call it then like what I did in bloc with input validator!
4. renaming some function to be more describing 

## Best Practise
1. Implemente Seperation of Concerns by applying MVVM clean architecture
2. Implement Dependency Injection for providing objects to required class by applying GET_IT library 
3. Implement BLOC pattern in order to sperate busnis logic and user interaction and manage the state of the application 
4. Implement UI/UX to show the user in fun way the current status 
5. the code is very commented so anyone can read it easly




