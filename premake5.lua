workspace "BeefLinking"
    architecture "x64"
    startproject "BeefLinking"

    configurations
    {
        "Debug",
        "Release"
    }
	
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "BeefLibrary"
    location "BeefLibrary"
    kind "Makefile"
	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    buildcommands 
    {
        "build.bat $(Configuration)"
    }

    rebuildcommands 
    {
        "build.bat $(Configuration)_Rebuild"
    }

    cleancommands
    {
        "build.bat Clean"
    }

project "BeefLinking"
	location "BeefLinking"
    kind "ConsoleApp"
    language "C++"
	cppdialect "C++14"
	staticruntime "off"

	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.c",
        "%{prj.name}/src/**.hpp",
        "%{prj.name}/src/**.cpp",
    }

    includedirs
    {
        "%{prj.name}/src",
    }

    libdirs
    {
        "C:/Program Files/BeefLang/bin/"
    }

    links
    {
        "C:/Program Files/BeefLang/bin/Beef042RT64_ssd.lib",
        "%{wks.location}/BeefLibrary/build/Debug_Win64/BeefLibrary/*.lib",
        "%{wks.location}/BeefLibrary/build/Debug_Win64/corlib/*.lib",
    }

    filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
        systemversion "latest"
		
    filter "configurations:Debug"
        symbols "on"
        runtime "Debug"
		buildoptions "/MTd"
    filter "configurations:Release"
        optimize "on"
        runtime "Release"
		buildoptions "/MT"