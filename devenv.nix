{ pkgs, lib, config, inputs, ... }:

{
  packages = [ pkgs.git ];

  languages.ruby = {
    enable = true;
    bundler.enable = true;
  };

  processes.jekyll.exec = "bundle exec jekyll serve --livereload";

  enterShell = ''
    bundle install
    echo "Run 'devenv up' to start Jekyll, or 'bundle exec jekyll serve' manually."
  '';

  # See full reference at https://devenv.sh/reference/options/
}
