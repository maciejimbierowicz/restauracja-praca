
TRUNCATE cache_bootstrap;
TRUNCATE cache_config;
TRUNCATE cache_container;
TRUNCATE cache_data;
TRUNCATE cache_default;
TRUNCATE cache_discovery;
TRUNCATE cache_dynamic_page_cache;
TRUNCATE cache_entity;
TRUNCATE watchdog;
TRUNCATE batch;
TRUNCATE sessions;
TRUNCATE flood;

UPDATE users_field_data set
                            name = concat('user_', uid),
                            pass = '',
                            mail = concat(SUBSTRING(MD5(UUID()),1,15), '@example.com'),
                            init = concat(SUBSTRING(MD5(UUID()),1,15), '@example.com')
where uid > 2;