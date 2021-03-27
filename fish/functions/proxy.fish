function proxy -d "Setup proxy environment variables"
  set -gx http_proxy http://127.0.0.1:1087
  set -gx HTTP_PROXY http://127.0.0.1:1087
  set -gx https_proxy http://127.0.0.1:1087
  set -gx HTTPS_PROXY http://127.0.0.1:1087
end
