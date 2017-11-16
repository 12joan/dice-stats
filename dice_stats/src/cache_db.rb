require 'json'
require 'sqlite3'

module CacheDb
  def self.cache_set(cache_class, cache_set_class)
    cache_set_class.new(caches(cache_class))
  end

  def self.caches(cache_class)
    caches = db.execute("select * from caches").map { |cache_data|
      cache_class.new(JSON.parse(cache_data[0]), cache_data[1])
    }
  end

  def self.save_cache(cache, cache_class)
    caches(cache_class).each do |existing_cache|
      if cache == existing_cache then
        return
      end
    end

    id = cache.id.to_json.gsub('"', '')
    results = cache.results.gsub('"', '')
    db.execute("insert into caches (id, results) values (\"#{id}\", \"#{results}\")")
  end
  
  def self.db
    SQLite3::Database.new File.join(__dir__, "..", "db", "cache.db")
  end
end

