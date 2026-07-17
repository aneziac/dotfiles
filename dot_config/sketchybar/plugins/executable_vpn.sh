#!/bin/sh

# Best-effort VPN detection:
#   1. scutil --nc list  -> catches system VPN configs (IKEv2/L2TP/etc.).
#   2. active utun with an IPv4 address -> catches WireGuard/Tailscale/OpenVPN.
# Only shown while connected; hidden otherwise. May miss some clients that use
# non-standard interfaces.
SHIELD=$(printf '\357\204\262')   # nf-fa-shield  U+F132

ACTIVE=0

if scutil --nc list 2>/dev/null | grep -q "Connected"; then
  ACTIVE=1
else
  for IF in $(ifconfig -lu 2>/dev/null | tr ' ' '\n' | grep '^utun'); do
    if ifconfig "$IF" 2>/dev/null | grep -q 'inet '; then
      ACTIVE=1
      break
    fi
  done
fi

if [ "$ACTIVE" = "1" ]; then
  sketchybar --set "$NAME" drawing=on icon="$SHIELD" icon.color=0xffb8bb26 label="VPN"
else
  sketchybar --set "$NAME" drawing=off
fi
