data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"


advertise {
  http = "IP_ADDRESS"
  rpc  = "IP_ADDRESS"
  serf = "IP_ADDRESS"
}

acl {
  enabled = true
}

name = "IP_ADDRESS"

server {
  enabled          = true
  bootstrap_expect = SERVER_COUNT

  server_join {
    retry_join     = ["RETRY_JOIN"]
    retry_max      = 3
    retry_interval = "15s"
  }
}