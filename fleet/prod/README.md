# Command-line HOWTO

    export FLEETCTL_TUNNEL=[ip]:22
    export FLEETCTL_ENDPOINT=http://127.0.0.1:4001

    fleetctl load nccts-*.service

    # -- init -- #
    fleetctl start nccts-data.service
    # -- kick -- #
    fleetctl stop nccts-data.service
    fleetctl start nccts-data.service
