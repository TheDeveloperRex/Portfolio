
#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\fx_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_util;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_utility;

#define ORDA_HEAL_ARM_FX 		"REX/ai/orda/heal_club_consume"
#define ORDA_WEAKPOINT_FX 		"REX/ai/orda/weakpoint"

#precache( "client_fx", ORDA_HEAL_ARM_FX );
#precache( "client_fx", ORDA_WEAKPOINT_FX );

#namespace rex_orda_ai;

REGISTER_SYSTEM( "rex_orda", &__init__, undefined )

function __init__()
{
	// HEALTHBAR
    clientfield::register( "clientuimodel", "hudItems.CWBossHealthBar", VERSION_SHIP, 1, "int", &DefaultSetUIModelValue, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "clientuimodel", "hudItems.CWBossHealth", VERSION_SHIP, 20, "float", &DefaultSetUIModelValue, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );

    // DISENTEGRATION
	clientfield::register( "actor", "orda_disintegrate", 12000, 1, "int", &orda_disintegrate, 0, 0 );
	clientfield::register( "vehicle", "orda_disintegrate", 12000, 1, "int", &orda_disintegrate, 0, 0 );
	
	// HEAL
	clientfield::register( "scriptmover", "orda_heal", VERSION_SHIP, 1, "int", &HealFX, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );

	// WEAKPOINT
	clientfield::register( "scriptmover", "orda_weakpoint", VERSION_SHIP, 1, "int", &WeakpointFX, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );

    duplicate_render::set_dr_filter_framebuffer( "dissolve", 10, "dissolve_on", undefined, 0, "mc/mtl_c_zom_dlc3_zombie_dissolve_base", 0 );
}

function autoexec init()
{
	util::register_system( "CWBossName", &CWBossNameUpdate );
}

function orda_disintegrate( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump )
{
	self endon( "entity_shutdown" );
	self duplicate_render::set_dr_flag( "dissolve_on", newVal );
	self duplicate_render::update_dr_filters( localClientNum );
	self.n_dissolve = 1;

	self MapShaderConstant( localClientNum, 0, "scriptVector0" );

	while( isdefined( self ) && self.n_dissolve > 0 )
	{ 
		self MapShaderConstant( localClientNum, 0, "scriptVector0", self.n_dissolve );
		self.n_dissolve = self.n_dissolve - 0.015;
		wait( 0.15 );
	}
	if( isdefined( self ) )
	{
		self MapShaderConstant( localClientNum, 0, "scriptVector0", 0 );
	}
}

function HealFX( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump )
{
	if( newVal )
		if( !isdefined( self.fx ) )
			self.fx = PlayFXOnTag( localClientNum, ORDA_HEAL_ARM_FX , self, "tag_origin" );
    else
	{
		if( isdefined( self.fx ) )
        	DeleteFX( localClientNum, self.fx );
        self.fx = undefined;
    }
}

function WeakpointFX( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump )
{
	switch( newVal )
	{
		case 0:
		{
			if( isdefined( self.fx ) )
			{
				DeleteFX( localClientNum, self.fx );
				self.fx = undefined;
			}
			break;
		}
		case 1:
		{
			if( !isdefined( self.fx ) )
				self.fx = PlayFXOnTag( localClientNum, ORDA_WEAKPOINT_FX, self, "tag_origin" );
			break;
		}
	}
}

function CWBossNameUpdate( localClientNum, newVal, oldVal )
{
	self DefaultSetUIModelValue( localClientNum, oldVal, newVal, false, undefined, "hudItems.CWBossName", false );
	SetUIModelValue( GetUIModel( GetUIModelForController( localClientNum ), "hudItems.CWBossName" ), newVal );
}

function DefaultSetUIModelValue( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump )
{
    SetUIModelValue( CreateUIModel( GetUIModelForController( localClientNum ), fieldName ), newVal );
}
