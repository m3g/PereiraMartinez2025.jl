import Pkg
Pkg.add([
    "Documenter",
    "Plots",
    "MolSimToolkit",
    "Unitful",
    "EasyFit",
    "Literate",
    "PlutoStaticHTML",
]
)
using Documenter
using Plots
using MolSimToolkit
using Unitful
using EasyFit
using Literate
using PlutoStaticHTML: build_notebooks, BuildOptions, documenter_output

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
