#!/usr/bin/env bash
lambda_output_file=$(pwd)/lambda.zip
virtualenv env
. env/bin/activate
pip install --no-cache-dir -r requirements.txt
mkdir bin
cp /tmp/usr/bin/clamscan /tmp/usr/bin/freshclam /tmp/usr/lib64/* bin/.
echo "DatabaseMirror database.clamav.net" > bin/freshclam.conf
zip -r9 $lambda_output_file *.py bin
cd env/lib/python2.7/site-packages
zip -r9 $lambda_output_file *