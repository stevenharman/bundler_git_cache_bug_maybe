# -*- encoding: utf-8 -*-
# stub: puma-plugin-telemetry 1.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "puma-plugin-telemetry".freeze
  s.version = "1.1.4".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/babbel/puma-plugin-telemetry/blob/main/CHANGELOG.md", "github_repo" => "ssh://github.com/babbel/puma-plugin-telemetry", "homepage_uri" => "https://github.com/babbel/puma-plugin-telemetry", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/babbel/puma-plugin-telemetry" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Leszek Zalewski".freeze]
  s.bindir = "exe".freeze
  s.date = "2024-11-19"
  s.description = "Puma plugin which should be able to handle all your metric needs regarding your webserver:\n\n- ability to publish basic puma statistics (like queue backlog) to both logs and datadog\n- ability to add custom target whenever you need it\n- ability to monitor puma socket listen queue (!)\n- ability to report requests queue time via custom rack middleware - the time request spent between being accepted by Load Balancer and start of its processing by Puma worker\n".freeze
  s.email = ["tnt@babbel.com".freeze]
  s.files = [".rspec".freeze, ".rubocop.yml".freeze, ".tool-versions".freeze, "CHANGELOG.md".freeze, "CODE_OF_CONDUCT.md".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "docs/example-datadog_backlog_size.png".freeze, "docs/example-datadog_queue_time.png".freeze, "docs/examples.md".freeze, "lib/puma/plugin/telemetry.rb".freeze, "lib/puma/plugin/telemetry/config.rb".freeze, "lib/puma/plugin/telemetry/data.rb".freeze, "lib/puma/plugin/telemetry/formatters/json_formatter.rb".freeze, "lib/puma/plugin/telemetry/formatters/logfmt_formatter.rb".freeze, "lib/puma/plugin/telemetry/formatters/noop_formatter.rb".freeze, "lib/puma/plugin/telemetry/targets/base_formatting_target.rb".freeze, "lib/puma/plugin/telemetry/targets/datadog_statsd_target.rb".freeze, "lib/puma/plugin/telemetry/targets/io_target.rb".freeze, "lib/puma/plugin/telemetry/targets/log_target.rb".freeze, "lib/puma/plugin/telemetry/transforms/cloud_watch_transform.rb".freeze, "lib/puma/plugin/telemetry/transforms/l2met_transform.rb".freeze, "lib/puma/plugin/telemetry/transforms/noop_transform.rb".freeze, "lib/puma/plugin/telemetry/version.rb".freeze, "lib/rack/request_queue_time_middleware.rb".freeze]
  s.homepage = "https://github.com/babbel/puma-plugin-telemetry".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6.0".freeze)
  s.rubygems_version = "3.5.9".freeze
  s.summary = "Puma plugin, adding ability to publish various metrics to your prefered targets.".freeze

  s.installed_by_version = "3.5.9".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<puma>.freeze, ["< 7".freeze])
end
