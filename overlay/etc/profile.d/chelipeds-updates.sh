if [ -f /var/lib/chelipeds/updates-available ]; then
  export CHELIPEDS_UPDATES_AVAILABLE=1
else
  export CHELIPEDS_UPDATES_AVAILABLE=0
fi
