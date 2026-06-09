function ngrok-tunnel-url
  ngrok api tunnels list 2>/dev/null | jq -r '.tunnels[0].public_url'
end
