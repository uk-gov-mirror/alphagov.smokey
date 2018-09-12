class Proxy
  def initialize
    # Set up proxy server (used to manipulate HTTP headers etc since Selenium doesn't
    # support this) on a random port between 3222 and 3229
    proxy_port = (3222..3229).to_a.sample
    @@server ||= BrowserMob::Proxy::Server.new("./bin/browsermob-proxy", port: proxy_port).start
    @@proxy  ||= @@server.create_proxy

    # Set up request logging and make it available across all tests
    @@har ||= @@proxy.new_har("smokey")
  end

  def self.service
    new
    @@proxy
  end
end
