#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q libation | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/libation.svg
export DESKTOP=/usr/share/applications/Libation.desktop
#export DEPLOY_DOTNET=1 fails for some reason

# Deploy dependencies
mkdir -p ./AppDir/bin
cp -r /usr/lib/libation/* ./AppDir/bin
quick-sharun $(find ./AppDir/bin -type f ! -name '*.dll' ! -name '*.json' -print)

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
