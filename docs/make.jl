import Pkg
Pkg.add([
    "Documenter",
    "PlutoStaticHTML",
]
)
using Documenter
using PlutoStaticHTML: build_notebooks, BuildOptions, documenter_output, html_output

# Building markdown from Pluto notebooks
pluto_notebooks_dir = joinpath(@__DIR__, "src", "pluto_notebooks")
bopts = BuildOptions(
    pluto_notebooks_dir; 
    output_format=documenter_output, 
    previous_dir=pluto_notebooks_dir,
)
build_notebooks(bopts)

makedocs(
    sitename = "PereiraMartinez2024.jl",
    format=Documenter.HTML(;
        mathengine=Documenter.MathJax3(),
        size_threshold_ignore=[
            "pluto_notebooks/proteinA_urea.md",
            "pluto_notebooks/rnaset1_urea.md",
        ],
    ),
    pages = [
        "Home" => "index.md",
        "BdpA in urea" => "pluto_notebooks/proteinA_urea.md",
        "RNase T1 in urea" => "pluto_notebooks/rnaset1_urea.md",
    ],
)
deploydocs(
    repo = "github.com/m3g/PereiraMartinez2024.jl.git",
    target = "build",
    branch = "gh-pages",
    versions = ["stable" => "v^", "v#.#"],
)
