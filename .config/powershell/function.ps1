#
# Functions
#

function Get-GitStatus {
    & git status $args
}

function Edit-EmacsCUI {
    emacs -nw $args
}
