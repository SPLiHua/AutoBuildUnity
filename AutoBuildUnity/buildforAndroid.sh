androidProjectName="GameAtom"
echo "Build AndroidProject Start"

oldSrcPath=/home/muyao/ASBuild/Detective/unityLibrary/src/main
buildToolPath=/home/muyao/ASBuild/Detective

fileName=`date '+%Y_%m_%d|%H.%M.%S'`
if [ ! -d "${ASProjectPath}/AND" ]; then
mkdir -p ${ASProjectPath}/AND
fi
ipaname=${fileName}${RANDOM}
#if [ -d "$outpath" ]; then
#rm -rf ${outpath}/*
#else
#mkdir -p $outpath
#fi
outpath=${ASProjectPath}/AND

cd ${UnityProjectPath}/..
# svn revert -R .
# svn status | grep '^a?' | sed -e 's/^.//' | xargs rm
# svn status | grep '^aM' | sed -e 's/^.//' | xargs rm
# svn up

git checkout .
git pull
git pull --recurse-submodules

if [ -d "${UnityProjectPath}/Assets/StreamingAssets/AssetBundles" ]; then
rm -rf ${UnityProjectPath}/Assets/StreamingAssets/AssetBundles/*
fi

# $unity -quit -batchmode -UnityProjectPath $UnityProjectPath -logFile ${logFile}/${ipaname}.log -executeMethod ProjectBuild.ClearLuaFiles

# $unity -quit -batchmode -UnityProjectPath $UnityProjectPath -logFile ${logFile}/${ipaname}.log -executeMethod ProjectBuild.GenLuaAll

$unity -quit -batchmode -UnityProjectPath $UnityProjectPath -logFile ${logFile}/${ipaname}.log -executeMethod Skylark.Editor.ProjectBuild.BuildProjected outpath="$outpath" scene="$scene" type="AND"
echo "Build AndroidProject Success"

cd ${oldSrcPath}
rm -rf assets
rm -rf Il2CppOutputProject
rm -rf java
rm -rf jniLibs
rm -rf jniStaticLibs
rm -rf res

cd ${outpath}/unityLibrary/src/main
# mkdir -p ${oldSrcPath}/assets
# mkdir -p ${oldSrcPath}/Il2CppOutputProject
# mkdir -p ${oldSrcPath}/java
# mkdir -p ${oldSrcPath}/jniLibs
# mkdir -p ${oldSrcPath}/jniStaticLibs
# mkdir -p ${oldSrcPath}/res

cp -r assets ${oldSrcPath}
cp -r Il2CppOutputProject ${oldSrcPath}
cp -r java ${oldSrcPath}
cp -r jniLibs ${oldSrcPath}
cp -r jniStaticLibs ${oldSrcPath}
cp -r res ${oldSrcPath}
echo "Move New UnityLibrary Success"

cd $buildToolPath && ./gradlew assemble
echo "Build apk Success"
open ${buildToolPath}/launcher/build/outputs/apk

# if [ -d $allresFiles ]; then
# rm -rf ${allresFiles}/*
# fi
# if [ -d "${projectPath}/Assets/StreamingAssets" ]; then
# cp -f ${projectPath}/Assets/StreamingAssets/*.bytes ${projectPath}/Assets/StreamingAssets/*.txt $allresFiles
# zip -r ${workspace}/AND/res.zip $allresFiles/*
# fi
#cd $outpath
#echo "开始生成 apk包 time: `date '+%Y%m%d%H%M%S'`"
#ls | while read line
#do
#$android update project -p $line/ -t 2
#done

#cd ${outpath}/${androidProjectName}
#cp ${buildROOT}/fsmj.keystore ${outpath}/${androidProjectName}/fsmj.keystore
#cp ${buildROOT}/ant.properties ${outpath}/${androidProjectName}/ant.properties
#$ant clean
#$ant release