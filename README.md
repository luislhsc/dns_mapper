# README

## DNS MAPPER

This code challenge references to this [document](https://docs.google.com/document/d/1esrn0PTMPouEkJnOUT1AtW04TKmogZQCL_ADWcMPuJo/edit#heading=h.99prtuoh0vad) and follows
this [API doc](https://redocly.github.io/redoc/?url=https://bitbucket.org/cloudrupt/openapi-specs/raw/master/api_challange.yml)


### Key Takeaways
In this project, I had the following assumptions

1. The company currently have Monolith rails App:
   - As you will notice in my code, I'm not following the `Rails way` of doing things. Rails is great for fast prototype but has some drawbacks for large apps
    A common issue is "not having a place" to put our domain code and usually, we end up with a `Services` folder with hundreds of files. The same applies to Controllers and Models.
    I tried to have a more flexible structure that allows us to grow by splitting our code in bounded contexts. `Web` and `Domain` are two isolated layers with a clear separation of concerns. `UseCases` are the entry points to our domain and should have just one clear responsibility.
    I didn't add any bounded context here because the challenge is simple enough to keep it simple.

2. The database is huge:
    - The challenge is simple if you don't extrapolate it to millions of records. DB can be a huge bottleneck for a system like this.
     We have many options to structure our data here.

       - Tables with relationships:  We could do self-join queries, CTE and sub-queries.
       - Just one table with {ip, hostname}: Postgres has good support for FullText Search which can be very useful in this case.
        I didn't do many tests, but in my comparisons, the FullText Search with a GIN index was faster than the other options.
        Of course, I'm not taking into account the Read vs Write ratio, the max number of hostnames per IP, how often the same record is updated, etc.


That said, my code tries to apply concepts of SOLID, clean architecture, and domain-driven design.
It is hard to do with Rails because of its convention over configuration style but we can still apply some of these principles here.


### Tests
The tests are pretty simple, isolated whenever is possible and following the 4 (in this case 3) phase steps.
The Controller test is an integrated test that goes through the whole flow.
I just added a few tests to save some time.
Running tests:
First, create the test DB: `docker-compose run -e "RAILS_ENV=test" web bundle exec rake db:create`
Then run the tests: `docker-compose run -e "RAILS_ENV=test" web bundle exec rspec`



### How to run the app
`docker-compose build`

`docker-compose up`

You can use the API using Postman e.g. GET of `http://0.0.0.0:3000/dns_records?page=1&included=ipsum.com, dolor.com&excluded=sit.com`

The DB will be seeded with the examples in the doc.
##### GET cURL for the given example
`curl --location --request GET 'http://0.0.0.0:3000/dns_records?page=1&included=ipsum.com,%20dolor.com&excluded=sit.com'`
DB is already seeded.

##### POST cURL to add one extra record
`curl --location --request POST 'http://127.0.0.1:3000/dns_records' \
--header 'Content-Type: application/json' \
--data-raw '{
  "dns_records": {
    "ip": "6.6.6.6",
    "hostnames_attributes": [
      {
        "hostname": "lorem.com"
      },
      {
        "hostname": "ipsum.com"
      },
      {
        "hostname": "amet.com"
      }
    ]
  }
}'`
