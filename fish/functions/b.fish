# Defined in - @ line 1
function b -d "Fuzzy-find and checkout a branch"
  git branch | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end
