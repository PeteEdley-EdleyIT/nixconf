{ hostname, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./common
    ./${hostname}/configuration.nix
  ];
}
