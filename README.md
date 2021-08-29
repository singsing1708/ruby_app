# webserver log parser

### running test cases

```
$ bundle install
$ rspec
```

## Comment

- Think of the memory usage and the performance, the balance is between memory usage and the data should be reuse later on
- For MemoryParser
  - Advantages
    - data can re-use later without further calculation
  - Disadvantages
    - consumed too much memory, may fail if the file size is too huge
- For InlineParser
  - the requested data is calculate on request, data will be clean up after return. Trade off processing time with memory
  - Advantages
    - no memory keep in store
  - Disadvantages
    - still require huge memory during processing
    - every time requesting result will require processing
- Alternative
   - may use other way for storing the result, if processing time is allow, can try using database or other log analyser
   - when reading each line, +1 to number_of_view column in table
   - this can off load the storing of result to db
   - however the process time will be much longer than memory      

- Function wise
  - benchmarking on the memory usage for 2 different parser
  - for MemoryParser, data should be calculated and stored when needed
  - can add function with GeoIP mapping to IP
  - can add asc / desc ordering to page view
  - can add param to function to clean ip the result data or not. With the function to add new files can accumulate the data for analysis
