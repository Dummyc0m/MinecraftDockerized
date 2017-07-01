#!/bin/sh

set -e

if [ ! -f mc.jar ]; then
  echo "Downloading Minecraft Version $Version"
  wget -O mc.jar "https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/minecraft_server.${VERSION}.jar"
fi

fix_ownership() {
  dir=$1
  if ! su-exec minecraft test -w $dir; then
    echo "Correcting writability of $dir ..."
    chown -R minecraft:minecraft $dir
    chmod -R u+w $dir
  fi
}

fix_ownership /data

su-exec minecraft echo eula=true > eula.txt && java $JAVA_OPTS -jar mc.jar $@