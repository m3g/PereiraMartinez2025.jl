import Pkg
Pkg.add("Documenter")
using Documenter
push!(LOAD_PATH, "../src/")
makedocs(
    modules = [PereiraMartinez2024],
    sitename = "PereiraMartinez2024.jl",
    pages = [
        "Home" => "index.md",
    ],
)
deploydocs(
    repo = "github.com/m3g/PereiraMartinez2024.jl.git",
    target = "build",
    branch = "gh-pages",
    versions = ["stable" => "v^", "v#.#"],
)
