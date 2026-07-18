{ pkgs, ... }:

pkgs.writeShellScriptBin "ups-status" ''
  RAW=$(upsc main 2>/dev/null)

  if [ -z "$RAW" ]; then
    echo "UPS unreachable"
    exit 1
  fi

  get_val() {
    echo "$RAW" | grep "^$1:" | awk '{print $2}'
  }

  STATUS=$(get_val "ups.status")
  CHARGE=$(get_val "battery.charge")
  RUNTIME=$(get_val "battery.runtime")
  LOAD=$(get_val "ups.load")
  WATT=$(get_val "ups.realpower")

  MINUTES=$((RUNTIME / 60))

  echo "Status:  $STATUS"
  echo "Charge:  $CHARGE%"
  echo "Runtime: $MINUTES min"
  echo "Load:    $LOAD% ($WATT W)"
''
