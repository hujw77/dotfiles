function c
    set -l dirs ~/{workspace/*,workspace/contract/evolutionlandorg/*,workspace/contract/darwinia/*}
    set -l directory (command ls -d -1 $dirs 2>/dev/null | fzf --tiebreak=length,begin,end)
    if test -n "$directory"
        and test -d $directory
        cd $directory
    end
end
