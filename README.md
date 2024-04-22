# git-sparse-clone
Clone only the requested parts of a Git repository.
```
usage: git-sparse-clone.sh [-h | --help] <repository> [<remote paths...>] [-o | --output <output path>]
```
## Examples
```
git-sparse-clone https://github.com/user/repository *.cpp *.h /CMakeLists.txt
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
