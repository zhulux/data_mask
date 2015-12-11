module Migrate
  def self.postgres(from, to)
    remote = "pg_dump -h %{host} -p %{port} -U %{user} %{database}" % from
    local = "psql -p %{port} %{database}" % to
    system "#{remote} | #{local}"
  end

  def self.mysql(from, to)
    remote = "mysqldump -h %{host} -P %{port} -u %{user} %{database}" % from
    local = "mysql -P %{port} %{database}" % to
    system "#{remote} | #{local}"
  end
end