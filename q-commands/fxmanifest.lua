fx_version "adamant"
game "gta5"
lua54 'yes'

author 'qweeertyyyy'
version '1.0.0'

server_script "server.lua"
client_script "client.lua"

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'config.lua'
}