

modelDirName="SalsaNext"
modelsBaseDir="/home/garrett/Documents"
modelDir="$modelsBaseDir/$modelDirName"
dataDir="/home/garrett/Documents/data/tmp/dataset/sequences/00/velodyne"
predDir="/home/garrett/Documents/data/out"


modelRunCommand="python3 infer.py"
modelRunCommand+=" -d /home/garrett/Documents/data/tmp/dataset"
modelRunCommand+=" -l /home/garrett/Documents/data/out"
modelRunCommand+=" -m $modelDir/pretrained"
modelRunCommand+=" -s test -c 1"


# Run
# container name
# Access to GPUs
# User (otherwise we won't have permission to modify files created by bind mount)
# Mount model dir
# Mount data (bins) dir
# Mount predictions (bins) dir
# image
# bash (command) 

echo 
echo $modelRunCommand
echo 
echo Running Docker
echo 

docker run \
--name salsanext \
--gpus all \
--user "$(id -u)" \
--mount type=bind,source="$modelDir",target="$modelDir" \
--mount type=bind,source="$dataDir",target="$dataDir" \
--mount type=bind,source="$predDir",target="$predDir" \
salsanext_image \
bash -c "cd $modelDir/train/tasks/semantic && $modelRunCommand"



# Clean up container
docker container stop salsanext && docker container rm salsanext




