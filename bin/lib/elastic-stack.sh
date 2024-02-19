current_path=$(cd ../../ && pwd)
source "$current_path"/bin/lib/colors.sh

# 加载namespace
function namespace() {
  if ! command kubectl apply -f "$current_path"/config/namespaces/elastic-stack-ns.yaml; then
    echo "${RED}Create or update elastic-stack namespace failed${NC}"
    exit 1
  else
    echo "${GREEN}Create or update elastic-stack namespace success${NC}"
  fi
}

function elasticsearch_deployment() {
  # 加载elasticsearch
  if ! command kubectl apply -f "$current_path"/config/deployments/elasticsearch-deployment.yaml; then
    echo "${RED}Create or update elasticsearch-deployment resources failed${NC}"
    exit 1
  else
    echo "${GREEN}Create or update elasticsearch-deployment resources success${NC}"
  fi
}

# 加载kibana
function kibana_deployment() {
  if ! command kubectl apply -f "$current_path"/config/deployments/kibana-deployment.yaml; then
    echo "${RED}Create or update kibana-deployment resources failed${NC}"
  else
    echo "${GREEN}Create or update kibana-deployment resources success${NC}"
  fi
}


# 加载elasticsearch-service
function elasticsearch_service() {
  if ! command kubectl apply -f "$current_path"/config/services/elasticsearch-service.yaml; then
    echo "${RED}Create or update elasticsearch-service resources failed${NC}"
    exit 1
  else
    echo "${GREEN}Create or update elasticsearch-service resources success${NC}"
  fi
}

# 加载kibana-service
function kibana_service() {
  if ! command kubectl apply -f "$current_path"/config/services/kibana-service.yaml; then
    echo "${RED}Create or update kibana-service resources failed${NC}"
  else
    echo "${GREEN}Create or update kibana-service resources success${NC}"
  fi
}

function main() {
  # 检查参数
  if [[ $# -eq 0 ]]; then
      echo "${YELLOW}Usage: $0 [remove-all|load-all|elastic-service|kibana-service|elastic-deployment|kibana-deployment|namespace]${NC}"
      exit 1
  fi

  # 加载全部或特定模块
  case $1 in
      "remove-all")
          kubectl delete all --all --namespace=elastic-stack
          ;;
      "load-all")
          namespace
          elasticsearch_deployment
          kibana_deployment
          elasticsearch_service
          kibana_service
          sleep 5
          kubectl get all --namespace=elastic-stack
          ;;
      "elastic-service")
          elasticsearch_service
          ;;
      "kibana-service")
          kibana_service
          ;;
      "elastic-deployment")
          elasticsearch_deployment
          ;;
      "kibana-deployment")
          kibana_deployment
          ;;
      "namespace")
          namespace
          ;;
      *)
          echo "${RED}Invalid argument: $1${NC}"
          echo "${YELLOW}Usage: $0 [all|elastic-service|kibana-service|elastic-deployment|kibana-deployment|namespace]${NC}"
          exit 1
          ;;
  esac
}

main "$@"