#!/bin/bash

exec 3<> index.html

html_begin() {
    cat >&3 << EOF
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <style>
        body {
            background-color: black;
            color: lime;
            font-family: 'Courier New', Courier, monospace;
        }
        pre {
            white-space: pre-wrap;       /* css-3 */
            white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
            white-space: -pre-wrap;      /* Opera 4-6 */
            white-space: -o-pre-wrap;    /* Opera 7 */
            word-wrap: break-word;       /* Internet Explorer 5.5+ */
        }
    </style>
    <title>Report</title>
</head>
<body>
EOF
}

html_end() {
    cat >&3 << EOF
</body>
</html>
EOF
}

command_exists() {
    command -v "$1" &> /dev/null
}

html_begin

echo "<h1>Informations du système $(hostname -s)</h1>" >&3
{ echo "<h2>Système</h2>"; command_exists cat && cat /proc/cpuinfo | grep 'Model' | uniq; echo "</hr>"; } | while read line; do echo "<pre>$line</pre><hr>" >&3; done
{ echo "<h2>CPU</h2>"; command_exists cat && cat /proc/cpuinfo | grep 'model name' | uniq; echo "</hr>"; } | while read line; do echo "<pre>$line</pre><hr>" >&3; done
{ echo "<h2>Info mémoire</h2>"; command_exists free && free -m; echo "</hr>"; } | while read line; do echo "<pre>$line</pre><hr>" >&3; done
{ echo "<h2>Disk Info:</h2>"; command_exists df && df -h; echo "</hr>"; } | while read line; do echo "<pre>$line</pre><hr>" >&3; done
{ echo "<h2>Logged in user</h2>"; command_exists w && w; echo "</hr>"; } | while read line; do echo "<pre>$line</pre><hr>" >&3; done

echo "<center>Information generated on $(date)</center>" >&3

html_end

exec 3>&-

