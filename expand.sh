
#!/bin/bash

function show_help {
	echo "Syntax:\n\texpand.sh -e \"ext\" -t \"your text\"\n"
	echo "\t-e is file extension (optional but recommended)"
	echo "\t-t is text to be expanded\n"
	echo "\tReturns JSON with 2 properties: text and cursorPosition.\n"
	echo "Example:\n\tsh expand.sh -e swift -t \"-f foo\""
}

while getopts ":e:t:" opt; do
  case $opt in
    e)
	    FILE_EXTENSION="$OPTARG"
    ;;
    t)
        TEXT=`echo $OPTARG | sed -e 's/\\\\/\\\\\\\\/g' | sed -e 's/\"/\\\"/g'`
    ;;
	\?)
		echo "Invalid option -$OPTARG\n" >&2
		show_help
		exit
    ;;
  esac
done

if [ -z "$TEXT" ]; then
	echo "no text" >&2
    show_help
	exit
fi

osascript -l JavaScript -e "Application(\"TeaCode\").expandAsJson(\"$TEXT\", { \"extension\": \"$FILE_EXTENSION\" })"