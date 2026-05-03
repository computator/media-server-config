job "cloudflared" {
  group "main" {
    task "cloudflared" {
      driver = "podman"

      config {
        image        = "docker.io/cloudflare/cloudflared"
        command      = "tunnel"
        args         = ["run"]
        network_mode = "host"
      }

      template {
        data        = "TUNNEL_TOKEN={{ with nomadVar \"nomad/jobs/cloudflared\" }}{{ .tunnelToken }}{{ end }}"
        destination = "secrets/token.env"
        env         = true
      }
    }
  }
}
