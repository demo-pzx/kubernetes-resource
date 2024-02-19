#!/bin/bash
# 获取到当前路径
current_path=$(pwd)


# 加载check_k8s_cluster.sh
source "$current_path"/lib/colors.sh
source "$current_path"/lib/check_k8s_cluster.sh

echo "${GREEN} current path: $current_path${NC}"


check_k8s_cluster