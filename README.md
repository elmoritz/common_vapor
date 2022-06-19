# CommonVapor

This Package contains different Helper or convenience extensions to simplify your life with Vapor.

currently contains:
- Responding-protocol
  - to wrap any 'Content' in a usable Response
  - to wrap Errors in an ErrorReport, which in turn will result in a Response

- Request-extension:
    - adds the convenient functions to call request.client.get directly on the request
    
- ModuleInterface
    - ease of use to create a Module


## Responding-Protocol
### Motivation:
I had the Issue of returning object confirming to the 'Content' -Protocol, which is easy if you add the protocol confirmance, but what do you do with errors?
I converted all my returned Objects into a Response object first, but thought this step shouldbe way more easier. So I created the Responding-Protocol, to help wrapp Content into a Response.

### Example
This is a helper to wrap all 'Content' in a Vapor 'Response' with
'''
struct GeneralRequestHandler: Responding {
    func index(req: Request) async throws -> Response {
        do {
            let object: Content = try contentCreatedForThisResponse()
            return wrap(object)
        } catch {
            return wrapError(error)
        }
    }
'''

### Explanation
The Responding-Protocol adds 4 methods, which you can use.
One for Content-wrapping:
- wrapping Content -> 'func wrap<C: Content>(_ object: C) -> Response'
Thre for Error wrapping:
- wrapping Standard Error -> 'func wrapError<E: Error>(_ error: E) -> Response'
- wrapping extended Error (ErrorReposrtContentful) -> 'func wrapErrorReport<R: ErrorReportContentful>(_ errorReport: R) -> Response'
- wrapping extended Error (ExtendedError) -> 'func wrapExtendedError<E: ExtendedError>(_ extendedError: E) -> Response'
Every method will return a Response-object, which should make it easy to use.

## Request+Client Extension
### Motivation
In one project of mine, I frequently access a third-party-server and for this I wrote a few helper functions. Since I needed these functions for more and more Projects I included them into this little Package.

### Example
Instead of using 
'''
    {request}.client.get(url)
'''
you can use
'''
    {request}.get(url)
'''
And this will work for all http methods


