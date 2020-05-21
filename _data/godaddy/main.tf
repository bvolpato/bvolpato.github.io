variable "domain" {}
variable "ip_hosting" {
  type    = string
  default = "107.180.51.231"
}
variable "google_verification_id" {
  type    = string
}

resource "cloudflare_zone" "dns" {
  zone = "${var.domain}"
}

resource "cloudflare_zone_settings_override" "zone-settings" {
    zone_id = "${cloudflare_zone.dns.id}"
    settings {
        ssl = "flexible"
    }
}

resource "cloudflare_record" "a-dns" {
  zone_id = "${cloudflare_zone.dns.id}"
  name    = "${var.domain}"
  value   = "${var.ip_hosting}"
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = "${cloudflare_zone.dns.id}"
  name    = "www"
  value   = "${var.domain}"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "verif-txt" {
  zone_id = "${cloudflare_zone.dns.id}"
  name    = "${var.domain}"
  value   = "3a3239446369588f68411a093271f19cd5f61ed6"
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_record" "verif-google-txt" {
  zone_id = "${cloudflare_zone.dns.id}"
  name    = "${var.domain}"
  value   = "google-site-verification=${var.google_verification_id}"
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_page_rule" "https" {
  zone_id  = "${cloudflare_zone.dns.id}"
  target   = "http://*${var.domain}/*"

  actions {
    always_online = "on"
    always_use_https = true
  }

  lifecycle {
    ignore_changes = [
      priority
    ]
  }
}

resource "cloudflare_page_rule" "canonical" {
  zone_id  = "${cloudflare_zone.dns.id}"
  target   = "https://${var.domain}/*"

  actions {
    forwarding_url {
      url         = "https://www.${var.domain}/$1"
      status_code = 301
    }
  }

  lifecycle {
    ignore_changes = [
      priority
    ]
  }
}
