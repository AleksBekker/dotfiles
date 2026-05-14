# macOS path_helper integration
if test -x /usr/libexec/path_helper
    eval (/usr/libexec/path_helper -c)
end

# Path configuration

set -gx GOPATH "$HOME/go"
set -gx VOLTA_HOME "$HOME/.volta"

# Add paths (only if directory exists)
# fish_add_path automatically handles deduplication and prepends to PATH
set new_paths \
    "$HOME/.cargo/bin" \
    "$VOLTA_HOME/bin" \
    "$GOPATH/bin" \
    "$HOME/.local/bin" \
    "$HOME/bin" \
    "$HOME/.deno/bin"

for new_path in $new_paths
    if test -d $new_path
        fish_add_path --prepend $new_path
    end
end
