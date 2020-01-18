/*
**
*/
#if defined _INIDB_included
 #endinput
#endif
#define _INIDB_included


//SteamID of person to read data from. Packed - Container name, variable - variable to take, value - String to copy value to. do Client if you lazy to take sid.
native int INIDB_TakeData(const char[] SteamID, const char[] packed, const char[] variable, String:value[], int size, int client = -1);
native int INIDB_InsertData(const char[] sid, const char[] packed, const char[] variable, const char[] value, int client = -1);
native int INIDB_TakeDataInt(const char[] SteamID, const char[] packed, const char[] variable, int client = -1);
native int INIDB_InsertDataInt(const char[] sid, const char[] packed, const char[] variable, int value, int client = -1);
native int INIDB_DestroyPackage(const char[] sid, const char[] packed, int client = -1);
native int INIDB_DoesExist(const char[] sid);