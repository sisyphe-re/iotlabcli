{
  description = "A flake for IoT-LAB cli-tools";
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;

  outputs = { self, nixpkgs }:
    {
      packages.x86_64-linux.iotlabcli =
        with import nixpkgs { system = "x86_64-linux"; };
        python3Packages.buildPythonPackage
          rec {
            pname = "iotlabcli";
            version = "3.2.1";

            src = python3Packages.fetchPypi {
              inherit pname version;
              sha256 = "03b8fg553lzb2y9i6asq8il8kahdxk1rm4ympzxb3r1kigcp98bv";
            };
            doCheck = false;
            #checkInputs = [ pytest mock ];
            propagatedBuildInputs = [ python3Packages.jmespath python3Packages.requests ];

            meta = with lib; {
              homepage = "http://github.com/iot-lab/cli-tools/";
              description = "Manage IoT-LAB experiments from the command-line.";
              license = licenses.cecill20;
              maintainers = with maintainers; [ rgrunbla ];
            };
          };
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.iotlabcli;
    };
}
