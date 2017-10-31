function git.next
    set branch intermediate-workshop-part1-end
    if count $argv > /dev/null
        set branch $argv[1]
    end

    git checkout (git log --reverse --ancestry-path HEAD..$branch --pretty=%h | head -1)
end

