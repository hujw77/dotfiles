function noproxy -d "Clear all proxy environment variables"
  set -eg http_proxy 
  set -eg HTTP_PROXY 
  set -eg https_proxy 
  set -eg HTTPS_PROXY 
end
