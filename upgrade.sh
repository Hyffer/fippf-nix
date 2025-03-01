# nix-init required

NIX_FILE="default.nix"
URL="https://github.com/Hyffer/fippf"

OLD_VERSION=$(grep -oP 'version = "\K[^"]+' "$NIX_FILE")
echo "old version: $OLD_VERSION"

mv ${NIX_FILE} ${NIX_FILE}-old

nix-init -u ${URL}

NEW_VERSION=$(grep -oP 'version = "\K[^"]+' "$NIX_FILE")
SRC_HASH=$(grep -oP 'hash = "\K[^"]+' "$NIX_FILE")
VENDOR_HASH=$(grep -oP 'vendorHash = "\K[^"]+' "$NIX_FILE")

if [[ -z "$NEW_VERSION" || -z "$SRC_HASH" || -z "$VENDOR_HASH" ]]; then
    echo "Failed to extract new values from generated $NIX_FILE"
    exit 1
fi

echo "Upgrade from $OLD_VERSION to $NEW_VERSION"
echo "hash: $SRC_HASH"
echo "vendorHash: $VENDOR_HASH"

rm ${NIX_FILE}
mv ${NIX_FILE}-old ${NIX_FILE}

sed -i "s|version = \".*\";|version = \"${NEW_VERSION}\";|" "$NIX_FILE"
sed -i "s|hash = \"[^\"]*\";|hash = \"${SRC_HASH}\";|" "$NIX_FILE"
sed -i "s|vendorHash = \"[^\"]*\";|vendorHash = \"${VENDOR_HASH}\";|" "$NIX_FILE"

