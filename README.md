# IniDB<br>
This is a scripting addition for your plugins, save/read data that you want just in a few strings !.<br>
<b>DISCLAIMER ! I DO NOT CARE IF SOMETHING WENT WRONG WHILE SAVING ANY SENSETIVE DATA ON YOUR SIDE. Use at your own risk !</b><br>
<br>ᅠ
<br>
Installation:<br>
1)Create inidb folder in addons/sourcemod folder.<br>
2)Set permissons on inidb to 777<br>
3)Drop smx plugin in plugins folder and run it.<br>
ᅠ<br>
Natives list:<br>
native int INIDB_TakeData(const char[] SteamID, const char[] packed, const char[] variable, String:value[], int size, int client = -1);//Fetch string from package.<br>
ᅠ
native int INIDB_InsertData(const char[] sid, const char[] packed, const char[] variable, const char[] value, int client = -1);//Store string in package.<br>
ᅠ
native int INIDB_TakeDataInt(const char[] SteamID, const char[] packed, const char[] variable, int client = -1);//Store as int variable from package.<br>
ᅠ
native int INIDB_InsertDataInt(const char[] sid, const char[] packed, const char[] variable, int value, int client = -1);//Quickly insert 
integer value inside variable)<br>
ᅠ
native int INIDB_DestroyPackage(const char[] sid, const char[] packed, int client = -1);//Destroy package that contains variables in it.
(eg. FruitBin package will be destroyed with all of variables in it).<br>
ᅠ
native int INIDB_DoesExist(const char[] sid);//Check steamid in inidb folder on existance.<br>


Usage examples:<br>
<br>
if(INIDB_TakeDataInt("", "FruitBin", "Apples", client) > 0)<br>
{<br>
//Do something if player has more than 0 apples in FrutBin package.<br>
}else INIDB_InsertDataInt("", "FruitBin", "Apples", 333, client);//This will set 333 apples on client.<br>

<h3>Todo's</h3><br>
1)Do plugin runtime modes (1 - Do not register new user accounts ini files, 2 - default, register all the players and etc.)
