#!/bin/sh
# Tab bar status for herdr: current kube context with a color marker per environment
ctx=$(kubectl config current-context 2>/dev/null) || exit 1

case $ctx in
  *prod*|*devops*) echo "🔴 $ctx" ;;
  *accpt*)         echo "🟠 $ctx" ;;
  *)               echo "🟢 $ctx" ;;
esac
