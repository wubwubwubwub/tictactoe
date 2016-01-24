RSpec.configure do |config|
  config.color = true
  # config.tty = true
  config.formatter =  :documentation
  config.before { allow($stdout).to receive(:puts) } # silence rspec puts on all
end
