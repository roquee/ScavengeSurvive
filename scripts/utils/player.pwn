SetPlayerToFacePlayer(playerid, targetid, Float:offset = 0.0)
{
	new
		Float:x1,
		Float:y1,
		Float:z1,
		Float:x2,
		Float:y2,
		Float:z2;

	GetPlayerPos(playerid, x1, y1, z1);
	GetPlayerPos(targetid, x2, y2, z2);
	SetPlayerFacingAngle(playerid, GetAngleToPoint(x1, y1, x2, y2) + offset);
}

SetPlayerToFaceVehicle(playerid, vehicleid, Float:offset = 0.0)
{
	new
		Float:x1,
		Float:y1,
		Float:z1,
		Float:x2,
		Float:y2,
		Float:z2;

	GetPlayerPos(playerid, x1, y1, z1);
	GetVehiclePos(vehicleid, x2, y2, z2);
	SetPlayerFacingAngle(playerid, GetAngleToPoint(x1, y1, x2, y2) + offset);
}

new Float:water_places[18][] =
{
	{25.0,			2313.0,		-1417.0,	23.0},
	{15.0,			1280.0,		-773.0,		1082.0},
	{15.0,			1279.0,		-804.0,		86.0},
	{20.0,			1094.0,		-674.0,		111.0},
	{26.0,			194.0,		-1232.0,	76.0},
	{25.0,			2583.0,		2385.0,		15.0},
	{25.0,			225.0,		-1187.0,	73.0},
	{50.0,			1973.0,		-1198.0,	17.0},
	{160.0,			1937.0, 	1589.0,		9.0},
	{55.0,			2142.0,		1285.0, 	8.0},
	{45.0,			2150.0,		1132.0,		8.0},
	{55.0,			2089.0,		1915.0,		10.0},
	{32.0,			2531.0,		1567.0,		9.0},
	{21.0,			2582.0,		2385.0,		17.0},
	{33.0,			1768.0,		2853.0,		10.0},
	{47.0,			-2721.0,	-466.0,		3.0},
	{210.0,			-671.0,		-1898.0,	6.0},
	{45.0,			1240.0,		-2381.0,	9.0}
};

stock IsPlayerInWater(playerid)
{
	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	if(z < 44.0)
	{
		if(Distance(x, y, z, -965.0, 2438.0, 42.0) <= 700.0)
			return 1;
	}

	for(new i; i < sizeof(water_places); i++)
	{
		if(Distance2D(x, y, water_places[i][1], water_places[i][2]) <= water_places[i][0])
		{
			if(z < water_places[i][3])
				return 1;
		}

		if(z < 1.5)
		{
			if(Distance(x, y, z, 618.4129, 863.3164, 1.0839) < 200.0)
				return 0;

			else 
				return 1;
		}
	}

	return 0;
}
CMD:inwater(playerid, params[])
{
	MsgF(playerid, YELLOW, "In Water: %d", IsPlayerInWater(playerid));
	return 1;
}
stock IsPlayerInArea(playerid, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
	new
		Float:x,
		Float:y,
		Float:pz;

	GetPlayerPos(playerid,x,y,pz);

	if(x >= MinX && x <= MaxX && y >= MinY && y <= MaxY)
	{
		return 1;
	}
	return 0;
}

GetClosestPlayerFromPlayer(playerid, Float:range = 10000.0)
{
	new
		Float:x1,
		Float:y1,
		Float:z1,
		Float:x2,
		Float:y2,
		Float:z2,
		Float:lowestdistance = range,
		Float:distance,
		closestplayer = -1;

	GetPlayerPos(playerid, x1, y1, z1);

	foreach(new i : Player)
	{
		if(i == playerid)
			continue;

		GetPlayerPos(i, x2, y2, z2);

		if(x2 == 0.0 && y2 == 0.0 && z2 == 0.0)
			continue;

		distance = Distance(x1, y1, z1, x2, y2, z1);

		if(distance < range)
		{
			if(distance < lowestdistance)
			{
				lowestdistance = distance;
				closestplayer = i;
			}
		}
	}

	return closestplayer;
}

new CameraModeNames[66][37]=
{
	"MODE_NONE",
	"MODE_TOPDOWN",
	"MODE_GTACLASSIC",
	"MODE_BEHINDCAR",
	"MODE_FOLLOWPED",
	"MODE_AIMING",
	"MODE_DEBUG",
	"MODE_SNIPER",
	"MODE_ROCKETLAUNCHER",
	"MODE_MODELVIEW",
	"MODE_BILL",
	"MODE_SYPHON",
	"MODE_CIRCLE",
	"MODE_CHEESYZOOM",
	"MODE_WHEELCAM",
	"MODE_FIXED",
	"MODE_1STPERSON",
	"MODE_FLYBY",
	"MODE_CAM_ON_A_STRING",
	"MODE_REACTION",
	"MODE_FOLLOW_PED_WITH_BIND",
	"MODE_CHRIS",
	"MODE_BEHINDBOAT",
	"MODE_PLAYER_FALLEN_WATER",
	"MODE_CAM_ON_TRAIN_ROOF",
	"MODE_CAM_RUNNING_SIDE_TRAIN",
	"MODE_BLOOD_ON_THE_TRACKS",
	"MODE_IM_THE_PASSENGER_WOOWOO",
	"MODE_SYPHON_CRIM_IN_FRONT",
	"MODE_PED_DEAD_BABY",
	"MODE_PILLOWS_PAPS",
	"MODE_LOOK_AT_CARS",
	"MODE_ARRESTCAM_ONE",
	"MODE_ARRESTCAM_TWO",
	"MODE_M16_1STPERSON",
	"MODE_SPECIAL_FIXED_FOR_SYPHON",
	"MODE_FIGHT_CAM",
	"MODE_TOP_DOWN_PED",
	"MODE_LIGHTHOUSE",
	"MODE_SNIPER_RUNABOUT",
	"MODE_ROCKETLAUNCHER_RUNABOUT",
	"MODE_1STPERSON_RUNABOUT",
	"MODE_M16_1STPERSON_RUNABOUT",
	"MODE_FIGHT_CAM_RUNABOUT",
	"MODE_EDITOR",
	"MODE_HELICANNON_1STPERSON",
	"MODE_CAMERA",
	"MODE_ATTACHCAM",
	"MODE_TWOPLAYER",
	"MODE_TWOPLAYER_IN_CAR_AND_SHOOTING",
	"MODE_TWOPLAYER_SEPARATE_CARS",
	"MODE_ROCKETLAUNCHER_HS",
	"MODE_ROCKETLAUNCHER_RUNABOUT_HS",
	"MODE_AIMWEAPON",
	"MODE_TWOPLAYER_SEPARATE_CARS_TOPDOWN",
	"MODE_AIMWEAPON_FROMCAR",
	"MODE_DW_HELI_CHASE",
	"MODE_DW_CAM_MAN",
	"MODE_DW_BIRDY",
	"MODE_DW_PLANE_SPOTTER",
	"MODE_DW_DOG_FIGHT",
	"MODE_DW_FISH",
	"MODE_DW_PLANECAM1",
	"MODE_DW_PLANECAM2",
	"MODE_DW_PLANECAM3",
	"MODE_AIMWEAPON_ATTACHED"
};

GetCameraModeName(cameramode, output[])
{
	if(!(0 <= cameramode <= 66))
		return 0;

	output[0] = EOS;
	strcat(output, CameraModeNames[cameramode], 37);

	return 1;
}
