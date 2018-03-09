# api.madgrades.com

A REST interface for UW Madison course data, powered by Rails. This README is for setting up your own Madgrades API and is not designed to help you navigate the website.

## Usage

**Prerequisites:**

* Ruby 2.5+, and bundler gem
* Elasticsearch 5+ @ `localhost:9200`

1. `gem install bundler`
2. Setup the `config/database.yml` file to point to a working database.
3. Run migrations: `rake db:create && rake db:migrate`
4. Test it out: `rails s` and visit `http://localhost:3000`
5. Populate the database with real data (see below)
6. Setup API authentication (see below)

## Data

The data for the API should be populated from an external source. The [madgrades](https://github.com/thekeenant/madgrades) project exports tables in SQL dump format which can imported easily into this API using the following command (assuming MySQL database, which is the default, but others would likely work too):

```sh
$ cat *.sql | mysql -p -u <username> madgrades_dev
```

This can take a long time (5+ minutes, longer on slower computers). Alternatively, you can export the data to CSV files and import using tools/methods that you prefer.

> *Note:* In order to import large SQL dumps, you may have to tune up your SQL server settings or else you may get an error like: `MySQL server has gone away`. Set `max_allowed_packet = 1G` _temporarily_ in your `mysqld.conf` or `my.cnf` depending on your operating system. It is dangerous to keep this setting, so revert it back to ~16M once imported.


## API Authentication

You will notice that inside `config/initializers/omniauth.rb` there are two providers listed: Google and Github. To support both you must create your own developer applications on both of these services and put them in your environment variables before executing the app. When creating your application, it is only important that your callback is listed as:

* Github: `http://localhost:3000/auth/github/callback`
* Google: `http://localhost:3000/auth/google_oauth2/callback`

If you are not running on `localhost:3000`, make sure you reflect that in your Google or Github dev apps.
