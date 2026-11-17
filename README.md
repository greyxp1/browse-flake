# browse-flake

[Browse](https://github.com/anomalyco/browse) for x86_64 and aarch64 Linux, with a NixOS module.

## Quick start

```sh
nix run github:greyxp1/browse-flake -- --help
```

## NixOS

Add `browse.url = "github:greyxp1/browse-flake";` to your flake inputs and enable the module.

```nix
{inputs, ...}: {
  imports = [inputs.browse.nixosModules.default];
  programs.browse.enable = true;
}
```

Install the [Browse extension](https://chromewebstore.google.com/detail/browse/mfnicocicmmlkpjnaffgihfjhdgjkdjg) in your browser and register `browse mcp` with your MCP client. Run `browse pair` to pair the extension. Set `programs.browse.settings.window` or `programs.browse.settings.humanInput` to override the corresponding extension settings.
