#!/bin/bash

cat > index.html <<EOF
<h1>Hello, ASCDSO!!!</h1>
<p>DBaddress:${db_address}</p>
<p>DBport:${db_port}</p>
EOF

nohup busybox httpd -f -p ${server_port} &
