local name = "R"
local version = "4.1.3"

local root = "WHERETO"

if (mode() == "load") then

        prepend_path("PATH", pathJoin(root, "bin"))
        prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib64"))
        prepend_path("LIBRARY_PATH", pathJoin(root, "lib64"))
        prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib64/pkgconfig"))

        if(os.getenv("LMOD_SENS_VERB")) then
                LmodMessage("\n\tModule ", name, "version ", version, "chargé")
        end
        
end
