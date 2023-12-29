extends Resource

const NAMES = {
	"first": [
		"Interstellar", "Red", "Black", "White", "Golden", "Galactic", "First", "Second", "Third",
		"Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Nineth", "Prime", "Free", "Pax", "United",
		"United", "Imperial", "Global", "Democratic", "Imperial", "Great", "Grand", "Holy", "Autonomous",
		"Royal", "Imperial", "Universal", "Independent", "Terran", "Central", "Greater", "Mercantile",
		"Immortal", "Old", "New", "Sacred", "Industrial", "Offworld", "Anarcho", "Outer", "Cosmic",
		"Alpha", "Elder", "Awakened", "Rogue", "Provisional", "Inner", "Sacred", "High", "Far", "Blue",
		"Elder", "Dark", "Lesser", "Shadow", "Eternal", "Uncharted", "Solar", "Vagrant", "Azure",
		"Sunlit", "Sunless", "Blighted", "Eldar", "Endless", "Divine", "Mad", "Heavenly", "Military",
		"Arch-", "Meta-", "Emerald", "Crimson", "Cerulean", "Shining", "Obsidian", "Bronze", "Golden",
		"Silver", "Elerium", "Elysian", "Neo-", "Enlisted", "Hyperion",
		"Anarchic", "Solar", "Terran", "Sol", "Socialist", "Serpent", "Phoenix", "Earth", "Martian",
		"Venutian", "Titanic", "Andromedan", "Proxima", "Centauri", "Lunar", "Orion", "Scorpion",
		"Syndical", "Stellar", "Merchants", "Trade", "Drone", "World", "Planetary", "Global", "Imperial",
		"Fallen", "Science", "Mutant", "Empyrean", "Industrial", "Mining", "Polaris", "Antares", "Ursan",
		"Rigel", "Vega", "Deneb", "Cygnus", "Aquilan", "Carinaen", "Zubenel", "Spice", "Gateway", "Libran",
		"Aquarian", "Epsilon", "Lambda", "Aurigan", "Bootean", "Pirate", "Slaver(s)", "Synthetic", "Synth",
		"Shadow", "Revolutionary", "Nomadic", "Xenos", "Capital", "Merchant", "Android", "Robotic", "Curator",
		"Vanguard", "Viceroy", "Magisters", "Praetorian", "Defense", "Emperors", "Automated", "Allied",
		"Algorithmic", "Sacred", "Binary", "Callistan", "Oberon", "Umbral", "Orbital", "Galilean",
		"Aegir", "Kepler", "Administrative", "Arcturan", "Altari", "Draconis", "Ursa", "Comet", "Orbitar",
		"Ion", "Gamma", "Alpha", "Beta", "Omega", "Tangled", "Gothic", "Vortex"
	],
	"last": [
		"Dominion", "Comissariat", "Confederation", "Empire", "Order", "Federation", "Dominion", "Union",
		"Confederation", "Empire", "Order", "Federation", "Separatists", "Commonwealth", "Sectors",
		"Worlds", "Constellation", "Union", "League", "League", "Order", "Command", "Edict", "Corp",
		"Planets", "Systems", "Accord", "Syndicate", "Coalition", "Ascendancy", "Authority", "Republic",
		"Collective", "Cooperative", "Elite", "Tribe", "Triumvirate", "Consulate", "Network", "Sortition",
		"Territories", "Brotherhood", "Expanse", "Systems", "Dynasty", "Directorate", "Imperium", "Hive",
		"Alliance", "Primacy", "Hegemony", "Covenant", "Singularity", "Raiders", "Khanate", "Sultanate",
		"Shogunate", "Consortium", "Commune", "Ministry", "Inquisition", "Swarm", "Infinitum", "Megaciv",
		"Megacorp", "Incorporated", "Domain", "Citizenry", "Polystate", "Invictus", "Moons", "Symbiote",
		"Hive", "Elders", "Transcendancy", "Thralls", "Hierarchy", "Council", "Protectorate", "Guilds",
		"Continuum", "Conclave", "Swarm", "Synthesis", "Excommunicate", "Regime", "Suns", "Czardom",
		"Kingdom", "Sisterhood", "Syndicate", "Guard", "Flotilla", "Fleet", "Divinate", "System",
		"Symbiote", "Belt", "Network", "Barony", "Princes", "Nebula", "Nomads", "Void", "Travellers",
		"Pligrmage", "Enclave", "Cyberocracy", "Magocracy", "Seerdom", "Crusade", "Front", "Horde",
		"Corporation", "LLC.", "Megastate", "Reserve", "Pact", "Bloc", "Ring", "Concord", "Cabal", "Combine",
		"Concordat", "Fellowship", "Consortia", "Assembly", "Faction", "Construct", "Clan", "Clans",
		"Confluence", "Concordia", "Corps", "Inc", "Cluster", "Zone", "Region", "Territory", "Compact",
		"Rift", "Reef", "Reach", "Triad"
	],
}


func generate_faction():
	var new_faction = Faction.new()
	new_faction.name = "%s %s" % [
		NAMES.first[randi() % NAMES.first.size()],
		NAMES.last[randi() % NAMES.last.size()]
	]
	new_faction.desc = "Faction Description"
	new_faction.hostility = 0
	return new_faction

