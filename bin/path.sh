cat $0
# Usage: source path.sh
# The source command runs this command in the current shell so its effects are persistent - at least in mac os.
PATH=$PATH:$(echo $(pwd))
echo $PATH

