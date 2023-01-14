#!/system/bin/sh
ROOT_DIR=${ROOT_DIR:-$PWD/bitgapps_overlay}
SYSTEM=${SYSTEM:-/system}
ZIPFILE="/tmp/MicroG-v1.8.zip"
TMP="/tmp/MicroG-v1.8"
# Compressed Packages
ZIP_FILE="$TMP/zip"
# Extracted Packages
mkdir -p $TMP/unzip
# Initial link
UNZIP_DIR="$TMP/unzip"
# Create links
TMP_SYS="$UNZIP_DIR/tmp_sys"
TMP_PRIV="$UNZIP_DIR/tmp_priv"
TMP_PRIV_SETUP="$UNZIP_DIR/tmp_priv_setup"
TMP_FRAMEWORK="$UNZIP_DIR/tmp_framework"
TMP_SYSCONFIG="$UNZIP_DIR/tmp_config"
TMP_DEFAULT="$UNZIP_DIR/tmp_default"
TMP_PERMISSION="$UNZIP_DIR/tmp_perm"
TMP_PREFERRED="$UNZIP_DIR/tmp_pref"
TMP_OVERLAY="$UNZIP_DIR/tmp_overlay"
mkdir -p $TMP_SYS $TMP_PRIV $TMP_PRIV_SETUP $TMP_FRAMEWORK $TMP_SYSCONFIG $TMP_DEFAULT $TMP_PERMISSION $TMP_PREFERRED $TMP_OVERLAY
# Installing
echo "- Installing MicroG"
ZIP="zip/core/DroidGuard.tar
      zip/core/Extension.tar
      zip/core/MicroGGMSCore.tar
      zip/core/MicroGGSFProxy.tar
      zip/core/Phonesky.tar
      zip/sys/AppleNLPBackend.tar
      zip/sys/DejaVuNLPBackend.tar
      zip/sys/FossDroid.tar
      zip/sys/LocalGSMNLPBackend.tar
      zip/sys/LocalWiFiNLPBackend.tar
      zip/sys/MozillaUnifiedNLPBackend.tar
      zip/sys/NominatimNLPBackend.tar
      zip/Sysconfig.tar
      zip/Default.tar
      zip/Permissions.tar
      zip/overlay/PlayStoreOverlay.tar"
#for f in $ZIP; do $(unzip -oq "$ZIPFILE" "$f" -d "$TMP"); done
for f in $ZIP; do unzip -oq "$ZIPFILE" "$f" -d "$TMP"; done
tar -xf $ZIP_FILE/sys/AppleNLPBackend.tar -C $TMP_SYS
tar -xf $ZIP_FILE/sys/DejaVuNLPBackend.tar -C $TMP_SYS
tar -xf $ZIP_FILE/sys/FossDroid.tar -C $TMP_SYS
tar -xf $ZIP_FILE/sys/LocalGSMNLPBackend.tar -C $TMP_SYS
tar -xf $ZIP_FILE/sys/LocalWiFiNLPBackend.tar -C $TMP_SYS
tar -xf $ZIP_FILE/sys/MozillaUnifiedNLPBackend.tar -C $TMP_SYS
tar -xf $ZIP_FILE/sys/NominatimNLPBackend.tar -C $TMP_SYS
tar -xf $ZIP_FILE/core/DroidGuard.tar -C $TMP_PRIV
tar -xf $ZIP_FILE/core/Extension.tar -C $TMP_PRIV
tar -xf $ZIP_FILE/core/MicroGGMSCore.tar -C $TMP_PRIV
tar -xf $ZIP_FILE/core/MicroGGSFProxy.tar -C $TMP_PRIV
tar -xf $ZIP_FILE/core/Phonesky.tar -C $TMP_PRIV
tar -xf $ZIP_FILE/Sysconfig.tar -C $TMP_SYSCONFIG
tar -xf $ZIP_FILE/Default.tar -C $TMP_DEFAULT
tar -xf $ZIP_FILE/Permissions.tar -C $TMP_PERMISSION
tar -xf $ZIP_FILE/overlay/PlayStoreOverlay.tar -C $TMP_OVERLAY 2>/dev/null
echo "- Extract done"
SYSTEM=${ROOT_DIR}${SYSTEM}
SYSTEM_ADDOND="$SYSTEM/addon.d"
SYSTEM_APP="$SYSTEM/app"
SYSTEM_PRIV_APP="$SYSTEM/priv-app"
SYSTEM_ETC_CONFIG="$SYSTEM/etc/sysconfig"
SYSTEM_ETC_DEFAULT="$SYSTEM/etc/default-permissions"
SYSTEM_ETC_PERM="$SYSTEM/etc/permissions"
SYSTEM_ETC_PREF="$SYSTEM/etc/preferred-apps"
SYSTEM_FRAMEWORK="$SYSTEM/framework"
SYSTEM_OVERLAY="$SYSTEM/product/overlay"
DEST='-f6-'
#pkg_TMPSys
file_list="$(find "$TMP_SYS/" -mindepth 1 -type f | cut -d/ ${DEST})"
dir_list="$(find "$TMP_SYS/" -mindepth 1 -type d | cut -d/ ${DEST})"
for file in $file_list; do
  install -D "$TMP_SYS/${file}" "$SYSTEM_APP/${file}"
  chmod 0644 "$SYSTEM_APP/${file}"
done
for dir in $dir_list; do
  chmod 0755 "$SYSTEM_APP/${dir}"
done
# pkg_TMPPriv
file_list="$(find "$TMP_PRIV/" -mindepth 1 -type f | cut -d/ ${DEST})"
dir_list="$(find "$TMP_PRIV/" -mindepth 1 -type d | cut -d/ ${DEST})"
for file in $file_list; do
  install -D "$TMP_PRIV/${file}" "$SYSTEM_PRIV_APP/${file}"
  chmod 0644 "$SYSTEM_PRIV_APP/${file}"
done
for dir in $dir_list; do
  chmod 0755 "$SYSTEM_PRIV_APP/${dir}"
done
# pkg_TMPSetup
file_list="$(find "$TMP_PRIV_SETUP/" -mindepth 1 -type f | cut -d/ ${DEST})"
dir_list="$(find "$TMP_PRIV_SETUP/" -mindepth 1 -type d | cut -d/ ${DEST})"
for file in $file_list; do
  install -D "$TMP_PRIV_SETUP/${file}" "$SYSTEM_PRIV_APP/${file}"
  chmod 0644 "$SYSTEM_PRIV_APP/${file}"
done
for dir in $dir_list; do
  chmod 0755 "$SYSTEM_PRIV_APP/${dir}"
done
# pkg_TMPFramework
file_list="$(find "$TMP_FRAMEWORK/" -mindepth 1 -type f | cut -d/ ${DEST})"
dir_list="$(find "$TMP_FRAMEWORK/" -mindepth 1 -type d | cut -d/ ${DEST})"
for file in $file_list; do
  install -D "$TMP_FRAMEWORK/${file}" "$SYSTEM_FRAMEWORK/${file}"
  chmod 0644 "$SYSTEM_FRAMEWORK/${file}"
done
for dir in $dir_list; do
  chmod 0755 "$SYSTEM_FRAMEWORK/${dir}"
done
# pkg_TMPConfig
file_list="$(find "$TMP_SYSCONFIG/" -mindepth 1 -type f | cut -d/ ${DEST})"
dir_list="$(find "$TMP_SYSCONFIG/" -mindepth 1 -type d | cut -d/ ${DEST})"
for file in $file_list; do
  install -D "$TMP_SYSCONFIG/${file}" "$SYSTEM_ETC_CONFIG/${file}"
  chmod 0644 "$SYSTEM_ETC_CONFIG/${file}"
done
for dir in $dir_list; do
  chmod 0755 "$SYSTEM_ETC_CONFIG/${dir}"
done
# pkg_TMPDefault
file_list="$(find "$TMP_DEFAULT/" -mindepth 1 -type f | cut -d/ ${DEST})"
dir_list="$(find "$TMP_DEFAULT/" -mindepth 1 -type d | cut -d/ ${DEST})"
for file in $file_list; do
  install -D "$TMP_DEFAULT/${file}" "$SYSTEM_ETC_DEFAULT/${file}"
  chmod 0644 "$SYSTEM_ETC_DEFAULT/${file}"
done
for dir in $dir_list; do
  chmod 0755 "$SYSTEM_ETC_DEFAULT/${dir}"
done
# pkg_TMPPref
file_list="$(find "$TMP_PREFERRED/" -mindepth 1 -type f | cut -d/ ${DEST})"
dir_list="$(find "$TMP_PREFERRED/" -mindepth 1 -type d | cut -d/ ${DEST})"
for file in $file_list; do
  install -D "$TMP_PREFERRED/${file}" "$SYSTEM_ETC_PREF/${file}"
  chmod 0644 "$SYSTEM_ETC_PREF/${file}"
done
for dir in $dir_list; do
  chmod 0755 "$SYSTEM_ETC_PREF/${dir}"
done
# pkg_TMPPerm
file_list="$(find "$TMP_PERMISSION/" -mindepth 1 -type f | cut -d/ ${DEST})"
dir_list="$(find "$TMP_PERMISSION/" -mindepth 1 -type d | cut -d/ ${DEST})"
for file in $file_list; do
  install -D "$TMP_PERMISSION/${file}" "$SYSTEM_ETC_PERM/${file}"
  chmod 0644 "$SYSTEM_ETC_PERM/${file}"
done
for dir in $dir_list; do
  chmod 0755 "$SYSTEM_ETC_PERM/${dir}"
done
# pkg_TMPOverlay
file_list="$(find "$TMP_OVERLAY/" -mindepth 1 -type f | cut -d/ ${DEST})"
dir_list="$(find "$TMP_OVERLAY/" -mindepth 1 -type d | cut -d/ ${DEST})"
for file in $file_list; do
  install -D "$TMP_OVERLAY/${file}" "$SYSTEM_OVERLAY/${file}"
  chmod 0644 "$SYSTEM_OVERLAY/${file}"
done
for dir in $dir_list; do
  chmod 0755 "$SYSTEM_OVERLAY/${dir}"
done

# fsverity_cert
FSVERITY="$SYSTEM/etc/security/fsverity"
test -d "$FSVERITY" || mkdir -p $FSVERITY
unzip -oq "$ZIPFILE" "zip/Certificate.tar" -d "$TMP"

echo "- Set Certificates"
# Integrity Signing Certificate
tar -xf $ZIP_FILE/Certificate.tar -C "$FSVERITY"
chmod 0644 $FSVERITY/gms_fsverity_cert.der
chmod 0644 $FSVERITY/play_store_fsi_cert.der
chcon system "$FSVERITY/gms_fsverity_cert.der"
chcon system "$FSVERITY/play_store_fsi_cert.der"

echo "- Maps config"
# maps_config
ZIP="zip/framework/MapsPermissions.tar"
for f in $ZIP; do unzip -oq "$ZIPFILE" "$f" -d "$TMP"; done
tar -xf $ZIP_FILE/framework/MapsPermissions.tar -C $TMP_PERMISSION
# pkg_TMPPerm
chcon -h u:object_r:system_file:s0 "$SYSTEM_ETC_PERM/com.google.android.maps.xml"
# maps_framework
ZIP="zip/framework/MapsFramework.tar"
for f in $ZIP; do unzip -oq "$ZIPFILE" "$f" -d "$TMP"; done
tar -xf $ZIP_FILE/framework/MapsFramework.tar -C $TMP_FRAMEWORK
# pkg_TMPFramework
chcon -h u:object_r:system_file:s0 "$SYSTEM_FRAMEWORK/com.google.android.maps.jar"

echo "- Set module.prop"
MODULE="$ROOT_DIR/data/adb/modules/MicroG"
test -d "$MODULE" || mkdir -p $MODULE
echo -e "id=MicroG-Android" >> $MODULE/module.prop
echo -e "name=MicroG for Android" >> $MODULE/module.prop
echo -e "version=$version" >> $MODULE/module.prop
echo -e "versionCode=$versionCode" >> $MODULE/module.prop
echo -e "author=TheHitMan7" >> $MODULE/module.prop
echo -e "description=Custom MicroG Apps Project" >> $MODULE/module.prop
echo -e "updateJson=${MODULE_URL}/${MODULE_JSN}" >> $MODULE/module.prop
# Set permission
chmod 0644 $MODULE/module.prop
mkdir -p $ROOT_DIR/data/adb/service.d
unzip -oq "$ZIPFILE" "runtime.sh" -d "$TMP"
# Install runtime permissions
rm -rf $ROOT_DIR/data/adb/service.d/runtime.sh
cp -f $TMP/runtime.sh $ROOT_DIR/data/adb/service.d/runtime.sh
chmod 0755 $ROOT_DIR/data/adb/service.d/runtime.sh
chcon -h u:object_r:adb_data_file:s0 "$ROOT_DIR/data/adb/service.d/runtime.sh"
# Update file GROUP
chown -h root:shell $ROOT_DIR/data/adb/service.d/runtime.sh

