# 通过kubectl version判断 k8s集群是否正常，并将信息返回

function check_k8s_cluster() {
  if command kubectl version; then

    echo "${YELLOW}Step(1/5) Get k8s nodes test${NC}"
    if command kubectl get pods; then
    echo "${GREEN}k8s cluster is running${NC}"
    fi

  else
    echo "${RED}k8s cluster is not running${NC}"
  fi
}