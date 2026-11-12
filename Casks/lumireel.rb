cask "lumireel" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.0"
  sha256 arm:   "0b6d2811e1e89bbd71412114d907b70798de5c75414d17ac02d39ffcc44effea",
         intel: "478358f4e4b20c7dce82e1f002d4ff7a9b433b7b7bf8d7223d51047e4a2bfbd3"

  url "https://github.com/osdodo/lumireel/releases/download/v#{version}/lumireel-#{version}-macos-#{arch}.dmg"
  name "LumiReel"
  desc "Make videos with a coding agent; every frame is code"
  homepage "https://github.com/osdodo/lumireel"

  depends_on macos: :monterey

  app "LumiReel.app"

  # Ad-hoc signed, not notarized: without this Gatekeeper reports the app as damaged.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/LumiReel.app"],
        writable_paths: ["LumiReel.app"],
        writable_base:  :appdir
  end
end
