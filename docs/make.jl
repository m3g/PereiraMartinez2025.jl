import Pkg
Pkg.add([
    "Documenter",
    "PlutoSliderServer",
    "CRC32",
]
)
using Documenter
import PlutoSliderServer
import CRC32

# build html pages of the pluto notebooks, only if the jl was updated
nbs = [
    "$(@__DIR__)/src/pluto_notebooks/rnaset1_urea.jl",
    "$(@__DIR__)/src/pluto_notebooks/rnaset1_tmao.jl",
    "$(@__DIR__)/src/pluto_notebooks/proteinA_urea.jl",
    "$(@__DIR__)/src/pluto_notebooks/proteinA_tmao.jl",
    "$(@__DIR__)/src/pluto_notebooks/sh3_urea.jl",
    "$(@__DIR__)/src/pluto_notebooks/sh3_tmao.jl",
]
for nb in nbs
    checksum_file = tempdir()*"/"*string(open(CRC32.crc32,nb))
    if isfile(checksum_file)
        println("Notebook $nb was not updated.")
    else
        PlutoSliderServer.export_notebook(nb)
        open(checksum_file, "w") do io write(io, "") end
    end
end

makedocs(
    sitename = "PereiraMartinez2025.jl",
    format=Documenter.HTML(;
        mathengine=Documenter.MathJax3(),
        size_threshold_ignore=[
            "$(@__DIR__)/rnaset1_urea.md",
            "$(@__DIR__)/rnaset1_tmao.md",
            "$(@__DIR__)/proteinA_urea.md",
            "$(@__DIR__)/proteinA_tmao.md",
            "$(@__DIR__)/sh3_urea.md",
            "$(@__DIR__)/sh3_tmao.md",
        ],
    ),
    pages = [
        "Home" => "index.md",
        "BdpA in urea" => "proteinA_urea.md",
        "BdpA in tmao" => "proteinA_tmao.md",
        "SH3 in urea" => "sh3_urea.md",
        "SH3 in tmao" => "sh3_tmao.md",
        "RNase T1 in urea" => "rnaset1_urea.md",
        "RNase T1 in tmao" => "rnaset1_tmao.md",
    ],
)
deploydocs(
    repo = "github.com/m3g/PereiraMartinez2025.jl.git",
    target = "build",
    branch = "gh-pages",
    versions = ["stable" => "v^", "v#.#"],
)


