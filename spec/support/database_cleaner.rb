RSpec.configure do |config|

  #Empty the database before each test file

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:suite) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean 
  end
  
end