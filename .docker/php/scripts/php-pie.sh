echo "Installing PIE (PHP Installer for Extensions)..."

# Download a pinned PIE PHAR release
PIE_VERSION="${PIE_VERSION:-1.5.3}"
PIE_URL="https://github.com/php/pie/releases/download/${PIE_VERSION}/pie.phar"

echo "Downloading PIE ${PIE_VERSION}..."
curl -fL "${PIE_URL}" -o /tmp/pie.phar

# Verify the download worked
if [ ! -f /tmp/pie.phar ]; then
    echo "ERROR: Failed to download PIE"
    exit 1
fi

# Make it executable
chmod +x /tmp/pie.phar

# Move to /usr/local/bin so it's in PATH
mv /tmp/pie.phar /usr/local/bin/pie

# Verify installation
echo "Verifying PIE installation..."
pie --version

echo "PIE installation complete!"