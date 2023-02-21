#!/usr/bin/zsh
profile_file=~/.zprofile
starship_home=~/.starship

curl -sS https://starship.rs/install.sh | sh

mkdir -p $starship_home
cp ./starship.toml ~/.starship
echo ">>>> Setting up starship in '$profile_file'"
echo "### starship config ###" >> $profile_file
echo "export STARSHIP_CONFIG=~/.starship/starship.toml" >> $profile_file
echo 'eval "$(starship init zsh)"' >> $profile_file