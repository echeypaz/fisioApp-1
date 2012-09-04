# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "show_for"
  s.version = "0.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jos\u{e9} Valim"]
  s.date = "2012-05-12"
  s.description = "Wrap your objects with a helper to easily show them"
  s.email = "contact@plataformatec.com.br"
  s.homepage = "http://github.com/plataformatec/show_for"
  s.require_paths = ["lib"]
  s.rubyforge_project = "show_for"
  s.rubygems_version = "1.8.24"
  s.summary = "Wrap your objects with a helper to easily show them"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, ["~> 3.0"])
      s.add_runtime_dependency(%q<actionpack>, ["~> 3.0"])
    else
      s.add_dependency(%q<activemodel>, ["~> 3.0"])
      s.add_dependency(%q<actionpack>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<activemodel>, ["~> 3.0"])
    s.add_dependency(%q<actionpack>, ["~> 3.0"])
  end
end
