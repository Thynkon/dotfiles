### Packaging
set -x CHROOT "$HOME/packaging/chroot"
if not test -d $CHROOT
    mkdir -p $CHROOT
end
