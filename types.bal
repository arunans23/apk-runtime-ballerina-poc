import ballerina/http;
import ballerina/constraint;

public type NotAcceptableError record {|
    *http:NotAcceptable;
    Error body;
|};

public type UnsupportedMediaTypeError record {|
    *http:UnsupportedMediaType;
    Error body;
|};

public type ForbiddenError record {|
    *http:Forbidden;
    Error body;
|};

public type ConflictError record {|
    *http:Conflict;
    Error body;
|};

public type InternalServerErrorError record {|
    *http:InternalServerError;
    Error body;
|};

public type CreatedAPI record {|
    *http:Created;
    API body;
|};

public type PreconditionFailedError record {|
    *http:PreconditionFailed;
    Error body;
|};

public type NotFoundError record {|
    *http:NotFound;
    Error body;
|};

public type BadRequestError record {|
    *http:BadRequest;
    Error body;
|};

public type UnauthorizedError record {|
    *http:Unauthorized;
    Error body;
|};

public type ErrorListItem record {
    string code;
    # Description about individual errors occurred
    string message;
    # A detail description about the error message.
    string description?;
};

public type MediationPolicy record {
    string name;
    string 'type?;
};

public type ApiServiceinfo record {
    string name?;
};

public type Pagination record {
    int offset?;
    int 'limit?;
    int total?;
    # Link to the next subset of resources qualified.
    # Empty if no more resources are to be returned.
    string next?;
    # Link to the previous subset of resources qualified.
    # Empty if current subset is the first subset returned.
    string previous?;
};

public type GatewayList record {
    Gateway[] list?;
    Pagination pagination?;
};

public type Gateway record {
    # Name of the Gateway
    @constraint:String {maxLength: 255, minLength: 1}
    string name;
    # Protocol of the Listener
    @constraint:String {maxLength: 50, minLength: 1}
    string protocol;
    # Port of the Listener
    decimal port;
};

public type APIOperations record {
    string id?;
    string target?;
    string verb?;
    string[] scopes?;
    string payloadSchema?;
    string uriMapping?;
    APIOperationPolicies operationPolicies?;
};

public type APIOperationPolicies record {
    OperationPolicy[] request?;
    OperationPolicy[] response?;
    OperationPolicy[] fault?;
};

public type APIList record {
    # Number of APIs returned.
    int count?;
    APIInfo[] list?;
    Pagination pagination?;
};

public type MediationPolicyList record {
    MediationPolicy[] list?;
    Pagination pagination?;
};

public type PortMapping record {
    @constraint:String {maxLength: 255, minLength: 1}
    string name;
    string protocol?;
    int targetport;
    int port;
};

public type ApisImportdefinitionBody record {
    # Definition to upload as a file
    string file?;
    # Definition url
    string url?;
    # Additional attributes specified as a stringified JSON with API's schema
    string additionalProperties?;
    # Inline content of the API definition
    string inlineAPIDefinition?;
};

public type ApiidDefinitionBody record {
    # API definition of the API
    string apiDefinition?;
    # API definition URL of the API
    string url?;
    # API definitio as a file
    string file?;
};

public type ApisValidatedefinitionBody record {
    # API definition definition url
    string url?;
    # API definition as a file
    string file?;
    # API definition type - OpenAPI/AsyncAPI/GraphQL
    string 'type?;
    # Inline content of the API definition
    string inlineAPIDefinition?;
};

public type ServiceList record {
    Service[] list?;
    Pagination pagination?;
};

public type APIInfo record {
    string name?;
    string context?;
    string 'version?;
    string 'type?;
    string createdTime?;
    string updatedTime?;
};

public type Error record {
    int code;
    # Error message.
    string message;
    # A detail description about the error message.
    string description?;
    # Preferably an url with more details about the error.
    string moreInfo?;
    # If there are more than one error list them out.
    # For example, list out validation errors by each field.
    ErrorListItem[] 'error?;
};

public type Service record {
    @constraint:String {maxLength: 255, minLength: 1}
    string name;
    @constraint:String {maxLength: 255}
    string namespace;
    string 'type;
    PortMapping[] portmapping?;
};

public type SearchResult record {
    string id?;
    string name;
    # Accepted values are HTTP, WS, GRAPHQL
    string transportType?;
};

public type GraphQLSchema record {
    string name;
    string schemaDefinition?;
};

public type APIDefinitionValidationResponse record {
    # This attribute declares whether this definition is valid or not.
    boolean isValid;
    # OpenAPI definition content.
    string content?;
    # API definition information
    ApidefinitionvalidationresponseInfo info?;
    # If there are more than one error list them out.
    # For example, list out validation errors by each field.
    ErrorListItem[] errors?;
};

public type ApisImportBody record {
    # Zip archive consisting on exported API configuration
    string file;
};

public type OperationPolicy record {
    string policyName;
    string policyVersion = "v1";
    string policyId?;
    record {} parameters?;
};

public type API record {
    @constraint:String {maxLength: 60, minLength: 1}
    string name;
    @constraint:String {maxLength: 232, minLength: 1}
    string context;
    @constraint:String {maxLength: 30, minLength: 1}
    string 'version;
    # The api creation type to be used. Accepted values are HTTP, WS, GRAPHQL, WEBSUB, SSE, WEBHOOK, ASYNC
    string 'type = "HTTP";
    # Endpoint configuration of the API. This can be used to provide different types of endpoints including Simple REST Endpoints, Loadbalanced and Failover.
    # 
    # `Simple REST Endpoint`
    #   {
    #     "endpoint_type": "http",
    #     "sandbox_endpoints":       {
    #        "url": "https://pizzashack-service:8080/am/sample/pizzashack/v3/api/"
    #     },
    #     "production_endpoints":       {
    #        "url": "https://pizzashack-service:8080/am/sample/pizzashack/v3/api/"
    #     }
    #   }
    record {} endpointConfig?;
    APIOperations[] operations?;
    ApiServiceinfo serviceInfo?;
    string createdTime?;
    string lastUpdatedTime?;
};

# API definition information
public type ApidefinitionvalidationresponseInfo record {
    string name?;
    string 'version?;
    string context?;
    string description?;
    string openAPIVersion?;
    # contains host/servers specified in the API definition file/URL
    string[] endpoints?;
};
