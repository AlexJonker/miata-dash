#!/bin/bash
set -e

echo "Building aasdk and openauto..."
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AASDK_DIR="$ROOT_DIR/modules/aasdk"
OPENAUTO_DIR="$ROOT_DIR/modules/openauto"

cmake -S "$AASDK_DIR" -B "$AASDK_DIR/build-host"
cmake --build "$AASDK_DIR/build-host" -j"$(nproc)"

# As seen in `ldd modules/openauto/bin/autoapp | grep aasdk` these flags should be changed when used in building for the rpi image.
# Should probably end up in something like /opt/dash
cmake -S "$OPENAUTO_DIR" -B "$OPENAUTO_DIR/build-host" \
  -DAASDK_INCLUDE_DIRS="$AASDK_DIR/include" \
  -DAASDK_PROTO_INCLUDE_DIRS="$AASDK_DIR/build-host" \
  -DAASDK_LIBRARIES="$AASDK_DIR/lib/libaasdk.so" \
  -DAASDK_PROTO_LIBRARIES="$AASDK_DIR/lib/libaasdk_proto.so"
cmake --build "$OPENAUTO_DIR/build-host" -j"$(nproc)"

echo "Build complete."
echo "Executing openauto..."
"$OPENAUTO_DIR/bin/autoapp"