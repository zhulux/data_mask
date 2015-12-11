require 'sequel'

require 'mask/config'
require 'mask/migrate'

module Mask
  def self.setup(path = 'config')
    @db_conf = Config.parse(path + '/database.yml')
    @tasks = Config.parse(path + '/task.yml')
  end

  def self.operate_db(op)
    Sequel.connect(build_url_without_db(@db_conf[:to])) do |db|
      begin
        db.run("#{op.upcase} DATABASE %{database}" % @db_conf[:to])
      rescue
      end
    end
  end

  def self.migrate
    Migrate.send(@db_conf[:to][:adapter], @db_conf[:from], @db_conf[:to])
  end

  def self.play
    mask(@db_conf[:to], @tasks)
  end

  def self.run(conf_path = 'config')
    setup(conf_path)
    operate_db('create')
    migrate
    play
  end


  private

  def self.build_url_without_db(data)
    "%{adapter}://%{host}:%{port}" % data
  end

  def self.build_url(data)
    "%{adapter}://%{host}:%{port}/%{database}" % data
  end

  def self.parse_mask(mask, binding)
    return mask unless mask.is_a?(String) && mask.start_with?('%=')

    # $SAFE = 1
    result = eval(mask[2..-1], binding)
    return result if result.is_a?(String) || result.is_a?(Integer)
    throw ArgumentError('wrong value type')
  end

  def self.mask(config, tasks)
    db = Sequel.connect(build_url(config))

    tasks.each do |table, task|
      table = db[table]
      task.each do |key, value|
        if key == :each
          value.each do |sub_k, sub_v|
            # Iterate table and update each item
            table.each { |row| table.where(id: row[:id]).update(sub_k => parse_mask(sub_v, binding)) }
          end
        else
          table.update(key => parse_mask(value, binding))
        end
      end
    end

    db.disconnect
  end
end
