# Command-line HOWTO

    export FLEETCTL_TUNNEL=[ip]:22
    export FLEETCTL_ENDPOINT=http://127.0.0.1:4001

    fleetctl load nccts-*.service

    # -- init -- #
    fleetctl start nccts-data.service
    fleetctl start nccts-http-server.service
    fleetctl start nccts-static.service
    fleetctl start nccts-latex.service
    fleetctl start nccts-generator.service

    # -- kick -- #
    fleetctl stop nccts-[some].service
    fleetctl start nccts-[some].service

    # -- wipe -- #
    fleetctl stop nccts-*.service
    fleetctl destroy nccts-*.service
