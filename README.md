# Deep Space Grind: Credits Rule Everything Around Me

### General
This Diablo-like Shmup is inspired by shareware-era vertical shooters like Raptor and Tyrian, at least in terms of shooting mechanics, along with whatever modern innovations that seem appropriate to add (bullet eating, grazing, combos, using bombs to power supers, etc.).
But there is also a small amount of inspiration from the secret mission objectives from TIE Fighter, where you work for the Emperor’s inner circle in addition to the Imperial Navy.
The idea is running multiple hustles by juggling various faction jobs, milking them for profit while trying not to get caught. A more contemporary inspiration is also from Star Wars: when we first meet Han Solo again in The Force Awakens, and he’s in the middle of 3 to 4 side hustles blowing up in his face.
Fire up the game, play a mission, make some kind of progress each time. Whether doing one mission, a few missions, or binging for hours, time should feel well spent.
Aesthetic: Raptor, Tyrian, Raiden
Tone: Should not take itself seriously, high drama matches poorly with arcade gameplay. Idiot dirtbag assholes in space. Incredible future tech manned by jagoffs who have no business handling it. 
Sound: Chunky and thumping like an old arcade cabinet. Dirty, filthy synth farts.

### The Space Station
The player operates from a local space station in the current system. It functions as a hub and main interface for the player. Various areas of the space station act as the interface for different mechanics. Space stations should be a little varied in appearance, to emphasize that the player is this itinerant mercenary, hopping between rented spaces to earn a living and maybe one day strike it big.
Quarters: Manage collected intel, contact information brokers, view mission list, and fly missions.
Hangar: Manage ship loadout and configuration, buy/sell equipment.
Bar: Gather random stuff through news, rumors. Basically like Wirt from Diablo 1. Mini-games like poker, pool, pinball. Mostly for fun, but occasionally can unlock bonus money, intel, or equipment.

### Campaigns
Players can travel to various planets in semi randomly generated systems or galaxies. Space station is the hub for a system. The state of a system and the available missions will change every time the player runs a mission. How the system changes depends on what mission the player runs and what objectives were completed/failed. This progression usually culminates in a final mission to conclude the ‘campaign’ for that system. Once that mission is run, the player moves on to a new system. The player can also abandon a system early, either by paying a scaling fee, or using a special item.

### Factions / Employers
A system will have multiple factions competing for control in it. When a campaign begins, each faction controls varying amounts of the system. Completing mission objectives will usually strengthen and/or weaken the influence of the factions associated with them. If a faction’s influence is critically low, a special mission to eliminate that faction from the system will appear in the mission list.
Factions also have ‘awareness’ of the player’s actions. If the player is responsible for heavy influence loss for a faction, the faction may turn hostile to the player. This results in being unable to run missions for that faction, and in extreme cases bounty hunter mini-bosses may appear to disrupt missions (player has to either fight the mini-boss instead of the intended mission, or attempt to escape and possibly take damage before the mission even starts).

### Missions
Missions play out as vertical shoot ‘em up levels, similar to Tyrian, or Raptor. Mission score translates to pay and campaign progress/development. Combination of the above as bonus/secret objectives, etc.
Mission Properties
- Environment: Type, Size
- Enemies: Type, Faction, Density
- Hazards: Environmental effects

Hazards
- Weather: storms with various effects, bonus/penalty to energy weapons, decreased weapon range, erratic shields, low light/visibility
- Damage: Meteor showers, orbital bombardment
- Obstacles: Space debris, asteroid fields, mines

Mission Objectives 
- Raid: Cause X amount of damage within time limit, or destroy X number of targets within time limit
- Smuggling: Avoid taking damage and get cargo past blockades, pirates, and rival factions
- Piracy: Intercept target and steal cargo
- Interception: Destroy incoming targets, don’t let any pass
- Assault: Fight through enemy defenses, destroy boss

Information Broker
The information broker is a kind of crafting system to create missions, similar to the mapping mechanic in Path of Exile. Intel fragments are bits and pieces of mission info that are used to modify mission properties. Using intel fragments, players can make missions easier or harder, leading to either lesser or greater rewards accordingly.

### Intel and Other Valuables
During missions, various items will appear after destroying enemy units and structures. These can be picked up for various benefits.

Debris: Repair hull damage, or refill shields
Valuables: Cargo, scrap, cash, data storage, etc. Worth money, or part of mission objectives. 
Intel fragments: Collect intel fragments, then take them to the information broker to decrypt and assemble them to ‘craft’ missions

### Ship Configuration
IDEA: Debris Recycler, a device that allows you to salvage enemy remains to restore armor. Different types of recycler have various features/abilities. Some affect the type of debris you can reclaim (scrap metal, rocks/minerals, xeno-matter, etc.). Some affect the type of resource that is regained (armor, shield energy, heat dispersal). Some have extremely long/short pickup distance, or fast/slow collection speed. Destroying enemies/obstacles generates a cloud of debris pickups. The recycler you have equipped determines what the debris restores.

Configuring and maintaining your ship should be similar to how you hustle factions for work. You juggle and balance conflicting systems to get the most bang for your buck, and deal with the blowback from your tinkering.

Ships have a skill tree represented by a circuit grid, which can be slotted with modules. Equipment modules include weapons, shields, engines, etc. Upgrade modules modify the behaviour of equipment modules they are connected to. Upgrades include basic effects like increased damage, faster shield recharge, etc. and also more complex effects like homing projectiles.

Ships from different manufacturers have different characteristics and design quirks, like having global bonuses or penalties to equipment modules, different rules for power distribution, etc.

When grouped closely together, modules can start to have positive or negative interactions with each other, depending on the modules and sometimes the ship itself. When your systems aren’t tuned properly, bad things happen. This usually means steady hull damage, shield drain, or energy drain.

Fall-back system: All ships will revert to their default weapons and shields in the event of system failure. This reduces your ship to a pea shooter wrapped in tinfoil, but it’s better than nothing.

Approach 1: Heat management
Weapons and special equipment generate heat when used. Heat meter fills up as heat builds. After the heat bar is maxed, the ship starts taking hull damage. Some modules will raise the minimum heat level, making overheating a bigger threat. Unbalanced systems will also have the same effect, or increase the rate of heat generation.
Special Item: Coolant Tank. Single-use item, drains all heat. 

Approach 2: Energy management
Weapons and special equipment use energy when used. Energy meter recharges based on engine stats. Some modules will ‘reserve’ energy (refer to auras in Path of Exile). Unbalanced systems will bleed energy, slow energy recharge, or lower max energy.
Special Item: Fusion Battery. Single-use item, refills energy meter.

### Ship Characteristics
Hull
Max capacity
Damage resistance
Special abilities (grazing, bullet eating, etc.)
Shield
Max capacity
Damage resistance
Recharge rate
Special abilities (bullet eating, reflection, etc.)
Engine
Energy output
Recharge rate
Movement ability (speed boost, quick dodge, etc.)
Primary Weapon
Damage
Fire rate
Pattern spread
Projectile speed
Secondary Weapon
Damage
Fire rate
Pattern spread
Projectile speed
Special Equipment (2-4 slots)
Fusion Battery / Coolant Tank
Hull Repair
Shield Booster
Smart Bomb

Tyrian shield system: Shields will drain power to regenerate to full. If the engine cannot meet the power cost because weapons are draining too much power, shield will not recharge

### Enemies
Air units
Ground units
Alien creatures

### Items and Itemization
Weapon object
Fire weapon
Rate of fire
Energy usage
Firing Script
Number of projectiles
Position of projectiles
Projectile Script
Step behavior of projectile
Collision Script
Explosion and damage
Flash, smoke, other effects
