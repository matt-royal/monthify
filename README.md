# Monthify

Monthify provides a Month class in a similar style to Date and Time.

## Installation

Add this line to your application's Gemfile:

    gem 'monthify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install monthify

## Usage

Here are some example usages of the Month class.

    this_month = Month.current
    last_month = Month.containing(1.month.ago)

    # all of these statements are true...
    this_month > last_month
    (last_month + 1.month) == this_month
    last_month.next == this_month
    this_month.previous == last_month

    jan_2012 = Month.new(2012, 1)
    # these are also true...
    jan_2012.first_day == Date.new(2012, 1, 1)
    jan_2012.last_day == Date.new(2012, 1, 31)
    jan_2012.first_moment == jan_2012.first_date.beginning_of_day
    jan_2012.last_moment == jan_2012.last_date.end_of_day

### Conversions

####Object#to_month

    Date.today.to_month == Month.current
    Time.now.to_month == Month.current

####Month()

This is equivalent to calling #to_month

    Month(Date.today) == Month.current

### ActiveRecord integration
To treat a field in an ActiveRecord model like a month, do the following:

1. Create a Date column on the table with the same name as the field you want
2. Tell the model to serialize that field as a Month

an example...

    # in db/migrate/20121023060410_add_month_billed_to_statements.rb
    
    def up
      add_column :statements, :month_billed, :date
    end
    

    # in app/models/statement.rb

    serialize :month_billed, Month

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
