// LOOT CHEST MODELS (IF YOU DONT HAVE MY MODEL PACK YOU MUST REPLACE THESE MODELS)
#define TRASHCAN_CHEST_MODEL					"logical_m_loot_trashcan"
#define LOCKER_CHEST_MODEL						"logical_m_loot_locker"
#define SAFE_CHEST_MODEL						"logical_m_loot_safe"
#define WEAPONCRATE_CHEST_MODEL					"logical_m_loot_crate_weapon"
#define LEGENDARYCRATE_CHEST_MODEL				"logical_m_loot_crate_nuclear"


// LOOT POOL MODELS (IF YOU DONT HAVE MY MODEL PACK YOU MUST REPLACE THESE MODELS)
#define LOOTPOOL_POINTS_MODEL_SM				"logical_m_gold_brick_single"
#define LOOTPOOL_POINTS_MODEL_LG				"logical_m_gold_brick_group"

#define LOOTPOOL_AMMO_MODEL_SM					"logical_m_ammo_01_box"
#define LOOTPOOL_AMMO_MODEL_LG					"logical_m_ammo_01_bundle"

#define LOOTPOOL_POWERUP_MODEL_DP				"logical_m_iwz_pu_doublepoints"
#define LOOTPOOL_POWERUP_MODEL_IK				"logical_m_iwz_pu_instakill"
#define LOOTPOOL_POWERUP_MODEL_FS				"logical_m_iwz_pu_firesale"


// TRASHCAN CHEST VARS							// MIN/MAX CHEST SPAWN AMOUNT - MIN/MAX LOOT SPAWN AMOUNT
#define TRASHCAN_CHEST_MIN_AMOUNT				8
#define TRASHCAN_CHEST_MAX_AMOUNT				16

#define LOOT_MIN_TRASH_DROPS					2
#define LOOT_MAX_TRASH_DROPS					4


// LOCKER CHEST VARS							// MIN/MAX CHEST SPAWN AMOUNT - MIN/MAX LOOT SPAWN AMOUNT
#define LOCKER_CHEST_MIN_AMOUNT					6
#define LOCKER_CHEST_MAX_AMOUNT					12

#define LOOT_MIN_LOCKER_DROPS					3
#define LOOT_MAX_LOCKER_DROPS					5


// SAFE CHEST VARS								// MIN/MAX CHEST SPAWN AMOUNT - MIN/MAX LOOT SPAWN AMOUNT
#define SAFE_CHEST_MIN_AMOUNT					4
#define SAFE_CHEST_MAX_AMOUNT					8

#define LOOT_MIN_SAFE_DROPS						3
#define LOOT_MAX_SAFE_DROPS						6


// WEAPONCRATE CHEST VARS						// MIN/MAX CHEST SPAWN AMOUNT - MIN/MAX LOOT SPAWN AMOUNT
#define WEAPONCRATE_CHEST_MIN_AMOUNT			2
#define WEAPONCRATE_CHEST_MAX_AMOUNT			4

#define LOOT_MIN_WEAPONCRATE_DROPS				4
#define LOOT_MAX_WEAPONCRATE_DROPS				6


// LEGENDARY CRATE CHEST VARS 					// MIN/MAX CHEST SPAWN AMOUNT - MIN/MAX LOOT SPAWN AMOUNT
#define LEGENDARYCRATE_CHEST_MIN_AMOUNT			1
#define LEGENDARYCRATE_CHEST_MAX_AMOUNT			3

#define LOOT_MIN_LEGENDARY_DROPS				5
#define LOOT_MAX_LEGENDARY_DROPS				7


// LOOT WEIGHTS 								// LOWER NUMBER = HEAVIER, HIGHER NUMBER = LIGHTER
#define LOOT_WEIGHT_AMMO_SM						2
#define LOOT_WEIGHT_AMMO_LG						5
#define LOOT_WEIGHT_POINTS_SM					5
#define LOOT_WEIGHT_POINTS_LG					9
#define LOOT_WEIGHT_WEAPONS_PISTOLS				3
#define LOOT_WEIGHT_WEAPONS_ARS					10
#define LOOT_WEIGHT_WEAPONS_SMGS				8
#define LOOT_WEIGHT_WEAPONS_LMGS				9
#define LOOT_WEIGHT_WEAPONS_RPGS				10
#define LOOT_WEIGHT_WEAPONS_SHOTGUNS			8
#define LOOT_WEIGHT_WEAPONS_SNIPERS				11
#define LOOT_WEIGHT_WEAPONS_MELEES				6
#define LOOT_WEIGHT_WEAPONS_WONDERWEAPONS		10
#define LOOT_WEIGHT_PERKS						4
#define LOOT_WEIGHT_POWERUPS					6.5

// LOOT DROP TIMER 								// TIME BEFORE LOOT DISAPPEARS
#define LOOT_DROP_TIMER							60

// WEAPONS 										// PLACE WEAPONS FROM EACH CLASS BELOW USING COMMAS ( , ) TO SEPARATE EACH STRING
//#define LOG_LOOTPOOL_WEAPONS_PISTOLS 			    "t9_magnum,t9_marshal,t9_tec9,t9_diamatti,iw8_x16,iw8_sykov"
//#define LOG_LOOTPOOL_WEAPONS_ARS 				    "iw8_ak47,iw8_an94,iw8_scar17s,iw8_grau556,iw8_m4a1_classic,iw8_m16a4,t9_aug,t9_carv2,t9_ffar1,t9_xm4"
//#define LOG_LOOTPOOL_WEAPONS_SMGS 				    "iw8_ak74u,iw8_cx9,iw8_iso,iw8_m4a1_smg,iw8_mp5,iw8_mp5k,iw8_mp5sd,iw8_mp7,t9_bullfrog,t9_ppsh41_drum"
//#define LOG_LOOTPOOL_WEAPONS_LMGS 				    "iw8_rpk,iw8_bruenmk,iw8_holger2,t9_aug_hbar"
//#define LOG_LOOTPOOL_WEAPONS_RPGS 				    "iw8_rpg7"
//#define LOG_LOOTPOOL_WEAPONS_SHOTGUNS 			    "iw8_jak12,iw8_model680,t9_gallo_sa12,t9_hauer77,t9_streetsweeper"
//#define LOG_LOOTPOOL_WEAPONS_SNIPERS 			    "iw8_ax50,iw8_hdr,iw8_kar98k_scope,t9_lw3_tundra,t9_zrg20mm,iw8_scar_tpr,iw8_kar98k_irons,iw8_m4a1_sniper,t9_m14classic"
//#define LOG_LOOTPOOL_WEAPONS_MELEES 			    "t9_nail_gun"
//#define LOG_LOOTPOOL_WEAPONS_WONDERWEAPONS 		    "tesla_gun,thundergun,ray_gun,t7_raygun_mark2"

// WEAPONS 										    // PLACE WEAPONS FROM EACH CLASS BELOW USING COMMAS ( , ) TO SEPARATE EACH STRING
#define LOG_LOOTPOOL_WEAPONS_PISTOLS 			"pistol_standard,pistol_burst,pistol_fullauto,pistol_revolver38,pistol_energy"
#define LOG_LOOTPOOL_WEAPONS_ARS 				"ar_accurate,ar_cqb,ar_damage,ar_longburst,ar_marksman,ar_standard,ar_famas,ar_garand,ar_peacekeeper"
#define LOG_LOOTPOOL_WEAPONS_SMGS 				"smg_burst,smg_capacity,smg_fastfire,smg_standard,smg_versatile,smg_mp40,smg_ppsh,smg_thompson,smg_sten"
#define LOG_LOOTPOOL_WEAPONS_LMGS 				"lmg_cqb,lmg_heavy,lmg_light,lmg_slowfire"
#define LOG_LOOTPOOL_WEAPONS_RPGS 				"launcher_standard,launcher_multi"
#define LOG_LOOTPOOL_WEAPONS_SHOTGUNS 			"shotgun_fullauto,shotgun_precision,shotgun_pump,shotgun_semiauto,shotgun_energy"
#define LOG_LOOTPOOL_WEAPONS_SNIPERS 			"sniper_fastbolt,sniper_fastsemi,sniper_powerbolt"
#define LOG_LOOTPOOL_WEAPONS_MELEES 			"special_crossbow_dw"
#define LOG_LOOTPOOL_WEAPONS_WONDERWEAPONS 		"ray_gun,tesla_gun,thundergun"
