export unity=/Applications/Unity/Hub/Editor/2020.3.13f1c1/Unity.app/Contents/MacOS/Unity
export logFile=/Users/wangmuyao/Desktop/ASProjects/Detective
export ASProjectPath=/Users/wangmuyao/Desktop/ASProjects/Detective
export UnityProjectPath=/Users/wangmuyao/Desktop/GitProjects/FirstPlan/Client/FirstProject

buildforAndorid=/Users/wangmuyao/Desktop/AutoBuildUnity/buildforAndroid.sh
buildforIos=/Users/wangmuyao/Desktop/AutoBuildUnity/buildforios.sh

version="0.0.1"
KeystoreName="KeystoreName"
platform="AND"
ASProjectPath=${ASProjectPath}/${BUILD_NUMBER}_${version}
scene="Scene=Assets/Scenes/Main.unity"

if [ ! -d "$ASProjectPath" ];then
mkdir -p $ASProjectPath
fi

echo "$BUILD_NUMBER"
echo "Start Build";
for a in $*
do
r=`echo $a | sed "s/--//g"`
eval $r
done

if [ "$platform" = "AND" ]; then
bash $buildforAndorid $version $KeystoreName $scene
elif [ "$platform" = "IOS" ];then
bash $buildforIos $version $ispublic $Collection $InstallVersion $scene
else
echo "准备生成所有的包"
bash $buildforAndorid $version $ispublic $Collection $InstallVersion
bash $buildforIos $version $ispublic $Collection $InstallVersion
fi
