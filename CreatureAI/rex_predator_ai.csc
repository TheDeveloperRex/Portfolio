
#using scripts\codescripts\struct;

#using scripts\shared\abilities\gadgets\_gadget_camo;

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
#using scripts\shared\beam_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;

#using scripts\zm\_util;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_utility;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace rex_predator_ai;

#define PREDATOR_LAUNCHER_CHARGE_FX "REX/ai/predator/launcher_charge"

#precache( "client_fx", "rex_predator_laser_beam" );
#precache( "client_fx", PREDATOR_LAUNCHER_CHARGE_FX );

REGISTER_SYSTEM( "rex_predator", &__init__, undefined )

function __init__()
{
	clientfield::register( "scriptmover", "rex_laser_charge", VERSION_SHIP, 1, "int", &LaserChargeFX, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "scriptmover", "rex_laser_beam", 15000, 1, "int", &predator_laser, 0, 0 ); // scriptmover = script ent | actor = ai
	clientfield::register( "toplayer", "rex_emp_pfx", VERSION_SHIP, 1, "int", &EMPPFX, 0, 0 );
}

function DefaultSetUIModelValue( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump )
{
    SetUIModelValue( CreateUIModel( GetUIModelForController( localClientNum ), fieldName ), newVal );
}

function LaserChargeFX( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump )
{
	switch( newVal )
	{
		case 0:
		{
			if( isdefined( self.chargefx ) )
			{
				DeleteFX( localClientNum, self.chargefx );
				self.chargefx = undefined;
			}
			break;
		}
		case 1:
		{
			if( !isdefined( self.chargefx ) )
				self.chargefx = PlayFXOnTag( localClientNum, PREDATOR_LAUNCHER_CHARGE_FX, self, "tag_origin" );
			break;
		}
	}
}

function EMPPFX( n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump )
{
	switch( n_new )
	{
		case 0:
			if( IS_TRUE( self.emp_enabled ) )
			{
				self thread postfx::StopPostfxBundle();
				self.emp_enabled = false;
			}
			break;
		case 1:
			if( !IS_TRUE( self.emp_enabled ) )
			{
				self thread postfx::PlayPostfxBundle( "rex_predator_emp_pfx" );
				self.emp_enabled = true;
			}
			break;
	}
}

function predator_laser( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump )
{
	if( newVal )
	{
		if( !isdefined( self.beam_target ) )
		{
			self.beam_target = util::spawn_model( localClientNum, "tag_origin", self.origin, self.angles );
			self thread predator_handle_laser( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump );
		}
	}
	else
	{
		if( isdefined( self.beam_target ) )
		{
			level beam::kill( self, "tag_launcher", self.beam_target, "tag_origin", "rex_predator_laser_beam" );
			self.beam_target Delete();
		}
	}
}

function predator_handle_laser( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump )
{
	player = ArrayGetClosest( self.origin, level.localplayers );
	self.beam_target.origin = ( player.origin + VectorScale( AnglesToUp( self.angles ), 36 ) );

	level beam::launch( self, "tag_launcher", self.beam_target, "tag_origin", "rex_predator_laser_beam" );
	
	while( isdefined( self.beam_target ) )
	{
		origin = ( player.origin + VectorScale( AnglesToUp( self.angles ), 36 ) );
		v_offset = VectorScale( AnglesToUp( player.angles ), ( RandomIntRange( 5, 30 ) * ( ( RandomInt( 2 ) ) ? -1 : 1 ) ) );
		h_offset = VectorScale( AnglesToRight( player.angles ), ( RandomIntRange( 5, 10 ) * ( ( RandomInt( 2 ) ) ? -1 : 1 ) ) );

		player = ArrayGetClosest( self.origin, level.localplayers );
		self.beam_target.origin = ( origin + v_offset + h_offset );	
		wait( 0.45 );
	}
}
