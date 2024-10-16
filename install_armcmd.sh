cat << EOF > armcmd.sh
#!/bin/bash
if [ -z "\$VERSION" ]
then
    VERSION="latest"
fi
if [ -z "\$TI_FOLDER" ]
then
      echo 'TI_FOLDER is empty. It should have the absolute path to the source code working folder.'
      exit 1
fi
ARCH=\$(arch)
THEDOCKER="shookingsybase/ti6000-docker-\${ARCH}:\${VERSION}"
THEUSER=\$(id -u)
THEGROUP=\$(id -g)
docker run -it --rm  -v \${TI_FOLDER}:'/tmp' --user "\${THEUSER}:\${THEGROUP}" \${THEDOCKER} \$@
EOF
