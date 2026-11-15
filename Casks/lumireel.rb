cask "lumireel" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.1"
  sha256 arm:   "b67aab47b0aed7de64dfce61fe44dca74af79249de1983ee43f7745260b38595",
         intel: "e617d20430f60789c69b8573aca1630f4039b9d35d2b993362bfd5b7827b0fe5"

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
