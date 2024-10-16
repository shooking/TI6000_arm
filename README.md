```
make
```

Should create you a load docker image and a command to lauch TI 6000 commands from your Raspberry Pi.
Install the ticmd.sh in your path and set apprproriate **TI_FOLDER**.

### Example

```
cd <<where your TI 6000elf files are>>
export TI_FOLDER=`pwd`
ticmd dis6x -a -b Air.elf
```




