require 'test_helper'

describe Mask do
  before(:all) do
    @db_conf = Config.parse('test/config/database.yml')
    @tasks = Config.parse('test/config/task.yml')

    Sequel.connect("%{adapter}://%{host}:%{port}" % @db_conf[:from]) do |db|
      begin
        db.run("CREATE DATABASE %{database}" % @db_conf[:from])
      rescue
      end
    end
    system("psql test_from < test/test_from.sql")

    Mask::run('test/config')
  end

  after(:all) do
    Sequel.connect("%{adapter}://%{host}:%{port}" % @db_conf[:from]) do |db|
      begin
        db.run("DROP DATABASE %{database}" % @db_conf[:from])
        db.run("DROP DATABASE %{database}" % @db_conf[:to])
      rescue
      end
    end
  end

  it 'should work' do
    Sequel.connect("%{adapter}://%{host}:%{port}/%{database}" % @db_conf[:to]) do |db|
      db[:users].each do |user|
        user[:mobile].must_equal '18600000000'
        user[:email].must_equal "#{user[:id]}@gmail.com"
      end

      db[:orders].each do |user|
        user[:amount].must_equal 1024
        user[:credit_id].must_equal "#{user[:id]}2015"
      end
    end
  end
end