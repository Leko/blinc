# -*- encoding: utf-8 -*-
# stub: omniauth-moves 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-moves"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nick Elser"]
  s.date = "2014-08-15"
  s.description = "OmniAuth strategy for Moves."
  s.email = ["nick.elser@gmail.com"]
  s.homepage = "https://github.com/nickelser/omniauth-moves"
  s.rubygems_version = "2.4.5"
  s.summary = "OmniAuth strategy for Moves."

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>, ["~> 1.0"])
      s.add_runtime_dependency(%q<omniauth-oauth2>, ["~> 1.0"])
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.7"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<omniauth>, ["~> 1.0"])
      s.add_dependency(%q<omniauth-oauth2>, ["~> 1.0"])
      s.add_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, ["~> 2.7"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<omniauth>, ["~> 1.0"])
    s.add_dependency(%q<omniauth-oauth2>, ["~> 1.0"])
    s.add_dependency(%q<multi_json>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, ["~> 2.7"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end
