fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

name 'rex-butcher'
author 'RexShackGaming'
description 'Advanced butcher system for RSG Framework'
version '2.1.1'
url 'https://discord.gg/YUV7ebzkqs'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
}

client_scripts {
    'client/client.lua',
    'client/npcs.lua'
}

server_scripts {
    'server/server.lua',
    'server/versionchecker.lua'
}

dependencies {
    'rsg-core',
    'ox_lib',
    'ox_target',
}

files {
  'locales/*.json'
}

this_is_a_map 'yes'

escrow_ignore {
    'installation/*',
    'locales/*',
    'shared/*',
    'README.md'
}

lua54 'yes'
