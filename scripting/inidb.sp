#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Tetragromaton"
#define PLUGIN_VERSION "1.0"

#include <sourcemod>
#include <sdktools>
#include <inidb>
#include <morecolors>
char EnvironmentFolder[1024];
public Plugin myinfo = 
{
	name = ".INI Data Saver", 
	author = PLUGIN_AUTHOR, 
	description = "", 
	version = PLUGIN_VERSION, 
	url = "https://hlmod.ru/members/tetragromaton.80537/"
};
//Зачем удалять код, когда его можно закомментить ?)
//Говно код залог успеха ! :)
ConVar RuntimeModeCV;
public APLRes AskPluginLoad2(Handle hMyself, bool bLate, char[] sError, int iErr_max)
{
	CreateNative("INIDB_TakeData", Native_TakeData);
	CreateNative("INIDB_InsertData", Native_InsertData);
	CreateNative("INIDB_TakeDataInt", Native_TakeDataInt);
	CreateNative("INIDB_InsertDataInt", Native_InsertDataInt);
	CreateNative("INIDB_DestroyPackage", Native_DestroyPackage);
	CreateNative("INIDB_DoesExist", Native_CheckFile);
	RegPluginLibrary("inidb");
	return APLRes_Success;
}

public int Native_CheckFile(Handle hPlugin, int iNumParams)
{
	char sid[255];
	GetNativeString(1, sid, sizeof(sid));
	int wtf = 0; 
	if(IsExist(sid))
	{
		wtf = 1;
	}
	return wtf;
}
bool IsExist(const char[] sid)
{
	char SIDProto[255];
	Format(SIDProto, sizeof(SIDProto), "%s%s.ini", EnvironmentFolder, sid);
	KeyValues hKeyValues = new KeyValues("GlobalKey");
	bool Obtained = false;
	if (hKeyValues.ImportFromFile(SIDProto))
	{
		Obtained = true;
	} else {
		
	}
	if (Obtained == true)
	{
		
	}
	CloseHandle(hKeyValues);
	return Obtained;
}
public int Native_TakeData(Handle hPlugin, int iNumParams)
{
	//stock TakeData
	//(const char[] sid, const char[] packed , const char[] variable, String:value[], int size, int client = -1)
	char sid[255];
	char packed[255];
	char variable[255];
	//char value[255];
	//int size;
	int client;
	char return2[2048];
	GetNativeString(1, sid, sizeof(sid));
	GetNativeString(2, packed, sizeof(packed));
	GetNativeString(3, variable, 255);
	//size = GetNativeCell(5);
	client = GetNativeCell(6);
	//GetNativeString(4, value, sizeof(value));
	TakeData(sid, packed, variable, return2, sizeof(return2), client);
	SetNativeString(4, return2, sizeof(return2));
	return 0;
}
public int Native_DestroyPackage(Handle hPlugin, int iNumParams)
{
	char sid[255];
	char packed[255];
	int client;
	GetNativeString(1, sid, sizeof(sid));
	GetNativeString(2, packed, sizeof(packed));
	client = GetNativeCell(3);
	DeletePackage(sid, packed, client);
	return 0;
}
public int Native_TakeDataInt(Handle hPlugin, int iNumParams)
{
	//stock TakeData
	//(const char[] sid, const char[] packed , const char[] variable, String:value[], int size, int client = -1)
	char sid[255];
	char packed[255];
	char variable[255];
	int client;
	char return2[2048];
	GetNativeString(1, sid, sizeof(sid));
	GetNativeString(2, packed, sizeof(packed));
	GetNativeString(3, variable, 255);
	client = GetNativeCell(4);
	TakeData(sid, packed, variable, return2, sizeof(return2), client);
	int gg = StringToInt(return2);
	return gg;
}
public int Native_InsertData(Handle hPlugin, int iNumParams)
{
	char sid[255];
	char packed[255];
	char variable[255];
	char value[255];
	int client;
	//char return2[2048];
	GetNativeString(1, sid, sizeof(sid));
	GetNativeString(2, packed, sizeof(packed));
	GetNativeString(3, variable, 255);
	GetNativeString(4, value, 255);
	client = GetNativeCell(5);
	//InsertData
	//(const char[] sid, const char[] packed , const char[] variable, const char[] value, int client = -1)
	InsertData(sid, packed, variable, value, client);
	return 0;
}
public int Native_InsertDataInt(Handle hPlugin, int iNumParams)
{
	char sid[255];
	char packed[255];
	char variable[255];
	int value;
	int client;
	//char return2[2048];
	GetNativeString(1, sid, sizeof(sid));
	GetNativeString(2, packed, sizeof(packed));
	GetNativeString(3, variable, 255);
	value = GetNativeCell(4);
	client = GetNativeCell(5);
	//InsertData
	//(const char[] sid, const char[] packed , const char[] variable, const char[] value, int client = -1)
	char puu[1024];
	IntToString(value, puu, sizeof(puu));
	InsertData(sid, packed, variable, puu, client);
	return 0;
}
public void OnPluginStart()
{
	BuildPath(Path_SM, EnvironmentFolder, sizeof(EnvironmentFolder), "inidb/");
	//PrintToChatAll("ENVIRONMENT FOLDER : home/inidb/%s", EnvironmentFolder);
	//RegAdminCmd("regacc", Command_CreateAccount, ADMFLAG_ROOT);
	//RegAdminCmd("debugDB", DBTEST, ADMFLAG_ROOT);
	//RegAdminCmd("takeVAL", DBTAKE, ADMFLAG_ROOT);
	//RegAdminCmd("testDBnative", Tg, ADMFLAG_BAN);
	RuntimeModeCV = CreateConVar("INIDB_RuntimeMode", "1");//1 - usual 2 - dont register player profiles, global file only.
	//AutoExecConfig(true, "inidb");
}
public OnPluginEnd()
{
	//Unload safe.
	ServerCommand("sm plugins load inidb");
}
public Action Tg(client, args)
{
	//char gg[255];
	//PrintToChatAll("Invoke native test.");
	//INIDB_TakeData("", "Fruits", "Apples", gg, sizeof(gg), client);
	//PrintToChatAll("returned %s", gg);
	//PrintToChatAll("Insert data package-> Fruits->Apples: 99");
	//INIDB_InsertData("", "Fruits", "apples", "99", client);
	DeletePackage("", "Fireworks", client);
}
public Action DBTAKE(client, args)
{
	char wtt[255];
	//PrintToChatAll("Start STRESS test of DB");
	//for (new i = 0; i < 10000; i++)
	//{
	TakeData("", "Usual", "WasBanned", wtt, sizeof(wtt), client);
	//}
	//PrintToChatAll("RETURN %s", wtt);
}
public Action DBTEST(client, args)
{
	//Pr
}
stock DeletePackage(const char[] sid, const char[] packed, int client = -1)
{
	char wtf[255];
	char SIDProto[255];
	if (client >= 0)
	{
		GetClientAuthId(client, AuthId_Steam2, wtf, sizeof(wtf));
		Format(SIDProto, sizeof(SIDProto), "%s%s.ini", EnvironmentFolder, wtf);
	} else Format(SIDProto, sizeof(SIDProto), "%s%s.ini", EnvironmentFolder, sid);
	KeyValues hKeyValues = new KeyValues("GlobalKey");
	bool Obtained = false;
	if (hKeyValues.ImportFromFile(SIDProto))
	{
		Obtained = true;
	} else {
		
	}
	if (Obtained == true)
	{
		if(KvJumpToKey(hKeyValues, packed, false) == true)
		{
		hKeyValues.DeleteThis();
		hKeyValues.Rewind();
		hKeyValues.ExportToFile(SIDProto);
		//PrintToChatAll("deb");
		}
	}
	//CloseHandle(hKeyValues);
	RequestFrame(AutoDelete, hKeyValues);
	delete hKeyValues;
}
stock TakeData(const char[] sid, const char[] packed, const char[] variable, String:value[], int size, int client = -1)
{
	char wtf[255];
	char SIDProto[255];
	if (client >= 0)
	{
		GetClientAuthId(client, AuthId_Steam2, wtf, sizeof(wtf));
		Format(SIDProto, sizeof(SIDProto), "%s%s.ini", EnvironmentFolder, wtf);
	} else Format(SIDProto, sizeof(SIDProto), "%s%s.ini", EnvironmentFolder, sid);
	KeyValues hKeyValues = new KeyValues("GlobalKey");
	bool Obtained = false;
	if (hKeyValues.ImportFromFile(SIDProto))
	{
		Obtained = true;
	} else {
		
	}
	if (Obtained == true)
	{
		char CSRF[2048];
		hKeyValues.JumpToKey(packed, true);
		KvGetString(hKeyValues, variable, CSRF, sizeof(CSRF));
		//hKeyValues.Rewind();
		//CloseHandle(hKeyValues);
		RequestFrame(AutoDelete, hKeyValues);
		delete hKeyValues;
		return Format(value, size, CSRF);
	}
	//CloseHandle(hKeyValues);
	RequestFrame(AutoDelete, hKeyValues);
	delete hKeyValues;
}
public void AutoDelete(Handle thing)
{
	//if(thing != INVALID_HANDLE)CloseHandle(thing);
}
bool InsertData(const char[] sid, const char[] packed, const char[] variable, const char[] value, int client = -1)
{
	char wtf[255];
	char SIDProto[255];
	if (client >= 0)
	{
		GetClientAuthId(client, AuthId_Steam2, wtf, sizeof(wtf));
		Format(SIDProto, sizeof(SIDProto), "%s%s.ini", EnvironmentFolder, wtf);
	} else Format(SIDProto, sizeof(SIDProto), "%s%s.ini", EnvironmentFolder, sid);
	KeyValues hKeyValues = new KeyValues("GlobalKey");
	bool Obtained = false;
	if (hKeyValues.ImportFromFile(SIDProto))
	{
		Obtained = true;
	} else {
		return false;
	}
	if (Obtained == true)
	{
		hKeyValues.JumpToKey(packed, true);
		//PrintToChatAll("%s %s", variable, value);
		hKeyValues.SetString(variable, value);
		hKeyValues.Rewind();
		hKeyValues.ExportToFile(SIDProto);
		RequestFrame(AutoDelete, hKeyValues);
		//CloseHandle(hKeyValues);
		delete hKeyValues;
		return true;
	}
	//CloseHandle(hKeyValues);
	delete hKeyValues;
}
public Action Command_CreateAccount(client, args)
{

}
public OnClientPutInServer(client)
{
	if(GetConVarInt(RuntimeModeCV) != 2)
	{
	char sid[255];
	GetClientAuthId(client, AuthId_Steam2, sid, sizeof(sid));
	if (StrContains(sid, "STOP_IGNORING_RETVALS", false) != -1)
	{
	}else {
		if(CreateSteamIDProfiler(sid) == false)
		{
			
		}
	}
	}
}

bool CreateSteamIDProfiler(const char[] SteamID)
{
	//PrintToChatAll("DEBUG: CREATE INI FILE FOR %s", SteamID);
	char SIDProto[255];
	Format(SIDProto, sizeof(SIDProto), "%s%s.ini", EnvironmentFolder, SteamID);
	KeyValues hKeyValues = new KeyValues("GlobalKey");
	
	if (hKeyValues.ImportFromFile(SIDProto))
	{
		return false;
	} else {
		KeyValues kv = new KeyValues("GlobalKey");
		kv.JumpToKey("Default", true);
		kv.SetString("Def", "Var");
		kv.Rewind();
		kv.ExportToFile(SIDProto);
		delete kv;
		
		/*
		PrintToChatAll("DEBUG: NO !");
		
		new Handle:FileHandle = OpenFile(SIDProto, "w+");
		
		
		WriteFileLine(FileHandle, "\"GlobalKey\"\n{\n}");
		//WriteFileLine(FileHandle, "{\n");
		//WriteFileLine(FileHandle, "}");
	//	WriteFileString(
		CloseHandle(FileHandle);
		return true;*/
	}
	CloseHandle(hKeyValues);
} 