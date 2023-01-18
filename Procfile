release: bin/rails db:migrate
web: bundle exec puma -C config/puma.rb
worker: QUEUE=default rake jobs:work
clock: bundle exec clockwork lib/clock.rb