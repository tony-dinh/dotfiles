alias ls='ls -FG'

# find everything in the current subdirectories matching a secified regex
findr () {   
    find . * | grep ${1}
}
