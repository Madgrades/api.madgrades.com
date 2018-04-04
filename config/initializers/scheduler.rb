scheduler = Rufus::Scheduler::singleton

unless defined?(Rails::Console) || File.split($0).last == 'rake'
  scheduler.every '7d' do
    # ...
  end
end