final: prev: {
  hydrus = prev.hydrus.overrideAttrs (oldAttrs: {
    doCheck = false;
    doInstallCheck = false;
    propagatedBuildInputs = builtins.filter (
      dep: dep != final.python3Packages.psd-tools
    ) oldAttrs.propagatedBuildInputs;
  });
}
