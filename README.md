# NYCSchools

### Networking

Major components of the project, which are responsible for sending network requests are: 
- `Dispatchable` protocol and `Dispatcher` class. `Dispatcher` conforms to `Dispatchable` and allows
to send actual network request.
- `Endpoint` protocol. Allows to provide enough information for `Dispatcher` so that it can request the data 
(URL, HTTP method, HTTP headers etc).
- `Service` protocol. Provides a blueprint for the extendable networking services that are based on
dispatchers.

### Appearance

Application supports different styles for both Light and Dark modes.

### Documentation

Major components are documented. Descriptive comments are used whenever it makes sense to provide more clarity. 
Multi-level logging is used to provide more flexibility during troubleshooting.

### Testability

Entities are implemented with testability in mind. Some of the components (like `Dispatchable`) have 
been mocked and tested. Corectness of caching is verified by using unit-tests as well.
