resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

Author 'AlphaEnFolie'

client_script {
    -- RageUI
"RageUI/*.lua",
"shared/*.lua",
"client/*.lua"
}

server_script {
    "shared/*.lua",
    "server/*.lua"
}

ui_page "menu.html"

files {
    "menu.html",
    "style.css",
    "img/*.png",
}
