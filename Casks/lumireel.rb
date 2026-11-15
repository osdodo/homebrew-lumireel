cask "lumireel" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.2"
  sha256 arm:   "da0f3cd762b986c8c545179124117ed05ce9384f83a5e0ae9aff920d8dd9f9eb",
         intel: "608ebbe55e963bd6e954cc988fde58792eb8323601704e709ecc42e0005cab13"

  url "https://github.com/osdodo/lumireel/releases/download/v#{version}/lumireel-#{version}-macos-#{arch}.dmg"
  name "lumireel"
  desc "Make videos with a coding agent; every frame is code"
  homepage "https://github.com/osdodo/lumireel"

  depends_on macos: :monterey

  app "lumireel.app"

  # Ad-hoc signed, not notarized: without this Gatekeeper reports the app as damaged.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/lumireel.app"],
        writable_paths: ["lumireel.app"],
        writable_base:  :appdir
  end
end
