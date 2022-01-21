current_version=$Version
srcpart "https://raw.githubusercontent.com/nrjdalal/Vero-LSM/master/utils/utils.sh" 1 1
latest_version=$Version

echo
if [[ "$current_version" == "$latest_version" ]]; then
  echo "You're using the latest verion $current_version"
else
  echo "Newer version available $current_version -> $(tput setaf 2)$latest_version$(tput sgr0)"
  echo "Run $(tput setaf 3)sudo Vero-LSM update$(tput sgr0) to upgrade"
fi
echo
