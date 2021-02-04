# README

## DNS MAPPER

This code challenge references to this [document](https://docs.google.com/document/d/1esrn0PTMPouEkJnOUT1AtW04TKmogZQCL_ADWcMPuJo/edit#heading=h.99prtuoh0vad) and follows
this [API doc](https://redocly.github.io/redoc/?url=https://bitbucket.org/cloudrupt/openapi-specs/raw/master/api_challange.yml)


### Key Takeaways
In this project I had the following assumptions

1. The company currently have Monolith rails App:
   - As you will notice in my code, I'm not following the `Rails way` of doing things. Rails is great for fast prototype but has some drawbacks for large apps
    A common issue is "not having a place" to put our domain code and usually we end up with a `Services` folder with hundreds of files. Same applies with Controllers and Models.
    I tried to have a more flexible structure that allows us to grow by spliting our code in bounded contexts. `Web` and `Domain` are two isolated layers with clear separation of concerns. `UseCases` are our entrypoint to our domain and should have just one clear responsability.
    I didn't add any bounded context here because the test was simple enough to keep it simple.

2. The database is huge:
    - The challenge is simple if you don't extrapolate it to millions of records. DB can be a huge bottleneck for a system like this.
     We have many options to structure our data here.

       - Tables with relationships:  We could do self-join queries, CTE and sub-queries.
       - Just one table with {ip, hostname}: Postgres has a great support for FullText Search which can be very useful in this case.
        I didn't do many tests, but in my comparisons the FullText Search with a GIN index was faster than the other options.
        Of course, I'm not taking into account the Read vs Write ratio, the max number of hostnames per ip, how often the same record is updated, etc.


That said, my code tries to apply some conceps of clean architecture and domain driven design.
It is hard to do with Rails because of its convention over configuration style but we can still apply some of these principles here.


### Tests
The tests are pretty simple, isolated whenever is possible and following the 4 (in this case 3) phase steps.
The Controller test is a integrated test that goes throught the whole flow.
I just added a few tests to save some time.
To run the tests you can use `docker-compose run bundle exec rspec`


### How to run
`docker-compose build`

`docker-compose up`

You can use the API using Postman e.g. GET of `http://0.0.0.0:3000/dns_records?page=1&included=ipsum.com, dolor.com&excluded=sit.com`
The DB will be seeded with the doc examples.

