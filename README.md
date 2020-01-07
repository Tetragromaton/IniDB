# IniDB
Save data of players or something other .INI files. Made for Sourcemod
This is a scripting addition for your plugins, save/read data in one strings or a little more.
WARNING ! I DO NOT CARE IF SOMETHING WENT WRONG WHILE SAVING ANY SENSETIVE DATA ON YOUR SIDE. Use at your own risk !
ᅠ
ᅠ
Installation:
1)Create inidb folder in addons/sourcemod folder.
2)Set permissons on inidb to 777
3)Drop smx plugin in plugins folder and run it.
ᅠ
Natives list:
native int INIDB_TakeData(const char[] SteamID, const char[] packed, const char[] variable, String:value[], int size, int client = -1);//Fetch string from package.
ᅠ
native int INIDB_InsertData(const char[] sid, const char[] packed, const char[] variable, const char[] value, int client = -1);//Store string in package.
ᅠ
native int INIDB_TakeDataInt(const char[] SteamID, const char[] packed, const char[] variable, int client = -1);//Store as int variable from package.
ᅠ
native int INIDB_InsertDataInt(const char[] sid, const char[] packed, const char[] variable, int value, int client = -1);//Quickly insert 
integer value inside variable)
ᅠ
native int INIDB_DestroyPackage(const char[] sid, const char[] packed, int client = -1);//Destroy package that contains variables in it.
(eg. FruitBin package will be destroyed with all of variables in it).
ᅠ
native int INIDB_DoesExist(const char[] sid);//Check steamid in inidb folder on existance.


Usage examples:

if(INIDB_TakeDataInt("", "FruitBin", "Apples", client) > 0)
{
//Do something if player has more than 0 apples in FrutBin package.
}else INIDB_InsertDataInt("", "FruitBin", "Apples", 333, client);//This will set 333 apples on client.
