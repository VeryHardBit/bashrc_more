#This way is install from Robotcitizen

#Another note :
    #Credit https://www.reddit.com/r/ROS/comments/oxy4xt/is_ros1_noetic_compatible_with_turtlebot2/h7ufem6/
    #Credit https://gist.github.com/DanManN/48ab84c977a3815cacc542835a60dbd7
    #Just in case 404 error happens and show appreaciation toward him

set -o pipefail


echo "Robot specification : Turtlebot2 yujin Kobuki"
echo "[WARNING] : This installation is quite long"
echo "If you're ready just press [ENTER] or [CTRL-C] if you aren't yet"
read

echo "[Updating packages]"
sudo apt-get update

echo "[Install necessary packages for turtlebot2]"
sudo apt-get install -y ros-noetic-joy ros-noetic-map-server ros-noetic-move-base ros-noetic-amcl ros-noetic-gmapping ros-noetic-ecl-* python-is-python3 ros-noetic-dwa-local-planner
echo "[Install SLAM package]"
sudo apt-get -y install ros-noetic-hector-slam
echo "[Install xacro packages]"#useful for dynamic transform
sudo apt-get -y install ros-noetic-xacro ros-noetic-joint-state-publisher-gui
echo "[Install something]"
sudo apt-get -y install ros-noetic-ros-tutorials ros-noetic-geometry-tutorials ros-noetic-rviz ros-noetic-rosbash ros-noetic-rqt-tf-tree
sudo apt-get -y install ros-noetic-joy libftdi-dev ros-noetic-openslam-gmapping ros-noetic-base-local-planner ros-noetic-clear-costmap-recovery ros-noetic-move-base-msgs ros-noetic-navfn ros-noetic-rotate-recovery xsltproc ros-noetic-map-server ros-noetic-amcl ros-noetic-dwa-local-planner ros-noetic-rosbridge-* ros-noetic-ecl-console ros-noetic-ecl-command-line ros-noetic-ecl-converters ros-noetic-ecl-devices ros-noetic-ecl-geometry ros-noetic-ecl-mobile-robot ros-noetic-ecl-sigslots ros-noetic-ecl-time python3-empy ros-noetic-ddynamic-reconfigure ros-noetic-teb-local-planner




echo "[Creating turtlebot2 workspace]"
ws_name="turtlebot2_ws"
ros_create_ws $ws_name
cd $ws_name
ws_name=$(pwd)

echo "[Download turtlebot2 package(tar.xz) files from RobotCitizen gitlab]"
cd $ws_name/src
git clone https://gitlab.com/robotcitizens_training/kobuki_turtlebot2_package.git
cd kobuki_turtlebot2_package
tar -xf kobuki_turtlebot2_package.tar.xz

echo "[Download turtlebot2 rplidar package]"
cd $ws_name/src
git clone https://github.com/robopeak/rplidar_ros/


echo "[Building workspace]"
cd $ws_name
catkin_make

echo "[Create rplidar udev rules]"
source $ws_name/devel/setup.bash
source `rospack find rplidar_ros`/scripts/create_udev_rules.sh


echo "[Installation completed]"
cd $ws_name/..