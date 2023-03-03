resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
version '1.0'


dependencies {
	'OuDayasLIB'
}

client_scripts {
	"traduzione1.lua",
	"config.lua",
	"client/main.lua"
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	"config.lua",
	"server/main.lua"	
}