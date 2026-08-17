/*
 * Minimal CSQC interface for the Antilag 1 weapon-prediction module.
 * Keep this limited to symbols consumed by main.qc and weaponpred.qc.
 */
#pragma target FTE

entity self;
entity world;
float time;
float frametime;
float player_localentnum;
float player_localnum;
float intermission;
vector v_forward;
vector v_right;
vector trace_endpos;
float trace_fraction;
vector input_angles;
float input_buttons;
float input_impulse;
float input_timelength;
vector pmove_org;
float clientcommandframe;
float servercommandframe;

.float modelindex;
.vector origin;
.vector velocity;
.vector angles;
.float frame;
.float frame2;
.float lerpfrac;
.float effects;
.float modelflags;
.float renderflags;
.float drawmask;
.float() predraw;

const float TRUE = 1;
const float FALSE = 0;
#define __NULL__ world
const float CHAN_WEAPON = 1;
const float ATTN_NONE = 0;
const float MOVE_NOMONSTERS = 1;
const float EF_NOSHADOW = 4096;
const float MF_ROCKET = 1;
const float MF_GRENADE = 2;
const float MASK_ENGINE = 1;
const float MASK_PRED_VIEWMODEL = 256;
const float PREDRAW_AUTOADD = 0;
const float PREDRAW_NEXT = 1;
const float VF_DRAWENGINESBAR = 20;
const float VF_DRAWCROSSHAIR = 21;
const float RF_VIEWMODEL = 1;
const float STAT_ITEMS = 15;
const string INFOKEY_P_PING = "ping";

void(vector angles) makevectors = #1;
void(entity entity, vector origin) setorigin = #2;
void(entity entity, string model) setmodel = #3;
void(entity entity) remove = #15;
void(vector start, vector end, float flags, entity ignore) traceline = #16;
float(vector value) vlen = #12;
float(float value) fabs = #43;
float(string value) stof = #81;
float(float first, float second, ...) max = #95;
void(entity entity, float channel, string sample, float volume, float attenuation, optional float pitch, optional float flags) sound = #8;
entity() spawn = #14;
vector(vector value) vectoangles = #51;
int(string value) stoi = #259;

void(string model) precache_model = #91;
float(string model, optional float queryonly) getmodelindex = #200;
string(float modelindex) modelnameforindex = #334;
float(string effect) particleeffectnum = #335;
void(float effect, entity entity, vector start, vector end) trailparticles = #336;
float(float player, string key, optional float defaultvalue) getplayerkeyfloat = #0:getplayerkeyfloat;
string(float seat, string key) getlocaluserinfo = #0:getlocaluserinfo;
float(string name, string value) registercvar = #93;
void() clearscene = #300;
void(float mask) addentities = #301;
float(float property, ...) setproperty = #303;
void() renderscene = #304;
float(vector origin, float radius, vector color, optional float style) dynamiclight_add = #305;
float(float sequence) getinputstate = #345;
float(float stat, optional float firstbit, optional float bitcount) getstatbits = #331;
float() ReadByte = #360;
float() ReadShort = #362;
float() ReadCoord = #364;
float() ReadAngle = #365;
float() ReadFloat = #367;
float() ReadEntityNum = #368;
