function proxy -d "Setup proxy environment variables"
  set -gx http_proxy http://127.0.0.1:1080
  set -gx HTTP_PROXY http://127.0.0.1:1080
  set -gx https_proxy http://127.0.0.1:1080
  set -gx HTTPS_PROXY http://127.0.0.1:1080
  git config --global http.proxy 'socks5://127.0.0.1:1080'
  git config --global http.sslVerify false
  git config --global https.proxy 'socks5://127.0.0.1:1080'
end
