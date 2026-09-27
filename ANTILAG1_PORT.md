# Antilag 1 port scope

This branch ports the existing Dusty Antilag 1 behaviour to current
QW-Group/KTX.  It is not a new game mode and it does not change the
semantics of `sv_antilag 1`: players retain the current opt-in Antilag 1
behaviour, including hitscan correction, simple projectiles, weapon
prediction, accurate timing and the matching CSQC program.

## Explicit non-goals

This branch must not add player spray decals or any spray protocol support.
In particular it must not add `sprays.c`, `sv_sprays.c`, `clc_spray`,
`svc_spray`, `MVD_PEXT1_SPRAYS`, `G_SPRAY*`, or a spray cvar.

Sprays, if ever proposed, are a later opt-in feature series on top of the
finished Antilag 1 port.  They must be independently build-gated and disabled
by default.  Antilag 1 must remain complete and usable without them.

## Porting rules

* Start from current QW-Group/KTX rather than merging a downstream tree.
* Port only changes required for Antilag 1 and its matching CSQC support.
* Keep each logical protocol, server and CSQC change reviewable in its own
  commit where practical.
* Keep the EZCSQC weapon-definition table and KTX's emitted weapon IDs in the
  same revision. The current protocol reserves index zero and uses `1..8`.
* Announce EZCSQC from KTX itself so compatible unezQuake clients negotiate it
  without per-server configuration.
* Keep normal Antilag 0/2 behaviour unchanged when `sv_antilag` is not 1.

## Weapon-prediction time contract

Weapon prediction uses a client-relative clock.  The following values must
therefore remain in that same clock domain: `client_time`,
`attack_finished`, `client_nextthink`, and the predicted weapon animation
callback.  The server global clock is retained only to schedule the empty
server-side animation callback.

Mixing the clocks makes a newly connected client receive a small
`client_time` together with a large server-global `attack_finished`.  The
CSQC correctly waits forever for an attack that it can never reach, which
suppresses the authoritative weapon sound without starting the predicted one.

The player weapon paths schedule their next frame through the client clock;
`PlayerPostThink` executes that callback at the scheduled client time and
then restores the current value.  This is required for audio and animation
prediction, not merely for projectile visuals.

## File map

- `src/antilag.c`: rewind history, player and moving-world tracking, hitscan
  rewind, projectile catch-up and restore logic.
- `src/client.c`, `src/doors.c`, `src/plats.c`, `src/world.c`: lifecycle and
  per-frame state capture for players and moving world entities.
- `src/weapons.c`: wraps the existing hitscan and projectile weapon paths in
  rewind/restore boundaries.
- `include/*` and `src/g_syscalls.*`: declare the compact runtime contract and
  the `SetLastRuntime` extension used to avoid a duplicate engine advance.
- `qcsrc/main.qc`, `qcsrc/weaponpred.qc`, `qcsrc/antilag_csqc.qc`: native CSQC
  weapon prediction, simple projectiles, and only the CSQC declarations those
  modules use. The generated general-purpose extension catalogue is not part
  of this branch.

The gamecode build and CSQC build are both validated from this exact revision.
