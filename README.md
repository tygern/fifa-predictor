# FIFA Predictor

Predict who will win the next FIFA match.
The team with the highest number of goals and red cards wins.

## Development

1.  Configure Ruby and dependencies
    ```shell
    brew install ruby-install chruby
    ruby-install --latest
    ruby-install ruby 3.1.2
    chruby 3.1.2
    bin/bundle install
    ```

1.  Configure the database
    ```shell
    brew install postgresql
    brew services run postgresql
    bin/rake db:create
    bin/rake db:migrate
    ```

1.  Run tests and validate modules
    ```shell
    bin/bundle exec rspec
    bin/bundle exec packwerk validate
    ```

1.  Run the server at [localhost:3000](http://localhost:3000)
    ```shell
    bin/rails server
    ```

1.  View the dependency graph
    ```shell
    bin/rake pocky:generate && open packwerk.png
    ```