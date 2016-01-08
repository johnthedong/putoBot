lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'telegram/bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'putoBot'
  spec.version       = Telegram::Bot::VERSION
  spec.authors       = ['John K.']
  spec.email         = ['me@johnkoh.net']

  spec.summary       = "Telegram Bot using https://github.com/atipugin/telegram-bot"
  spec.homepage      = 'johnkoh.net'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httmultiparty'
  spec.add_dependency 'persistent_httparty'
  spec.add_dependency 'virtus'

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'
end
