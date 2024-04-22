# git-sparse-clone
Clone only the requested parts of a Git repository.
```
usage: git-sparse-clone.sh [-h | --help] <repository> [<remote paths...>] [-o | --output <output path>]
```
Wildcard is supported for remote paths.
Absolute paths can be specified by prepending a slash (`/README.md`). You can retrieve all files with the name `README.md` (regardless of their containing directory) by passing `README.md`.

An alternative Git location can be specified with the `$GIT` environment variable.

This script makes use of Git's `sparse-checkout` functionality to enable selective file retrieval. Only the files you request will be downloaded, as opposed to the (now deprecated) SVN strategy 
## Prerequisites
- Git (2.27.0 or newer)
- Modern bash and coreutils
## Examples
```
git-sparse-clone https://github.com/user/repository "*.cpp" "*.h" /CMakeLists.txt
...
repository
├── CMakeLists.txt
└── src
    ├── App.cpp
    ├── App.h
    └── main.cpp
```
```
git-sparse-clone https://github.com/user/repository /data -o output
...
output
└── data
    ├── 1.bin
    ├── 2.bin
    └── foo.bar
```
