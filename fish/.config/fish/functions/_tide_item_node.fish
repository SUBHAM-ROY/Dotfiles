function _tide_item_node
    #check if current directory is a node project
    if test -f package.json -o -d node_modules
        set -l v (node -v 2>/dev/null)
        _tide_print_item node $tide_node_icon' ' $v
    end
end
